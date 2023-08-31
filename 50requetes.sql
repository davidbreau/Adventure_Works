-- SCRIPT DES 50 queries --


-- 1. From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle. 

SELECT
   * 
FROM HumanResources.Employee
ORDER BY JobTitle ASC;


-- 2 From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. Sort the output in ascending order on lastname. 

SELECT 
   * 
FROM Person.Person
ORDER BY LastName ASC;

-- 3. From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname. 

SELECT 
   FirstName, 
   LastName, 
   businessentityid AS Employee_id 
FROM Person.Person
ORDER BY LastName ASC;


-- 4. From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name. 

SELECT 
   * 
FROM Production.Product
WHERE SellStartDate  IS NOT NULL
ORDER BY Name ASC;


-- 5. From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal. 

SELECT 
   SalesOrderID, 
   CustomerID, 
   OrderDate, 
   SubTotal, 
   (TaxAmt*100)/SubTotal AS Tax_Percent
 FROM Sales.SalesOrderHeader
 ORDER BY SubTotal ASC;


-- 6. From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. Return jobtitle column and arranged the resultset in ascending order. 

SELECT DISTINCT
    Jobtitle 
FROM HumanResources.Employee
GROUP BY JobTitle 
ORDER BY JobTitle ASC;


-- 7. From the following table write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. Sort the output in ascending order on customerid. 

SELECT 
   CustomerID,
   Sum(Freight) AS Total_freight
FROM Sales.SalesOrderHeader
GROUP BY CustomerID 
ORDER BY CustomerID ASC;


-- 8. From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order. 

SELECT
   CustomerID,
   SalesPersonID,
   AVG(SubTotal) AS Avg_Subtotal,
   SUM(SubTotal) AS Sum_Subtotal
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, SalesPersonID 
ORDER BY CustomerID DESC;


-- 9. From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. Sort the results according to the productid in ascending order. 

SELECT 
   ProductID,
   SUM(Quantity) AS Total_Quantity
FROM Production.ProductInventory
WHERE Shelf IN ('A', 'C', 'H')
GROUP BY ProductID 
HAVING SUM(Quantity) > 500
ORDER BY ProductID ASC;


-- 10. From the following table write a query in SQL to find the total quentity for a group of locationid multiplied by 10. 

SELECT 
   SUM(Quantity) AS Total_Quantity
FROM Production.ProductInventory
GROUP BY (LocationID*10);


-- 11. From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname. 

SELECT
   P.BusinessEntityID,
   FirstName,
   LastName,
   PhoneNumber AS Person_Phone
FROM Person.Person as P
JOIN Person.PersonPhone as Ph
   ON P.BusinessEntityID = Ph.BusinessEntityID 
WHERE LastName LIKE 'L%'
ORDER BY LastName, FirstName;


-- 12. From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal. 

SELECT
   SalesPersonId,
   CustomerID,
   SUM(Subtotal) AS Sum_Subtotal
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP (SalesPersonID, CustomerID);


-- 13. From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity. 

SELECT DISTINCT
   LocationID,
   Shelf,
   SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY CUBE (LocationID, Shelf);


-- 14. From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity. 

SELECT 
   LocationID,
   Shelf,
   SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY GROUPING SETS ( ROLLUP (LocationID, Shelf), CUBE (LocationID, Shelf) );


-- 15. From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. Return locationid and total quantity. Group the results on locationid. 

SELECT
	LocationID,
	SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY GROUPING SETS ( LocationID, () );


-- 16. From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. Sort the result in ascending order on city. 

SELECT 
	A.City,
	COUNT(BEA.AddressID) AS NoOfEmployees
FROM Person.BusinessEntityAddress as BEA
   INNER JOIN Person.Address as A
      ON BEA.AddressID = A.AddressID 
GROUP BY A.City 
ORDER BY A.City;


-- 17. From the following table write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date. 

SELECT 
   YEAR(OrderDate) AS "Year",
   SUM(TotalDue) AS "Order Amount"
FROM Sales.SalesOrderHeader AS SOH
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate);


-- 18. From the following table write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date. 

SELECT
   YEAR(OrderDate) AS YearOfOrderDate,
   SUM(TotalDue) AS TotalDueOrder
FROM Sales.SalesOrderHeader AS SOH
GROUP BY YEAR(OrderDate)
   HAVING YEAR(OrderDate) <= '2016'
ORDER BY YEAR(OrderDate);


-- 19. From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order. 

SELECT 
   ContactTypeID,
   Name 
FROM Person.ContactType AS CT
WHERE Name LIKE '%Manager%'
ORDER BY Name DESC;


-- 20. From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName. 

SELECT pp.BusinessEntityID, LastName, FirstName
FROM Person.BusinessEntityContact AS pb 
INNER JOIN Person.ContactType AS pc
   ON pc.ContactTypeID = pb.ContactTypeID
INNER JOIN Person.Person AS pp
   ON pp.BusinessEntityID = pb.PersonID
WHERE pc.Name = 'Purchasing Manager'
   ORDER BY LastName, FirstName;


-- 21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.
  
SELECT
   ROW_NUMBER() OVER (PARTITION BY PostalCode ORDER BY SalesYTD DESC) AS "Row Number",
   P.LastName,
   SP.SalesYTD,
   A.PostalCode 
FROM Sales.SalesPerson AS SP
   INNER JOIN Person.Person AS P
      ON P.BusinessEntityID = SP.BusinessEntityID 
   INNER JOIN Person.Address AS A
      ON A.AddressID = SP.BusinessEntityID
WHERE TerritoryID IS NOT NULL
   AND SalesYTD <> 0
ORDER BY A.PostalCode;


-- 22. From the following table write a query in SQL to count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts.

SELECT pc.ContactTypeID, pc.Name AS CTypeName, COUNT(*) AS NOcontacts
FROM Person.BusinessEntityContact AS pbe
   INNER JOIN Person.ContactType AS pc
      ON pc.ContactTypeID = pbe.ContactTypeID
GROUP BY pc.ContactTypeID, pc.Name
HAVING COUNT(*) >= 100
ORDER BY COUNT(*) DESC;


-- 23. From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.

SELECT
    CONVERT(VARCHAR(10), eph.RateChangeDate, 120) AS FromDate,
    CONCAT(LastName, ', ', FirstName, ', ', MiddleName) AS NameInFull,
    eph.Rate*40 AS SalaryInAWeek
FROM Person.Person p 
   INNER JOIN HumanResources.EmployeePayHistory eph 
      ON eph.BusinessEntityID = p.BusinessEntityID
ORDER BY NameInFull;
      

-- 24. From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull.

SELECT
    CONVERT(VARCHAR(10), eph.RateChangeDate, 120) AS FromDate,
    CONCAT(LastName, ', ', FirstName, ', ', MiddleName) AS NameInFull,
    eph.Rate*40 AS SalaryInAWeek
FROM Person.Person p 
   INNER JOIN HumanResources.EmployeePayHistory eph 
      ON eph.BusinessEntityID = p.BusinessEntityID
WHERE eph.RateChangeDate = (SELECT MAX(RateChangeDate)
   FROM HumanResources.EmployeePayHistory
      WHERE BusinessEntityID = eph.BusinessEntityID)
ORDER BY NameInFull;


-- 25. From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.

SELECT
   SalesOrderID,
   ProductID,
   OrderQty,
   SUM(OrderQty) OVER (PARTITION BY SalesOrderID) AS 'Total Quantity',
   AVG(OrderQty) OVER (PARTITION BY SalesOrderID) AS 'Avg Quantity',
   COUNT(OrderQty) OVER (PARTITION BY SalesOrderID) AS 'No of Orders',
   MIN(OrderQty) OVER (PARTITION BY SalesOrderID) AS 'Min Quantity',
   MAX(OrderQty) OVER (PARTITION BY SalesOrderID) AS 'Max Quantity'
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659,43664);


-- 26. From the following table write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.

SELECT
   SalesOrderID AS OrderNumber,
   ProductID,
   OrderQty as Quantity,
   SUM(OrderQty) OVER (ORDER BY SalesOrderID, ProductID) AS Total,
   AVG(OrderQty) OVER(PARTITION BY SalesOrderID ORDER BY SalesOrderID, ProductID) AS Avg,
   COUNT(OrderQty) OVER (ORDER BY SalesOrderID, ProductID ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING) AS Count
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659,43664) AND ProductID LIKE '71%';


-- 27. From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost.

SELECT
   SalesOrderID,
   SUM(UnitPrice * OrderQty) AS OrderCost
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID 
   HAVING SUM(UnitPrice * OrderQty) > 100000;


-- 28. From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'. Return product ID, and name and order the result set in ascending order on product ID column.
  
SELECT
   ProductID,
   Name
FROM Production.Product
WHERE Name LIKE 'Lock Washer%'
ORDER BY ProductID;


-- 29. Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. Return product ID, name, and color of the product.

SELECT
   ProductID,
   Name,
   Color
FROM Production.Product
ORDER BY ListPrice;  


-- 30. From the following table write a query in SQL to retrieve records of employees. Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, and HireDate.

SELECT
   BusinessEntityID ,
   JobTitle ,
   HireDate 
FROM HumanResources.Employee
ORDER BY YEAR(HireDate);


-- 31. From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.

SELECT
   LastName,
   FirstName 
FROM Person.Person
WHERE LastName LIKE 'R%'
ORDER BY FirstName ASC,
         LastName DESC


-- 32. From the following table write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'. Return BusinessEntityID, SalariedFlag columns.
         
SELECT 
   BusinessEntityID,
   SalariedFlag 
FROM HumanResources.Employee
ORDER BY
   CASE WHEN
      SalariedFlag = '1'
         THEN BusinessEntityID END 
            DESC,
   CASE WHEN 
      SalariedFlag = '0'
         THEN BusinessEntityID END;


-- 33. From the following table write a query in SQL to set the result in order by the column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.
        
SELECT
   BusinessEntityID,
   LastName,
   TerritoryName,
   CountryRegionName 
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL
ORDER BY CASE WHEN CountryRegionName = 'United States' THEN TerritoryName ELSE CountryRegionName END;


-- 34. From the following table write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. Order the output on postalcode column.

SELECT
   p.FirstName,
   p.LastName,
   ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS "Row Number",
   RANK() OVER (ORDER BY a.PostalCode) AS "Rank",
   DENSE_RANK() OVER (ORDER BY a.PostalCode) AS "Dense Rank",
   NTILE(4) OVER (ORDER BY a.PostalCode) AS "Quartile"
FROM Sales.SalesPerson sp
   INNER JOIN Person.Person p 
      ON sp.BusinessEntityID = p.BusinessEntityID 
   INNER JOIN Person.Address a 
      ON a.AddressID = P.BusinessEntityID
WHERE TerritoryID IS NOT NULL AND SalesYTD != 0;


-- 35. From the following table write a query in SQL to skip the first 10 rows from the sorted result set and return all remaining rows.

SELECT
   DepartmentID,
   Name,
   GroupName 
FROM HumanResources.Department 
ORDER BY DepartmentID OFFSET 10 ROWS;


-- 36. From the following table write a query in SQL to skip the first 5 rows and return the next 5 rows from the sorted result set.

SELECT
   DepartmentID,
   Name,
   GroupName 
FROM HumanResources.Department
ORDER BY DepartmentID 
   OFFSET 5 ROWS
   FETCH NEXT 5 ROWS ONLY;

  
-- 37. From the following table write a query in SQL to list all the products that are Red or Blue in color. Return name, color and listprice.Sorts this result by the column listprice.
  
SELECT
   Name,
   Color,
   ListPrice
FROM Production.Product
WHERE Color IN ('Red', 'Blue')
ORDER BY ListPrice;


-- 38. Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. 
-- Additionally, it turns any sales orders that don't have any items mentioned in the Product table as well as any products that have sales orders other than those that are listed there. 
-- Return product name, salesorderid. Sort the result set on product name column.

SELECT p.Name, sod.SalesOrderID  
FROM Production.Product p  
   FULL OUTER JOIN Sales.SalesOrderDetail sod  
      ON p.ProductID = sod.ProductID  
ORDER BY p.Name ;


-- 39. From the following table write a SQL query to retrieve the product name and salesorderid. Both ordered and unordered products are included in the result set.

SELECT p.Name, sod.SalesOrderID  
FROM Production.Product AS p  
   LEFT OUTER JOIN Sales.SalesOrderDetail AS sod  
      ON p.ProductID = sod.ProductID  
ORDER BY p.Name ;


-- 40. From the following tables write a SQL query to get all product names and sales order IDs. Order the result set on product name column.

SELECT p.Name, sod.SalesOrderID  
FROM Production.Product AS p  
   INNER JOIN Sales.SalesOrderDetail AS sod  
      ON p.ProductID = sod.ProductID  
ORDER BY p.Name ;


-- 41. From the following tables write a SQL query to retrieve the territory name and BusinessEntityID. The result set includes all salespeople, regardless of whether or not they are assigned a territory.

SELECT 
   st.Name AS Territory,
   sp.BusinessEntityID
FROM Sales.SalesTerritory st 
   RIGHT OUTER JOIN Sales.SalesPerson sp 
      ON st.TerritoryID = sp.TerritoryID;


-- 42. Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. Order the result set on lastname then by firstname.
     
SELECT 
   concat(RTRIM(p.FirstName),' ', LTRIM(p.LastName)) AS Name, 
   d.City  
FROM Person.Person AS p  
   INNER JOIN HumanResources.Employee e 
      ON p.BusinessEntityID = e.BusinessEntityID   
INNER JOIN  
   (SELECT 
      bea.BusinessEntityID, 
      a.City   
    FROM Person.Address AS a  
    INNER JOIN Person.BusinessEntityAddress AS bea  
       ON a.AddressID = bea.AddressID) AS d  
          ON p.BusinessEntityID = d.BusinessEntityID  
ORDER BY p.LastName, p.FirstName;


-- 43. Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the person table (derived table) with persontype is 'IN' and the last name is 'Adams'. Sort the result set in ascending order on firstname. A SELECT statement after the FROM clause is a derived table.

SELECT 
   businessentityid, 
   firstname,
   lastname  
FROM  
   (SELECT * FROM person.person  
    WHERE persontype = 'IN') AS personDerivedTable 
WHERE lastname = 'Adams'  
ORDER BY firstname;


-- 44. Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.

SELECT 
   businessentityid, 
   firstname,
   LastName  
FROM person.person 
WHERE businessentityid <= 1500 
   AND LastName LIKE 'Al%' 
   AND FirstName LIKE 'M%';

  
-- 45. Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.
  
SELECT 
   ProductID, 
   a.Name, 
   Color  
FROM Production.Product AS a  
INNER JOIN (VALUES ('Blade'), ('Crown Race'), ('AWC Logo Cap')) AS b(Name)   
   ON a.Name = b.Name;


-- 46. Create a SQL query to display the total number of sales orders each sales representative receives annually. Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. Return the year component of the OrderDate, SalesPersonID, and SalesOrderID.

WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS
(
    SELECT SalesPersonID, SalesOrderID, DATE_PART('year',OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)
SELECT 
   SalesPersonID, 
   COUNT(SalesOrderID) AS TotalSales, 
   SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;


-- 47. From the following table write a query in SQL to find the average number of sales orders for all the years of the sales representatives.

WITH Sales_CTE (SalesPersonID, NumberOfOrders)
AS
(
    SELECT 
       SalesPersonID, 
       COUNT(*)
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
    GROUP BY SalesPersonID
)
SELECT 
   AVG(NumberOfOrders) AS "Average Sales Per Person"
FROM Sales_CTE;


-- 48. Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. The following table's columns must all be returned.

SELECT 
   *   
FROM Production.ProductPhoto  
WHERE LargePhotoFileName LIKE '%greena_%' ESCAPE 'a' ;


-- 49. Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.

SELECT 
   AddressLine1, 
   AddressLine2, City, 
   PostalCode, 
   CountryRegionCode    
FROM Person.Address AS a  
JOIN Person.StateProvince AS s 
   ON a.StateProvinceID = s.StateProvinceID  
WHERE CountryRegionCode NOT IN ('US')  
  AND City LIKE 'Pa%' ;
 
 
-- 50. From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. Order the result set on hiredate column in descending order.
 
SELECT 
   JobTitle, 
   HireDate  
FROM HumanResources.Employee
ORDER BY HireDate DESC
FETCH FIRST 20 ROWS ONLY;







