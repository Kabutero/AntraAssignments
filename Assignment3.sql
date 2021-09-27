--1. JOIN is preferable as it is better performance-wise
--2. Common Table Expression. Used for multiple aggregations
--3. Table variables are variables declared for use in select statements. Their scope is local global and they are stored in temp
--4. DELETE works on specified rows, TRUNCATE works on the whole table
--5. Identity column is one that starts at a value and increments based on a selected value. TRUNCATE will reset the identity value to the base, while DELETE keeps the value where it is
--6. DELETE FROM table_name will not run without a WHERE clause as it deletes specific rows; TRUNCATE table table_name runs and deletes all rows, but not the table itself

--SQL Queries
--1.
SELECT DISTINCT City
FROM Customers
WHERE City IN(
	SELECT City
	FROM Employees
)

--2a.
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN(
	SELECT City
	FROM Employees
)
--b.
SELECT DISTINCT c.City
FROM Customers c LEFT OUTER JOIN Employees e ON c.City = e.City

--3.
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

--4.
SELECT c.City, SUM(od.Quantity) AS QuantityOrdered
FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID JOIN Customers c ON o.ShipCity = c.City
GROUP BY c.City
ORDER BY SUM(od.Quantity) DESC
--5a.

--b.
SELECT DISTINCT City
FROM Customers
WHERE City IN (
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(City) > 2
)
--c.(Using neither subquery or union
SELECT DISTINCT City
FROM Customers
GROUP BY City
HAVING COUNT(City) > 2

--6.
SELECT DISTINCT City
FROM Customers
WHERE City IN(
	SELECT ShipCity
	FROM Orders
	GROUP BY ShipCity
	HAVING COUNT(*) > 2
)
--7.
SELECT DISTINCT c.ContactName, c.City, o.ShipCity
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City != o.ShipCity

--8.
SELECT TOP 5 SUM(od.Quantity), p.ProductID, p.ProductName, AVG(od.UnitPrice) AS AvgPrice
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName

--9a.
SELECT DISTINCT City
FROM Employees
WHERE City NOT IN(
	SELECT ShipCity
	FROM Orders
)
--b.
SELECT DISTINCT e.City
FROM Employees e LEFT OUTER JOIN Orders o ON e.City = o.ShipCity
WHERE o.ShipCity IS NULL

--10.
--join orders and employee, subquery city in 
SELECT City
FROM 
--11.
--DELETE *
--FROM table
--HAVING COUNT(*) > 1

--12.
CREATE TABLE Employee(
	empid int,
	mgrid int,
	deptid int,
	salary money
);
CREATE TABLE Dept(
	deptid integer,
	deptname varchar(20)
)
SELECT empid
FROM Employee
WHERE empid NOT IN(
	SELECT mgrid
	FROM Employee
)

--13.
SELECT TOP COUNT(e.deptid), d.deptname
FROM Employee e JOIN Dept d ON e.deptid = d.deptid

--14.
SELECT TOP 3 MAX(e.salary), d.deptname, e.empid
FROM Employee e JOIN Dept d ON e.deptid = d.deptid
GROUP BY d.deptname, e.empid
ORDER BY MAX(e.salary) DESC

