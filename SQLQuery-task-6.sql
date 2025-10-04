SELECT 
    orderID, CustomerID, Amount
FROM Orderss
WHERE Amount > (
    SELECT AVG(Amount) FROM Orderss
);

SELECT 
    o1.orderID,
    o1.CustomerID,
    o1.Amount
FROM Orderss o1
WHERE Amount > (
    SELECT AVG(o2.Amount)
    FROM Orderss o2
    WHERE o2.CustomerID = o1.CustomerID
);

SELECT CustomerName, City
FROM Customers
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID FROM orderss
);

SELECT CustomerName, City
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM orderss o
    WHERE o.CustomerID = c.CustomerID
      AND o.Amount > 5000
);


SELECT CustomerID, SUM(Amount) AS TotalSpent
FROM orderss
GROUP BY CustomerID
HAVING SUM(Amount) = (
    SELECT MAX(TotalSpent)
    FROM (
        SELECT SUM(Amount) AS TotalSpent
        FROM orderss
        GROUP BY CustomerID
    ) AS Sub
);

