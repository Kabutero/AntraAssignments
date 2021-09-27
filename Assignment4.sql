--1.
--2. No. Data can only be retrieved from views
--3. 

--5. usage: stored procedures are used for DML; functions are for calculations
--   how to call: stored procedures must be called by its name; function called inside SELECT/FROM statement
--   input: stored procedure may or may not take input, function must have input parameters
--   output: stored procedures may or may not have output; function must return some values
--   stored procedures can call functions, but functions cannot call SP
--6.
--7.
--8. automatically runs when an event occurs. triggers can work on select/update/delete/insert statements
--9. 
--10. stored procedures have to be called manually, triggers are automatic

--SQL
--1a.
INSERT INTO Region
VALUES ('Middle Earth')
-- b.
INSERT INTO Territories
VALUES ('Gondor', 3)
-- c.
INSERT INTO Employees
VALUES ('Aragorn', 'King') 

--2.
UPDATE Territories
SET TerritoryDescription = 'Arnor'
WHERE TerritoryDescription = 'Gondor'

--3.
DELETE Region
FROM Region
WHERE RegionDescription = 'Middle Earth'

--4.
CREATE VIEW view_product_order_Lachnicht
AS
SELECT ProductID, SUM(Quantity) AS TotalOrdered
FROM [Order Details]
GROUP BY ProductID
GO
SELECT *
FROM view_product_order_Lachnicht

--5.
CREATE PROC sp_product_order_quantity_lachnicht @id int
AS
SELECT SUM(Quantity)
FROM [Order Details]
WHERE ProductID = @id
GO

--6.
CREATE PROC sp_product_order_city_lachnicht @productName nvarchar(30)
AS
SELECT TOP 5 o.ShipCity, SUM(od.Quantity)
FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = @productName
GROUP BY o.ShipCity
ORDER BY SUM(od.Quantity)
GO
--7.
CREATE PROC sp_move_employees_lachnicht 
AS
SELECT COUNT(TerritoryID)
FROM EmployeeTerritories
GO
CREATE FUNCTION newTerritory

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
--10.
CREATE PROC sp_birthday_employees_lachnicht
AS
DROP TABLE birthday_employees_lachnicht
CREATE TABLE birthday_employees_lachnicht(
id int IDENTITY(1,1),
name varchar(30)
)

GO
--11.
CREATE PROC sp_lachnicht_1
AS

GO
--12.
DELETE *
FROM TableA
WHERE * IS NOT IN

--13.

--14.
CREATE VIEW fullName

--15.

--16.
ORDER BY Sex, Marks