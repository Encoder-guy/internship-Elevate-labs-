--   SQL DEVELOPER INTERNSHIP – TASK 6


CREATE TABLE Emplo_yees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    manager_id INT
);

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30),
    location VARCHAR(30)
);

INSERT INTO Emplo_yees VALUES
(1, 'Rahul', 'IT', 60000, 5),
(2, 'Priya', 'HR', 45000, 6),
(3, 'Amit', 'Finance', 70000, 7),
(4, 'Sara', 'IT', 55000, 5),
(5, 'Karan', 'IT', 90000, NULL),
(6, 'Riya', 'HR', 80000, NULL),
(7, 'Dev', 'Finance', 95000, NULL);

INSERT INTO Departments VALUES
(101, 'IT', 'Mumbai'),
(102, 'HR', 'Delhi'),
(103, 'Finance', 'Bangalore');

/* -------------------------------------------------------------
   1. SUBQUERY IN WHERE CLAUSE
   Find Emplo_yees who earn more than the average salary.
   ------------------------------------------------------------- */

SELECT emp_name, salary
FROM Emplo_yees
WHERE salary > (SELECT AVG(salary) FROM Emplo_yees);

/* -------------------------------------------------------------
   2. SUBQUERY WITH IN CLAUSE
   Emplo_yees who work in departments located in Delhi or Mumbai.
   ------------------------------------------------------------- */

SELECT emp_name, department
FROM Emplo_yees
WHERE department IN (
    SELECT dept_name
    FROM Departments
    WHERE location IN ('Delhi', 'Mumbai')
);

/* -------------------------------------------------------------
   3. SUBQUERY WITH EXISTS
   List departments that have at least one employee.
   ------------------------------------------------------------- */

SELECT dept_name
FROM Departments d
WHERE EXISTS (
    SELECT 1
    FROM Emplo_yees e
    WHERE e.department = d.dept_name
);

/* -------------------------------------------------------------
   4. CORRELATED SUBQUERY
   List Emplo_yees whose salary is above the average of their own department.
   ------------------------------------------------------------- */

SELECT emp_name, department, salary
FROM Emplo_yees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM Emplo_yees e2
    WHERE e2.department = e1.department
);

/* -------------------------------------------------------------
   5. SCALAR SUBQUERY IN SELECT CLAUSE
   Show each employee with their department location (fetched using subquery).
   ------------------------------------------------------------- */

SELECT emp_name,
       department,
       (SELECT location
        FROM Departments d
        WHERE d.dept_name = Emplo_yees.department) AS department_location
FROM Emplo_yees;

/* -------------------------------------------------------------
   6. SUBQUERY IN FROM CLAUSE (DERIVED TABLE)
   Show department-wise average salaries.
   ------------------------------------------------------------- */

SELECT department, avg_salary
FROM (
    SELECT department, AVG(salary) AS avg_salary
    FROM Emplo_yees
    GROUP BY department
) AS dept_avg;

/* -------------------------------------------------------------
   7. NESTED SUBQUERY
   List Emplo_yees earning higher than the second-highest salary.
   ------------------------------------------------------------- */

SELECT emp_name, salary
FROM Emplo_yees
WHERE salary > (
    SELECT MAX(salary)
    FROM Emplo_yees
    WHERE salary < (SELECT MAX(salary) FROM Emplo_yees)
);

/* -------------------------------------------------------------
   8. MULTIPLE-ROW SUBQUERY
   List Emplo_yees who report to any manager earning more than 85,000.
   ------------------------------------------------------------- */

SELECT emp_name, manager_id
FROM Emplo_yees
WHERE manager_id IN (
    SELECT emp_id
    FROM Emplo_yees
    WHERE salary > 85000
);

/* -------------------------------------------------------------
   9. SUBQUERY USING = 
   Show employee who has the maximum salary.
   ------------------------------------------------------------- */

SELECT emp_name, salary
FROM Emplo_yees
WHERE salary = (SELECT MAX(salary) FROM Emplo_yees);

/* -------------------------------------------------------------
   10. SUBQUERY WITH NOT EXISTS
   List departments with no Emplo_yees.
   ------------------------------------------------------------- */

SELECT dept_name
FROM Departments d
WHERE NOT EXISTS (
    SELECT *
    FROM Emplo_yees e
    WHERE e.department = d.dept_name
);

