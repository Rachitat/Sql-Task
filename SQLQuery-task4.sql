IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
    DROP TABLE dbo.Orders;
GO

-- Create Orders table
CREATE TABLE dbo.Orders (
    OrderID INT PRIMARY KEY,
    CustomerID VARCHAR(10),
    ProductID VARCHAR(10),
    Quantity INT,
    Price DECIMAL(10,2),
    OrderDate DATE
);
GO


INSERT INTO dbo.Orders (OrderID, CustomerID, ProductID, Quantity, Price, OrderDate) VALUES
(1, 'C01', 'P01', 3, 200.00, '2025-09-20'),
(2, 'C02', 'P01', 2, 200.00, '2025-09-20'),
(3, 'C01', 'P02', 1, 500.00, '2025-09-21'),
(4, 'C03', 'P03', 5, 100.00, '2025-09-22'),
(5, 'C02', 'P02', 4, 500.00, '2025-09-22'),
(6, 'C01', 'P03', 2, 100.00, '2025-09-23');
GO


SELECT CustomerID,
       SUM(Quantity) AS Total_Quantity
FROM dbo.Orders
GROUP BY CustomerID;

SELECT CustomerID,
       AVG(Quantity * Price) AS Avg_Order_Value
FROM dbo.Orders
GROUP BY CustomerID;

SELECT CustomerID,
       COUNT(OrderID) AS Total_Orders
FROM dbo.Orders
GROUP BY CustomerID;

SELECT ProductID,
       SUM(Quantity * Price) AS Total_Sales
FROM dbo.Orders
GROUP BY ProductID;

SELECT ProductID,
       SUM(Quantity * Price) AS Total_Sales
FROM dbo.Orders
GROUP BY ProductID
HAVING SUM(Quantity * Price) > 500;


SELECT OrderDate,
       SUM(Quantity * Price) AS Daily_Sales,
       COUNT(OrderID) AS Orders_Count
FROM dbo.Orders
GROUP BY OrderDate
ORDER BY OrderDate;





