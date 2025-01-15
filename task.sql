-- create ecommerce database

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- create the customers, products and orders table

CREATE TABLE IF NOT EXISTS customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  address TEXT NOT NULL
  );

CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  description TEXT,
  discount DECIMAL(5, 2) DEFAULT 0.00
);

CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  order_date DATE NOT NULL,
  total_amount DECIMAL (10,2) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
  );

-- create order_items table
CREATE TABLE IF NOT EXISTS order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT NOT NULL,
  price DECIMAL (10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- insert sample data - customers table
INSERT INTO customers (name, email, address) VALUES
('Mohan Raj', 'mohanraj@gmail.com', '321 Anna street'),
('Jagan Raj', 'jaganraj@gmail.com', '654 Periyar street'),
('Subbu Raj', 'subburaj@gmail.com', '987 abdulkalam street');

-- insert sample data - products table
INSERT INTO products (name, price, description) VALUES
('Product A', 30.00, 'Ripe mangoes are juicy, fleshy, and delicious.'),
('Product B', 50.00, 'Strawberries are soft, sweet, bright red berries.'),
('Product C', 80.00, 'Jackfruit has a very chewy, stringy texture and unique.');

--Insert sample date - orders table
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-01-02', 120.00),
(2, '2025-01-08', 150.00),
(3, '2025-01-04', 240.00);

--Insert sample data - order_items table
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 4),
(3, 1, 1);

-- query 1 - Retrieve all customers regarding who have ordered in the last 30 days

SELECT DISTINCT c.name, c.email
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;

-- Query 2 - Get the total amount of all orders placed by each customer

SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;

-- Query 3 - Update the price of Product C to 45.00

UPDATE products
SET price = 45.00
WHERE name = 'Product C';

-- Query 4 - Add a new column discount to the products table

ALTER TABLE products
ADD COLUMN discount DECIMAL(5, 2) DEFAULT 0.00;

-- Query 5 - Retrieve the top 3 products with the highest price

SELECT *
FROM products
ORDER BY price DESC
LIMIT 3

-- Query 6 - Get the names of customers who have ordered Product A

SELECT DISTINCT c.name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.name = 'Product A';

-- Query 7 - Join the orders and customers tables to retrieve the customer's name and order date for each order

SELECT c.name, o.order_date
FROM customers c
JOIN orders o ON c.id = o.customer_id;

-- Query 8 - Retrieve the orders with a total amount greater than 150.00

SELECT *
FROM orders
WHERE total_amount > 150.00;

-- Query 9 - Normalization done in above -> Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table

-- calculated from order_items
ALTER TABLE orders
DROP COLUMN total_amount;

-- Query 10 - Retrieve the average total of all orders

SELECT AVG (total_amount) AS average_order_total
FROM orders;

