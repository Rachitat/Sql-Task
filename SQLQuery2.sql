------------------------------------------------
-- 1. CREATE DATABASE AND USE IT
------------------------------------------------
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ecommerce2db')
BEGIN
    CREATE DATABASE ecommerce2db;
END
GO

USE ecommerce2db;
GO

------------------------------------------------
-- 2. CREATE TABLES
------------------------------------------------

-- PRODUCTS TABLE
IF OBJECT_ID('products', 'U') IS NOT NULL DROP TABLE products;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name NVARCHAR(100) NOT NULL,
    category NVARCHAR(50),
    price DECIMAL(10,2),
    stock INT DEFAULT 0
);

-- CUSTOMERS TABLE
IF OBJECT_ID('shop_customers', 'U') IS NOT NULL DROP TABLE shop_customers;
CREATE TABLE shop_customers (
    customer_id INT PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE,
    phone NVARCHAR(15),
    city NVARCHAR(50) DEFAULT 'Unknown'
);

-- CARTS TABLE (FK to customers)
IF OBJECT_ID('carts', 'U') IS NOT NULL DROP TABLE carts;
CREATE TABLE carts (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    created_date DATE DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES shop_customers(customer_id)
);

-- CART ITEMS TABLE (FK to carts + products)
IF OBJECT_ID('cart_items', 'U') IS NOT NULL DROP TABLE cart_items;
CREATE TABLE cart_items (
    cart_item_id INT PRIMARY KEY,
    cart_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    FOREIGN KEY (cart_id) REFERENCES carts(cart_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

------------------------------------------------
-- 3. INSERT DATA
------------------------------------------------

-- PRODUCTS
INSERT INTO products (product_id, product_name, category, price, stock)
VALUES (101, 'Smartphone', 'Electronics', 15000, 50);

INSERT INTO products (product_id, product_name, category, price) 
VALUES (102, 'Headphones', 'Electronics', 2000);  -- stock defaults to 0

INSERT INTO products (product_id, product_name, category, price, stock)
VALUES (103, 'Office Chair', 'Furniture', 5000, NULL); -- stock explicitly NULL

-- CUSTOMERS
INSERT INTO shop_customers (customer_id, full_name, email, phone, city)
VALUES (1, 'Ravi Kumar', 'ravi@example.com', '9876543210', 'Delhi');

INSERT INTO shop_customers (customer_id, full_name, email, phone)
VALUES (2, 'Sneha Sharma', 'sneha@example.com', '9123456789'); -- city default Unknown

INSERT INTO shop_customers (customer_id, full_name, email, phone, city)
VALUES (3, 'Amit Singh', 'amit@example.com', '9988776655', NULL); -- explicit NULL city

-- CARTS
INSERT INTO carts (cart_id, customer_id)
VALUES (501, 1);  -- created_date defaults to GETDATE()

INSERT INTO carts (cart_id, customer_id, created_date)
VALUES (502, 2, '2025-09-20'); -- custom date

-- CART ITEMS
INSERT INTO cart_items (cart_item_id, cart_id, product_id, quantity)
VALUES (9001, 501, 101, 2);

INSERT INTO cart_items (cart_item_id, cart_id, product_id)
VALUES (9002, 501, 102);  -- quantity default 1

INSERT INTO cart_items (cart_item_id, cart_id, product_id, quantity)
VALUES (9003, 502, 103, NULL); -- quantity NULL explicitly

------------------------------------------------
-- 4. UPDATE DATA
------------------------------------------------
-- Update stock for Office Chair where NULL
UPDATE products
SET stock = 20
WHERE product_id = 103;

-- Update Amit Singh’s city
UPDATE shop_customers
SET city = 'Kolkata'
WHERE customer_id = 3;

-- Update cart item quantity where NULL
UPDATE cart_items
SET quantity = 3
WHERE cart_item_id = 9003;

------------------------------------------------
-- 5. DELETE DATA
------------------------------------------------
-- Delete a product (if no FK constraint stops it)
DELETE FROM products
WHERE product_id = 102;

-- Delete a cart
DELETE FROM carts
WHERE cart_id = 502;

-- Delete customers who are from Unknown city
DELETE FROM shop_customers
WHERE city = 'Unknown';

------------------------------------------------
-- 6. CHECK FINAL DATA
------------------------------------------------
SELECT * FROM products;
SELECT * FROM shop_customers;
SELECT * FROM carts;
SELECT * FROM cart_items;