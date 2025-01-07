-- create ecommerce database

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- create the customers table

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

-- create the order_items table for normalization
CREATE TABLE IF NOT EXISTS order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT NOT NULL,
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
('Mango', 30.00, 'Ripe mangoes are juicy, fleshy, and delicious.'),
('Strawberry', 50.00, 'Strawberries are soft, sweet, bright red berries.'),
('Jackfruit', 80.00, 'Jackfruit has a very chewy, stringy texture and unique.');

--Insert sample date - orders table
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '02-01-2025', 120.00),
(2, '08-01-2025', 150.00),
(3, '04-01-2025', 240.00);

--Insert sample data - order_items table
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 4),
(3, 1, 1);