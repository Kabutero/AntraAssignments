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
--1. CORRECT:
select distinct city 
from Customers 
where city in (select city from Employees)

--2a.
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN(
	SELECT City
	FROM Employees
)
--2a. CORRECT:
select distinct city  
from Customers 
where City not in (select distinct city from employees where city is not null)

--b.
SELECT DISTINCT c.City
FROM Customers c LEFT OUTER JOIN Employees e ON c.City = e.City
--b. CORRECT:
select distinct city from Customers  
except 
select distinct city from Employees

--3.
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;
--3. CORRECT:
select ProductID,SUM(Quantity) as QunatityOrdered 
from [order details]
group by ProductID

--4.
SELECT c.City, SUM(od.Quantity) AS QuantityOrdered
FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID JOIN Customers c ON o.ShipCity = c.City
GROUP BY c.City
ORDER BY SUM(od.Quantity) DESC
--4. CORRECT:
select city,sum(Quantity) as TotalQty 
from orders o join [order details] od on o.orderid=od.orderid join customers c on c.customerid=o.CustomerID
group by city

--5a.
SELECT DISTINCT City
FROM Customers
HAVING COUNT(City) > 1
UNION
SELECT DISTINCT CITY
FROM Customers
HAVING COUNT(City) > 1
--5a. CORRECT:
select city from Customers
except
select city from customers
group by city
having COUNT(*)=1
union 
select city from customers
group by city
having COUNT(*)=0

--b.
SELECT DISTINCT City
FROM Customers
WHERE City IN (
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(City) > 2
)
--b. CORRECT:
select city 
from customers 
group by city 
having COUNT(*)>=2

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
--6. CORRECT:
select distinct city 
from orders o join [order details] od on o.orderid=od.orderid join customers c on c.customerid=o.CustomerID
group by city,ProductID
having COUNT(*)>=2

--7.
SELECT DISTINCT c.ContactName, c.City, o.ShipCity
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City != o.ShipCity
--7. CORRECT:
select distinct c.CustomerID 
from orders o join [order details] od on o.orderid=od.orderid join customers c on c.customerid=o.CustomerID
where City <> ShipCity

--8.
SELECT TOP 5 SUM(od.Quantity), p.ProductID, p.ProductName, AVG(od.UnitPrice) AS AvgPrice
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
--8. CORRECT:
select top 5 ProductID,AVG(UnitPrice) as AvgPrice,(select top 1 City from Customers c join Orders o on o.CustomerID=c.CustomerID join [Order Details] od2 on od2.OrderID=o.OrderID where od2.ProductID=od1.ProductID group by city order by SUM(Quantity) desc) as City from [Order Details] od1
group by ProductID 
order by sum(Quantity) desc

--9a.
SELECT DISTINCT City
FROM Employees
WHERE City NOT IN(
	SELECT ShipCity
	FROM Orders
)
--CORRECT:
select distinct City from Employees where city not in (select ShipCity from Orders where ShipCity is not null)

--b.
SELECT DISTINCT e.City
FROM Employees e LEFT OUTER JOIN Orders o ON e.City = o.ShipCity
WHERE o.ShipCity IS NULL
--CORRECT:
select distinct City from Employees where City is not null except (select ShipCity from Orders where ShipCity is not null)

--10.
--join orders and employee, subquery city in 
SELECT City
FROM 
--CORRECT:
select (select top 1 City from Orders o join [Order Details] od on o.OrderID=od.OrderID join Employees e on e.EmployeeID = o.EmployeeID
group by e.EmployeeID,e.City
order by COUNT(*) desc) as MostOrderedCity,
(select top 1 City from Orders o join [Order Details] od on o.OrderID=od.OrderID join Employees e on e.EmployeeID = o.EmployeeID
group by e.EmployeeID,e.City
order by sum(Quantity) desc) as MostQunatitySoldCity

--11.
--DELETE *
--FROM table
--HAVING COUNT(*) > 1
--CORRECT:
use group by and count(*), if count(*)>1 then delete the rows using sub query

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
--CORRECT:
select empid from Employee except select mgrid from Employee

--13.
SELECT TOP COUNT(e.deptid), d.deptname
FROM Employee e JOIN Dept d ON e.deptid = d.deptid
--13. CORRECT:
select deptid from employee group by deptid having count(*) = (select top 1 count(*) from employee group by deptid order by count(*) desc)

--14.
SELECT TOP 3 MAX(e.salary), d.deptname, e.empid
FROM Employee e JOIN Dept d ON e.deptid = d.deptid
GROUP BY d.deptname, e.empid
ORDER BY MAX(e.salary) DESC
--14. CORRECT:
select top 3 deptname,empid,salary from employee e join dep d on e.deptid=d.deptid order by salary,deptname,empid desc


