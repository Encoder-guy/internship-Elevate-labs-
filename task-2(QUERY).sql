use ecommerce_db

-- TASK 2: DATA INSERTION & HANDLING NULLS
-- Works in MySQL, SQLiteStudio, DB Fiddle


-- 1. CREATE TABLE (For E-commerce Example)
DROP TABLE Products;

CREATE TABLE Products (
    ProductID      INTEGER PRIMARY KEY,
    ProductName    VARCHAR(100) NOT NULL,
    Category       VARCHAR(50),
    Price          DECIMAL(10,2) DEFAULT 0.00,
    Stock          INTEGER DEFAULT 0,
    Description    TEXT
);

-- 2. INSERT STATEMENTS

-- A. Full Insert (all columns)
INSERT INTO Products (ProductID, ProductName, Category, Price, Stock, Description)
VALUES (101, 'Laptop', 'Electronics', 55000, 10, 'High performance laptop');

-- B. Insert with NULL values
INSERT INTO Products (ProductID, ProductName, Category, Price, Stock, Description)
VALUES (102, 'Wireless Mouse', 'Electronics', NULL, 25, NULL);

-- C. Partial Insert — Using DEFAULT values
INSERT INTO Products (ProductID, ProductName, Category)
VALUES (103, 'Water Bottle', 'Accessories');

-- D. Insert only required column (ProductName)
INSERT INTO Products (ProductID, ProductName)
VALUES (104, 'Notebook');

-- 3. UPDATE STATEMENTS

-- A. Update a single row
UPDATE Products
SET Price = 60000
WHERE ProductID = 101;

-- B. Update multiple rows (category → Electronics gets 10 extra stock)
UPDATE Products
SET Stock = Stock + 10
WHERE Category = 'Electronics';

-- C. Set NULL values to defaults or corrected values
UPDATE Products
SET Price = 299.00
WHERE Price IS NULL;

-- 4. DELETE STATEMENTS

-- A. Simple delete using WHERE
DELETE FROM Products
WHERE ProductName = 'Notebook';

-- 5. ROLLBACK SAFETY (Transaction Example)

BEGIN TRANSACTION;

DELETE FROM Products
WHERE Category IS NULL;     -- Assume accidental delete

-- ROLLBACK to undo the deletion
ROLLBACK;

-- 6. SELECT QUERIES TO VERIFY RESULT

-- View all data
SELECT * FROM Products;

-- Check NULL handling
SELECT ProductID, ProductName, Price
FROM Products
WHERE Price IS NULL;

-- Count products by category
SELECT Category, COUNT(*) AS ProductCount
FROM Products
GROUP BY Category;
