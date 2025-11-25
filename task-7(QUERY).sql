/* ============================================================
   TASK 7 – CREATING VIEWS
   DBMS INTERNSHIP – COMPLETE SQL FILE
   ============================================================ */

/* ------------------------------------------------------------
   1. SAMPLE TABLES (You can replace these with your own)
   ------------------------------------------------------------ */
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(30),
    cgpa DECIMAL(3,2)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    credits INT
);

CREATE TABLE Enrollments (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

/* ------------------------------------------------------------
   2. INSERT SAMPLE DATA
   ------------------------------------------------------------ */
INSERT INTO Students VALUES
(1, 'Amit', 'CSE', 8.9),
(2, 'Riya', 'ECE', 9.1),
(3, 'Karan', 'CSE', 7.8),
(4, 'Sneha', 'MECH', 8.2);

INSERT INTO Courses VALUES
(101, 'DBMS', 4),
(102, 'OS', 3),
(103, 'Networks', 3);

INSERT INTO Enrollments VALUES
(1, 1, 101, 88),
(2, 1, 102, 92),
(3, 2, 101, 91),
(4, 3, 103, 76),
(5, 4, 102, 84);

/* ============================================================
   OBJECTIVE 1: CREATE A SIMPLE VIEW
   ============================================================ */
CREATE VIEW cse_students AS
SELECT student_id, name, cgpa
FROM Students
WHERE dept = 'CSE';

/* Usage */
SELECT * FROM cse_students;

/* ============================================================
   OBJECTIVE 2: CREATE A COMPLEX VIEW USING JOINS
   ============================================================ */
CREATE VIEW student_course_view AS
SELECT 
    s.student_id,
    s.name AS student_name,
    s.dept,
    c.course_name,
    e.marks
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

/* Usage */
SELECT * FROM student_course_view;

/* ============================================================
   OBJECTIVE 3: CREATE A VIEW WITH AGGREGATION
   ============================================================ */
CREATE VIEW student_avg_marks AS
SELECT 
    s.student_id,
    s.name,
    AVG(e.marks) AS average_marks
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.name;

/* Usage */
SELECT * FROM student_avg_marks;

/* ============================================================
   OBJECTIVE 4: VIEW WITH CHECK OPTION (DATA PROTECTION)
   ============================================================ */
CREATE VIEW high_cgpa_students AS
SELECT *
FROM Students
WHERE cgpa >= 8.5
WITH CHECK OPTION;

/* Testing UPDATE inside CHECK OPTION */
-- This will succeed
UPDATE high_cgpa_students SET cgpa = 9.3 WHERE student_id = 1;

-- This will fail (blocked by CHECK OPTION)
-- UPDATE high_cgpa_students SET cgpa = 7.0 WHERE student_id = 1;

/* ============================================================
   OBJECTIVE 5: UPDATE THROUGH A VIEW
   (Allowed only for views on a single table)
   ============================================================ */
CREATE VIEW editable_student_view AS
SELECT student_id, name, cgpa
FROM Students;

/* Update name using the view */
UPDATE editable_student_view 
SET name = 'Amit Kumar' 
WHERE student_id = 1;

/* ============================================================
   OBJECTIVE 6: SECURING DATA USING VIEWS
   (Hide student CGPA from normal users)
   ============================================================ */
CREATE VIEW student_public_view AS
SELECT 
    student_id,
    name,
    dept
FROM Students;

/* Usage */
SELECT * FROM student_public_view;

/* ============================================================
   OBJECTIVE 7: DROPPING A VIEW
   ============================================================ */
-- Example: Drop a view if required
DROP VIEW IF EXISTS student_public_view;

/* Recreate for repository completeness */
CREATE VIEW student_public_view AS
SELECT student_id, name, dept FROM Students;

/* ============================================================
   ALL OBJECTIVES COMPLETED
   ============================================================ */
