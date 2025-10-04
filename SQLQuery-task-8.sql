CREATE PROCEDURE GetOrdersByAmount
    @Amount DECIMAL(10,2),
    @FilterType VARCHAR(10)  -- 'ABOVE' or 'BELOW'
AS
BEGIN
    IF @FilterType = 'ABOVE'
        SELECT orderID, CustomerID, Amount
        FROM orderss
        WHERE Amount > @Amount;

    ELSE IF @FilterType = 'BELOW'
        SELECT orderID, CustomerID, Amount
        FROM orderss
        WHERE Amount < @Amount;

    ELSE
        PRINT 'Invalid FilterType. Use ABOVE or BELOW.';
END;


/*EXEC GetOrdersByAmount @Amount = 500, @FilterType = 'ABOVE';*/





CREATE FUNCTION fn_GetCustomerTotal(@CustomerID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);

    SELECT @Total = SUM(Amount)
    FROM orderss
    WHERE CustomerID = @CustomerID;

    RETURN ISNULL(@Total, 0);
END;


SELECT 
    CustomerID,
    CustomerName,
    dbo.fn_GetCustomerTotal(CustomerID) AS TotalSpent
FROM Customers;

CREATE FUNCTION fn_SpendingCategory(@CustomerID INT)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);
    DECLARE @Category VARCHAR(20);

    SELECT @Total = SUM(Amount)
    FROM orderss
    WHERE CustomerID = @CustomerID;

    IF @Total >= 8000
        SET @Category = 'High Spender';
    ELSE IF @Total BETWEEN 4000 AND 7999
        SET @Category = 'Medium Spender';
    ELSE
        SET @Category = 'Low Spender';

    RETURN ISNULL(@Category, 'No Orders');
END;


SELECT 
    CustomerName,
    dbo.fn_SpendingCategory(CustomerID) AS Category
FROM Customers;



SELECT dbo.fn_GetCustomerTotal(1) AS TotalSpent;

SELECT CustomerID, CustomerName, dbo.fn_GetCustomerTotal(CustomerID) AS TotalSpent
FROM Customers;

CREATE FUNCTION fn_GetHighValueOrders(@MinAmount DECIMAL(10,2))
RETURNS TABLE
AS
RETURN (
    SELECT OrderID, CustomerID, Amount
    FROM orderss
    WHERE Amount > @MinAmount
);


SELECT * FROM dbo.fn_GetHighValueOrders(550);


