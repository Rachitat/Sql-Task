CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

INSERT INTO Departments VALUES
(1, 'HR'), (2, 'Finance'), (3, 'IT');

INSERT INTO Employees VALUES
(101, 'Amit', 1, 50000),
(102, 'Neha', 2, 65000),
(103, 'Ravi', 3, 80000),
(104, 'Priya', 2, 72000);

CREATE VIEW vw_EmployeeDetails AS
SELECT 
    e.EmpID,
    e.EmpName,
    d.DeptName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 60000;


SELECT * FROM vw_EmployeeDetails;
