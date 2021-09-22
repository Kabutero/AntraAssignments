USE AdventureWorks2019
GO
--1
SELECT CustomerID, LastName, FirstName, CompanyName
FROM Sales.Customer;
--2
SELECT Name, ProductNumber, Color
FROM Production.Product;
--3
SELECT CustomerID, SalesOrderID
FROM Sales.SalesOrderHeader;
--4
SELECT BusinessEntityID, JobTitle, LoginID
FROM HumanResources.Employee
WHERE JobTitle = 'Research and Development Engineer';
--5
SELECT FirstName, MiddleName, Lastname, BusinessEntityID
FROM Person.Person
WHERE MiddleName = 'J';
--6
SELECT [ProductID], [StartDate], [EndDate], [StandardCost], [ModifiedDate]
FROM [AdventureWorks2019].[Production].[ProductCostHistory]
WHERE ModifiedDate = '2003-06-17';
--7
SELECT BusinessEntityID, FirstName, MiddleName, LastName, ModifiedDate
FROM Person.Person
WHERE ModifiedDate > '2000-12-19';
--8
SELECT BusinessEntityID, FirstName, MiddleName, LastName, ModifiedDate
FROM Person.Person
WHERE ModifiedDate <> '2000-12-19';
--9
SELECT BusinessEntityID, FirstName, LastName, ModifiedDate
FROM Person.Person
WHERE ModifiedDate BETWEEN '2000-12-01' AND '2000-12-31';
--10
SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'Chain%';
--11
SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE '%helmet%'
--12
SELECT ProductID, Name
FROM Production.Product
WHERE Name NOT LIKE '%helmet%';
--13
SELECT BusinessEntityID, FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName LIKE '[E,B]';
--14
--% allows for any number of characters to be substituted, _ only allows for one character to be substituted

--15
SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2001-09-01' AND '2001-09-30' AND TotalDue > 1000;

--16
SELECT SalesOrderID, OrderDate, TotalDue, SalesPersonID, TerritoryID
FROM Sales.SalesOrderHeader
WHERE TotalDue > 1000 AND (SalesPersonID = 279 OR TerritoryID = 6);

--17
SELECT SalesOrderID, OrderDate, TotalDue, SalesPersonID, TerritoryID
FROM Sales.SalesOrderHeader
WHERE TotalDue > 1000 AND (SalesPersonID = 279 OR TerritoryID IN (6,4));

--18
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IS NULL;

--19
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IS NULL OR Color <> 'Blue';

--20
SELECT ProductID, Name, Style, Size, Color
FROM Production.Product
WHERE Style IS NOT NULL OR Size IS NOT NULL OR Color IS NOT NULL;

--21
SELECT Comments, ProductID
FROM Production.ProductReview
WHERE Comments LIKE '%socks%';

--22
SELECT Title, FileName
FROM Production.Document
WHERE CONTAINS (*,'reflector');

--23
SELECT Title, FileName
FROM Production.Document
WHERE CONTAINS (*,'reflector AND NOT seat');

--24
SELECT BusinessEntityID, LastName, FirstName, MiddleName
FROM Person.Person
ORDER BY LastName, FirstName, MiddleName

--25
SELECT AddressLine1 + '(' + City + ' ' + PostalCode + ')'
FROM Person.Address

--26
SELECT ProductID, ISNULL(Color, 'No Color') AS Color, Name
FROM Production.Product;

--27
SELECT CAST(ProductID AS VARCHAR) + ': ' + Name AS IDName
FROM Production.Product;

--28
SELECT SpecialOfferID, Description, MaxQty - MinQty AS Diff
FROM Sales.SpecialOffer;

--29
SELECT SpecialOfferID, Description, MinQty * DiscountPct AS Discount
FROM Sales.SpecialOffer;

--30
SELECT SpecialOfferID, Description, ISNULL(MaxQty,10) * DiscountPct AS Discount
FROM Sales.SpecialOffer;

--31
SELECT LEFT(AddressLine1,10) AS Address10
FROM Person.Address;

--32
SELECT SUBSTRING(AddressLine1,10,6) AS Address10to15
FROM Person.Address;

--33
SELECT UPPER(FirstName) AS FirstName, UPPER(LastName) AS LastName
FROM Person.Person;

--34
SELECT ProductNumber, CHARINDEX('-',ProductNumber)
FROM Production.Product;
SELECT ProductNumber, SUBSTRING(ProductNumber,CHARINDEX('-',ProductNumber)+1,25) AS ProdNumber
FROM Production.Product;

--35
SELECT SalesOrderID, OrderDate, ShipDate, DATEDIFF(d, OrderDate, ShipDate) AS NumberOfDays
FROM Sales.SalesOrderHeader;

--36
SELECT CONVERT(VARCHAR,OrderDate,1) AS OrderDate, CONVERT(VARCHAR, ShipDate, 1) AS ShipDate
FROM Sales.SalesOrderHeader

--37
SELECT SalesOrderID, OrderDate, DATEADD(m,6,OrderDate) Plus6Months
FROM Sales.SalesOrderHeader

--38
SELECT SalesOrderID, OrderDate, DATEPART(yyyy, OrderDate) AS OrderYear, DATENAME(m,OrderDate) AS OrderMonth
FROM Sales.SalesOrderHeader

--39
SELECT SalesOrderID, OrderDate, DATEPART(yyyy,OrderDate) AS OrderYear, DATENAME(m,OrderDate) AS OrderMonth
FROM Sales.SalesOrderHeader

--40
SELECT SalesOrderID, ROUND(SubTotal,2) AS SubTotal
FROM Sales.SalesOrderHeader

--41
SELECT SalesOrderID, ROUND(SubTotal, 0) AS SubTotal
FROM Sales.SalesOrderHeader

--42
SELECT SQRT(SalesOrderID) AS OrderSQRT
FROM Sales.SalesOrderHeader

--43
SELECT BusinessEntityID, CASE BusinessEntityID % 2 WHEN 0 THEN 'Even' ELSE 'Odd' END
FROM HumanResources.Employee

--44
SELECT SalesOrderID, OrderQty,
 CASE WHEN OrderQty BETWEEN 0 AND 9 THEN 'Under 10'
 WHEN OrderQty BETWEEN 10 AND 19 THEN '10-19'
 WHEN OrderQty BETWEEN 20 AND 29 THEN '20-29'
 WHEN OrderQty BETWEEN 30 AND 39 THEN '30-39'
 ELSE '40 and over' end AS range
FROM Sales.SalesOrderDetail;

--45
SELECT SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2001

--46
SELECT SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader
ORDER BY MONTH(OrderDate), YEAR(OrderDate)

--47
SELECT PersonType, FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY CASE WHEN PersonType IN ('IN','SP','SC') THEN LastName
ELSE FirstName END

