/* =========================================
   Online Retail Sales Database
   Normalized to 3NF
   ========================================= */

-- Create Database
CREATE DATABASE online_retail_sales;
USE online_retail_sales;

-- ========================
-- Customers Table
-- ========================
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ========================
-- Products Table
-- ========================
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0)
);

-- ========================
-- Orders Table
-- ========================
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(20),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ========================
-- Order Items Table
-- ========================
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ========================
-- Payments Table
-- ========================
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- =========================================
-- Sample Data Insertion
-- =========================================

-- Customers
INSERT INTO customers (full_name, email, phone, address)
VALUES
('Amit Sharma', 'amit@gmail.com', '9876543210', 'Mumbai'),
('Priya Patel', 'priya@gmail.com', '9123456789', 'Ahmedabad'),
('Rahul Verma', 'rahul@gmail.com', '9988776655', 'Delhi');

-- Products
INSERT INTO products (product_name, category, price, stock_quantity)
VALUES
('Laptop', 'Electronics', 55000, 10),
('Headphones', 'Electronics', 2500, 50),
('Office Chair', 'Furniture', 7000, 15);

-- Orders
INSERT INTO orders (customer_id, order_status, total_amount)
VALUES
(1, 'CONFIRMED', 57500),
(2, 'CONFIRMED', 7000);

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 55000),
(1, 2, 1, 2500),
(2, 3, 1, 7000);

-- Payments
INSERT INTO payments (order_id, payment_method, payment_status)
VALUES
(1, 'Credit Card', 'SUCCESS'),
(2, 'UPI', 'SUCCESS');

-- =========================================
-- JOIN Queries (Reports)
-- =========================================

-- 1. Customer Order Details
SELECT 
    c.full_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- 2. Order Item Details
SELECT 
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.price
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id;

-- 3. Total Sales Per Customer
SELECT 
    c.full_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name;

-- =========================================
-- Views for Sales Reports
-- =========================================

-- View: Sales Summary
CREATE VIEW sales_summary AS
SELECT 
    o.order_id,
    c.full_name AS customer_name,
    o.order_date,
    o.total_amount,
    p.payment_method,
    p.payment_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN payments p ON o.order_id = p.order_id;

-- View: Product Sales Report
CREATE VIEW product_sales_report AS
SELECT 
    pr.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
GROUP BY pr.product_name;
