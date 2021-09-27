--1. SUBMITTED: Views are temporary collections of data created by SELECT statements. They provide a reuseable way to query data
--1. CORRECT: A View is a virtual table based on the result-set of an SQL statement. Complex and reusable queries can be simply retrieved using view.
--NOTES: Remember that a view is based on the result-set of ANY SQL statement, not just SELECT.

--2. SUBMITTED: No. Data can only be retrieved from views
--2. CORRECT: Yes data can be modified using views but it is not recommended when view using more than one base table
--NOTES: Remember that data can be modified using views, but it is not recommended when a view uses more than one table

--3. SUBMITTED: created statement that can be executed within multiple queries. useful for streamlining the code base by providing a reuseable query rather than typing out the same query multiple times
--3. CORRECT: Stored procedure is a collection of DML, DDL statements that can be executed together. Useful in maintaining clean scripts and easy to test and isolate business rules
--NOTES: Remember 'collection of DML, DDL statements' and that it's useful for maintaining clean scripts

--4. Views create tables to be used in future queries, stored procedures create SELECT statements that can be used in future queries
--4. CORRECT: View is SELECT statements, sp is collection of any DML, DDL statements
--NOTES: Remember that SP can also create tables, the key difference is views are SELECT only, whereas SP is any DDL, DML statements INCLUDING SELECT

--5. usage: stored procedures are used for DML; functions are for calculations
--   how to call: stored procedures must be called by its name; function called inside SELECT/FROM statement
--   input: stored procedure may or may not take input, function must have input parameters
--   output: stored procedures may or may not have output; function must return some values
--   stored procedures can call functions, but functions cannot call SP
--CORRECT: sp can return any number of values including none but functions must return a value
--         can use transaction in sp but not in functions
NOTES: combine submitted and correct answers when studying for best knowledge on differences

--6. Stored procedures can be made of any type of stored SQL code
--6. CORRECT: yes

--7. yes you have to call it off of EXEC however so use an AS beforehand
--7. CORRECT: No. Stored Procedures may or may not return a value, so it is incompatible with SELECT which must return something
NOTES: Remember that SP doesn't always return a value, so it's incompatible with SELECT, which must return something

--8. automatically runs when an event occurs. triggers can work on select/update/delete/insert statements
--8. CORRECT: trigger is used to execute business logics. After trigger and instead of trigger for insert/update/delete statements
NOTES: Remember that triggers are for insert/update/delete, not select

--9. triggers can be used to ensure transaction control by being thrown upon incorrect data input
--9. CORRECT: We can prevent creation of duplicate records, creating logs, and so on
--NOTES: Preventing creation of duplicate records seems to be the most common use case for triggers, so remember that

--10. stored procedures have to be called manually, triggers are automatic (when criteria is met)
--CORRECT: triggers happen on DML statements occurence, sp should be executed manually

--SQL
--1a.
INSERT INTO Region
VALUES ('Middle Earth')
--1a. CORRECT:
BEGIN TRAN

select * from Region
select * from Territories
select * from Employees
select * from EmployeeTerritories

INSERT INTO Region VALUES(6,'Middel Earth')
IF @@ERROR <>0
ROLLBACK
ELSE BEGIN
--NOTES: Querying the table to get the exact id to enter is preferrable to leaving the id to a variable or blank

-- b.
INSERT INTO Territories
VALUES ('Gondor', 3)
--b. CORRECT:
INSERT INTO Territories VALUES(98105,'Gondor',6)
DECLARE @error INT  = @@ERROR 
IF @error <>0
BEGIN
PRINT @error
ROLLBACK
END
ELSE BEGIN
--NOTES: Make sure to use TCL in queries from now on

-- c.
INSERT INTO Employees
VALUES ('Aragorn', 'King') 
--c. CORRECT:
INSERT INTO Employees VALUES('Aragorn',	'King'	,'Sales Representative',	'Ms.'	,'1966-01-27 00:00:00.000','1994-11-15 00:00:00.000', 'Houndstooth Rd.',	'London',	NULL	,'WG2 7LT',	'UK',	'(71) 555-4444'	,452,NULL,	'Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.',	5,	'http://accweb/emmployees/davolio.bmp/')
INSERT INTO EmployeeTerritories VALUES(@@IDENTITY,98105)
DECLARE @error2 INT  = @@ERROR 
IF @error2 <>0
BEGIN
PRINT @error2
ROLLBACK
END
ELSE BEGIN
--NOTES: Make sure to put as much data in as possible for answers

--2.
UPDATE Territories
SET TerritoryDescription = 'Arnor'
WHERE TerritoryDescription = 'Gondor'
--2. CORRECT:
UPDATE Territories
SET TerritoryDescription = 'Arnor'
WHERE TerritoryDescription = 'Gondor'
IF @@ERROR<>0
ROLLBACK
ELSE BEGIN
--NOTES: again, use TCL going forward to create a habit

--3.
DELETE Region
FROM Region
WHERE RegionDescription = 'Middle Earth'
--3. CORRECT:
DELETE FROM EmployeeTerritories 
WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription = 'Arnor')
DELETE FROM Territories
WHERE TerritoryDescription = 'Arnor'
DELETE FROM Region
WHERE RegionDescription = 'Middel Earth'
IF @@ERROR <>0
ROLLBACK
ELSE BEGIN
COMMIT
END
END
END
END
END
--NOTES: Make sure to delete from all relevant tables

--4.
CREATE VIEW view_product_order_Lachnicht
AS
SELECT ProductID, SUM(Quantity) AS TotalOrdered
FROM [Order Details]
GROUP BY ProductID
GO
SELECT *
FROM view_product_order_Lachnicht
--4. CORRECT:
CREATE VIEW View_Product_Order_Gaddam
AS
SELECT ProductName,SUM(Quantity) As TotalOrderQty 
FROM [Order Details] OD JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY ProductName
--NOTES: make sure to select * from a view after creating it. Also, when doing products and quantity, join order details and products

--5.
CREATE PROC sp_product_order_quantity_lachnicht @id int
AS
SELECT SUM(Quantity)
FROM [Order Details]
WHERE ProductID = @id
GO
--5. CORRECT:
ALTER PROC sp_Product_Order_Quantity_Gaddam
@ProductID INT,
@TotalOrderQty INT OUT
AS
BEGIN
SELECT @TotalOrderQty = SUM(Quantity)  FROM [Order Details] OD JOIN Products P ON P.ProductID = OD.ProductID
WHERE P.ProductID = @ProductID
GROUP BY ProductName
END
DECLARE @Tot INT
EXEC sp_Product_Order_Quantity_Gaddam 11,@Tot OUT
PRINT @Tot 
--NOTES: Make sore to execute procedures after creating them

--6.
CREATE PROC sp_product_order_city_lachnicht @productName nvarchar(30)
AS
SELECT TOP 5 o.ShipCity, SUM(od.Quantity)
FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = @productName
GROUP BY o.ShipCity
ORDER BY SUM(od.Quantity)
GO
--6. CORRECT:
ALTER PROC sp_Product_Order_City_Gaddam
@ProductName NVARCHAR(50)
AS
BEGIN
SELECT TOP 5 ShipCity,SUM(Quantity) 
FROM [Order Details] OD JOIN Products P ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID
WHERE ProductName=@ProductName
GROUP BY ProductName,ShipCity
ORDER BY SUM(Quantity) DESC
END


EXEC sp_Product_Order_City_Gaddam 'Queso Cabrales'
--NOTES: Only missing the EXEC and DESC in ORDERBY, as well as not including the product name. make sure to fix that in the future

--7.
CREATE PROC sp_move_employees_lachnicht 
AS
SELECT COUNT(TerritoryID)
FROM EmployeeTerritories
GO
CREATE FUNCTION newTerritory
--7. CORRECT:
BEGIN TRAN
select * from Region
select * from Territories
select * from Employees
select * from EmployeeTerritories
GO
ALTER PROC sp_move_employees_gaddam
AS
BEGIN

IF EXISTS(SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Troy'))
BEGIN
DECLARE @TerritotyID INT
SELECT @TerritotyID = MAX(TerritoryID) FROM Territories
BEGIN TRAN
INSERT INTO Territories VALUES(@TerritotyID+1 ,'Stevens Point',3)
UPDATE EmployeeTerritories
SET TerritoryID = @TerritotyID+1
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Troy'))
IF @@ERROR <> 0
BEGIN
ROLLBACK
END
ELSE
COMMIT
END

END

EXEC sp_move_employees_gaddam

--NOTES: research using IF EXISTS() for future queries

--8.
CREATE TRIGGER moveTerritories
ON EmployeeTerritories
AFTER INSERT, UPDATE
AS
BEGIN
IF COUNT(TerritoryID) > 100 AND TerritoryID = 4
UPDATE EmployeeTerritories
SET TerritoryID = 4
WHERE TerritoryID = 3
END;
--8. CORRECT:
CREATE TRIGGER tr_move_emp_gaddam
ON EmployeeTerritories
AFTER INSERT
AS
DECLARE @EmpCount INT
SELECT @EmpCount = COUNT(*) 
FROM EmployeeTerritories 
WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription = 'Stevens Point' AND RegionID=3) 
GROUP BY EmployeeID
IF (@EmpCount>100)
BEGIN
UPDATE EmployeeTerritories
SET TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Troy')
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Stevens Point' AND RegionID=3))
END

DROP TRIGGER tr_move_emp_gaddam

COMMIT
--NOTES: declare variables for triggers for easier use

	
--9.
CREATE TABLE people_lachnicht(
id int IDENTITY(1,1),
name varchar(20),
city int
)
CREATE TABLE city_lachnicht(
id int IDENTITY(1,1),
cityName varchar(30)
)
INSERT INTO people_lachnicht
VALUES('Aaron Rodgers', 2),
	  ('Russell Wilson', 1),
	  ('Jody Nelson', 2)
INSERT INTO city_lachnicht
VALUES('Seattle'),
	  ('Green Bay')
UPDATE city_lachnicht
SET cityName = 'Madison'
WHERE cityName = 'Seattle'
CREATE VIEW packers_lachnicht
AS
SELECT pl.name
FROM people_lachnicht pl JOIN city_lachnicht cl ON pl.city = cl.id
WHERE cl.cityName = 'Green Bay')
GO
--9.CORRECT:
CREATE TABLE People_Gaddam
(
id int ,
name nvarchar(100),
city int
)

create table City_Gaddam
(
id int,
city nvarchar(100)
)
BEGIN TRAN 
insert into City_Gaddam values(1,'Seattle')
insert into City_Gaddam values(2,'Green Bay')

insert into People_Gaddam values(1,'Aaron Rodgers',1)
insert into People_Gaddam values(2,'Russell Wilson',2)
insert into People_Gaddam values(3,'Jody Nelson',2)

if exists(select id from People_Gaddam where city = (select id from City_Gaddam where city = 'Seatle'))
begin
insert into City_Gaddam values(3,'Madison')
update People_Gaddam
set city = 'Madison'
where id in (select id from People_Gaddam where city = (select id from City_Gaddam where city = 'Seatle'))
end
delete from City_Gaddam where city = 'Seattle'

CREATE VIEW Packers_Gaddam
AS
SELECT name FROM People_Gaddam WHERE city = 'Green Bay'

select * from Packers_Gaddam
commit
drop table People_Gaddam
drop table City_Gaddam
drop view Packers_Gaddam
--NOTES: use subqueries and if exists when needed. research to learn when they are needed


--10.
CREATE PROC sp_birthday_employees_lachnicht
AS
DROP TABLE birthday_employees_lachnicht
CREATE TABLE birthday_employees_lachnicht(
id int IDENTITY(1,1),
name varchar(30)
)

GO
--10. CORRECT:
ALTER PROC sp_birthday_employee_gaddam
AS
BEGIN
SELECT * INTO #EmployeeTemp
FROM Employees WHERE DATEPART(MM,BirthDate) = 02
SELECT * FROM #EmployeeTemp
END



--11.
CREATE PROC sp_lachnicht_1
AS

GO
--11. CORRECT:
CREATE PROC sp_gaddam_1
AS
BEGIN
SELECT City FROM CUSTOMERS
GROUP BY City
HAVING COUNT(*)>2
INTERSECT
SELECT City FROM Customers C JOIN Orders O ON O.CustomerID=C.CustomerID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY OD.ProductID,C.CustomerID,City
HAVING COUNT(*) BETWEEN 0 AND 1
END
GO
EXEC sp_gaddam_1
GO
CREATE PROC sp_gaddam_2
AS
BEGIN
SELECT City FROM CUSTOMERS
WHERE CITY IN (SELECT City FROM Customers C JOIN Orders O ON O.CustomerID=C.CustomerID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY OD.ProductID,C.CustomerID,City
HAVING COUNT(*) BETWEEN 0 AND 1)
GROUP BY City
HAVING COUNT(*)>2
END
GO
EXEC sp_gaddam_2
GO

--12.
--Incorrect: use EXCEPT instead
DELETE *
FROM TableA
WHERE * IS NOT IN
--12. CORRECT:
SELECT * FROM Customers
EXCEPT
SELECT * FROM Customers
--NOTES: use EXCEPT to ensure no duplicates

--13.

--14.
CREATE VIEW fullName
AS
SELECT [First Name] + ' ' + [Last Name] + ' ' + [Middle Name] AS [Full Name]
FROM table
--14. CORRECT:
SELECT firstName+' '+lastName from Person where middleName is null UNION SELECT firstName+' '+lastName+' '+middelName+'.' from Person where middleName is not null
--NOTES: research more on unions to increase understanding of use cases

--15.
SELECT TOP Marks
FROM students
WHERE Sex = 'F'
--15. CORRECT:
select top 1 marks from student where sex = 'F' order by marks desc
--NOTES: almost correct, but when using TOP always specify the number

--16.
ORDER BY Sex, Marks
--16. CORRECT:
select * from students order by sex,marks
--NOTES: make sure to include as much information as possible
