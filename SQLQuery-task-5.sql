-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

-- Create Orders Table
CREATE TABLE Orderss(
    orderID INT PRIMARY KEY,
    orderDate DATE,
    Amount DECIMAL(10,2),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
);
-- Insert Customers
INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Chicago'),
(3, 'Charlie', 'Houston'),
(4, 'David', 'Miami');

-- Insert Orders
INSERT INTO Orderss (orderID, orderDate, Amount, CustomerID) VALUES
(101, '2025-10-01', 250.00, 1),
(102, '2025-10-02', 450.00, 2),
(103, '2025-10-02', 300.00, 1),
(104, '2025-10-03', 500.00, 3);

SELECT C.CustomerID, C.CustomerName, O.orderID, O.Amount
FROM Customers C
INNER JOIN Orderss O ON C.CustomerID = O.CustomerID;

SELECT C.CustomerID, C.CustomerName, O.orderID, O.Amount
FROM Customers C
LEFT JOIN Orderss O ON C.CustomerID = O.CustomerID;


SELECT C.CustomerID, C.CustomerName, O.OrderID, O.Amount
FROM Customers C
RIGHT JOIN Orderss O ON C.CustomerID = O.CustomerID;


