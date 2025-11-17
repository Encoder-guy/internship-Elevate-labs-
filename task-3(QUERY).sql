--   1. CREATE TABLE & INSERT SAMPLE DATA

DROP TABLE IF EXISTS Students;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Department VARCHAR(50),
    Marks INT,
    City VARCHAR(50)
);

INSERT INTO Students VALUES
(1, 'Amit', 20, 'Computer', 85, 'Rajkot'),
(2, 'Priya', 22, 'Mechanical', 74, 'Surat'),
(3, 'Karan', 19, 'Computer', 91, 'Ahmedabad'),
(4, 'Riya', 21, 'Civil', 67, 'Rajkot'),
(5, 'Nirav', 23, 'Computer', 55, 'Baroda'),
(6, 'Sneha', 20, 'Computer', 88, 'Surat'),
(7, 'Vijay', 22, 'IT', 70, 'Rajkot'),
(8, 'Zara', 21, 'Mechanical', 82, 'Ahmedabad');


--   2. BASIC SELECT QUERIES

-- Select all columns
SELECT * FROM Students;

-- Select specific columns
SELECT Name, Age, Marks FROM Students;


--  3. WHERE FILTERING

-- Students with marks greater than 80
SELECT * FROM Students
WHERE Marks > 80;

-- Students in Computer department
SELECT * FROM Students
WHERE Department = 'Computer';


--   4. USING AND / OR

-- Using AND
SELECT * FROM Students
WHERE Department = 'Computer' AND Marks > 80;

-- Using OR
SELECT * FROM Students
WHERE City = 'Rajkot' OR City = 'Surat';


--   5. BETWEEN OPERATOR

-- Marks between 70 and 90
SELECT * FROM Students
WHERE Marks BETWEEN 70 AND 90;


--   6. LIKE OPERATOR (Pattern Matching)

-- Names starting with A
SELECT * FROM Students
WHERE Name LIKE 'A%';

-- Names ending with 'a'
SELECT * FROM Students
WHERE Name LIKE '%a';

-- Names containing 'ra'
SELECT * FROM Students
WHERE Name LIKE '%ra%';


--   7. ORDER BY (Sorting)

-- Sort by marks ascending (default)
SELECT * FROM Students
ORDER BY Marks ASC;

-- Sort by marks descending
SELECT * FROM Students
ORDER BY Marks DESC;

-- Sort by department and marks (multi-level sort)
SELECT * FROM Students
ORDER BY Department ASC, Marks DESC;


--   8. LIMIT (Top N Records)

-- Top 3 highest marks
SELECT top 3 * FROM Students
ORDER BY Marks DESC;


--   9. DISTINCT (Remove duplicates)

-- Unique cities
SELECT DISTINCT City FROM Students;
