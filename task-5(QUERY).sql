   --TASK 5 – SQL DEVELOPER INTERNSHIP

   --1. CREATE TABLES

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(50),
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

/* ---------------------------------------------------------
   2. INSERT SAMPLE DATA
---------------------------------------------------------- */

INSERT INTO Customers VALUES
(1, 'Rahul', 'Mumbai'),
(2, 'Sneha', 'Delhi'),
(3, 'Arjun', 'Pune'),
(4, 'Priya', 'Ahmedabad');

INSERT INTO Orders VALUES
(101, 1, 'Laptop', 55000),
(102, 1, 'Mouse', 500),
(103, 2, 'Keyboard', 1200),
(104, 3, 'Monitor', 7000);

/* ---------------------------------------------------------
   3. INNER JOIN – Returns matching rows
---------------------------------------------------------- */
SELECT 
    Customers.CustomerID,
    CustomerName,
    Product,
    Amount
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

/* ---------------------------------------------------------
   4. LEFT JOIN – All customers + matching orders
---------------------------------------------------------- */
SELECT 
    Customers.CustomerID,
    CustomerName,
    Product,
    Amount
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

/* ---------------------------------------------------------
   5. RIGHT JOIN – All orders + matching customers
   (NOTE: SQLite does not support RIGHT JOIN)
---------------------------------------------------------- */
SELECT 
    Customers.CustomerID,
    CustomerName,
    Product,
    Amount
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

/* ---------------------------------------------------------
   6. FULL OUTER JOIN – Shows all rows from both tables
   (Not supported in MySQL/SQLite → Use UNION)
---------------------------------------------------------- */

-- FULL OUTER JOIN Alternative
SELECT 
    Customers.CustomerID,
    CustomerName,
    Product,
    Amount
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID

UNION

SELECT 
    Customers.CustomerID,
    CustomerName,
    Product,
    Amount
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

/* ---------------------------------------------------------
   7. CROSS JOIN – Cartesian Product
---------------------------------------------------------- */
SELECT 
    Customers.CustomerName,
    Orders.Product
FROM Customers
CROSS JOIN Orders;

/* ---------------------------------------------------------
   8. SELF JOIN – Customer having same city
---------------------------------------------------------- */
SELECT 
    A.CustomerName AS Customer1,
    B.CustomerName AS Customer2,
    A.City
FROM Customers A
INNER JOIN Customers B
ON A.City = B.City AND A.CustomerID <> B.CustomerID;

/* ---------------------------------------------------------
   9. NATURAL JOIN (works only if column names match)
---------------------------------------------------------- */
select *
from Customers
Natural JOIN Orders;


