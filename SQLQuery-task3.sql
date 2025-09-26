CREATE DATABASE EcommerceDB;
GO
USE EcommerceDB;
GO

CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(20),
    address NVARCHAR(255),
    city NVARCHAR(50),
    state NVARCHAR(50),
    postal_code NVARCHAR(20),
    country NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'Pending',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
);
GO
CREATE TABLE orderitems (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,       -- can link to a products table later
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE
);
GO
CREATE TABLE orderitems (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,       -- can link to a products table later
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE
);
GO
CREATE TABLE payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    payment_method NVARCHAR(50),
    amount DECIMAL(10,2) NOT NULL,
    status NVARCHAR(20) DEFAULT 'Completed',
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE
);
GO

INSERT INTO customers (first_name, last_name, email, phone, address, city, state, postal_code, country)
VALUES ('John', 'Doe', 'john.doe@email.com', '9876543210', '123 Main St', 'Delhi', 'Delhi', '110001', 'India');

INSERT INTO orders (customer_id, status, total_amount)
VALUES (1, 'Pending', 2500.00);

INSERT INTO orderitems (order_id, product_id, quantity, price)
VALUES (1, 101, 2, 1250.00);

INSERT INTO payments (order_id, payment_method, amount, status)
VALUES (1, 'Credit Card', 2500.00, 'Completed');


SELECT * FROM customers;


SELECT first_name, last_name, email FROM customers;

SELECT * FROM orders
WHERE status = 'Pending';


SELECT c.first_name, c.last_name, o.order_id, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

UPDATE customers
SET phone = '9998887776'
WHERE customer_id = 1;

UPDATE orders
SET status = 'Shipped'
WHERE order_id = 1;

UPDATE payments
SET status = 'Refunded'
WHERE payment_id = 1;

DELETE FROM orderitems
WHERE order_item_id = 1;

DELETE FROM customers
WHERE customer_id = 1;


SELECT * FROM customers
WHERE city = 'Delhi' AND country = 'India';   -- both conditions true

SELECT * FROM customers
WHERE city = 'Delhi' OR city = 'Mumbai';     -- any one true


SELECT * FROM customers
WHERE first_name LIKE 'J%';  -- names starting with J

SELECT * FROM orders
WHERE total_amount BETWEEN 1000 AND 3000;

SELECT * FROM customers
ORDER BY first_name;

SELECT * FROM orders
ORDER BY total_amount DESC;


SELECT * FROM customers
ORDER BY city ASC, last_name ASC;

SELECT c.first_name, c.last_name, o.order_id, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_amount BETWEEN 1000 AND 3000
  AND c.first_name LIKE 'J%'
ORDER BY o.total_amount DESC;




INSERT INTO customers (first_name, last_name, email, phone) VALUES
('John', 'Doe', 'john@example.com', '9876543210'),
('Jane', 'Smith', 'jane@example.com', '9123456780'),
('Amit', 'Kumar', 'amit@example.com', '9000011111'),
('Sara', 'Lee', 'sara@example.com', '9000022222');

INSERT INTO orders (customer_id, status, total_amount) VALUES
(1, 'Pending', 2500.00),
(1, 'Shipped', 3200.00),
(2, 'Pending', 1800.00),
(3, 'Delivered', 4500.00),
(4, 'Pending', 1200.00);


INSERT INTO payments (order_id, payment_method, amount) VALUES
(1, 'Credit Card', 2500.00),
(2, 'UPI', 3200.00),
(3, 'Debit Card', 1800.00),
(4, 'Credit Card', 4500.00),
(5, 'Cash', 1200.00);
GO






SELECT 
  c.first_name,
  c.last_name,
  COUNT(o.order_id) AS total_orders,
  SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name
HAVING SUM(o.total_amount) > 2000
ORDER BY total_spent DESC;








