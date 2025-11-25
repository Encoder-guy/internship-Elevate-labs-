/* ============================================================
   TASK 8 – STORED PROCEDURE & FUNCTION (Simple Version)
   ============================================================ */

/* ------------------------------------------------------------
   SIMPLE SAMPLE TABLE
   ------------------------------------------------------------ */
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    cgpa DECIMAL(3,2)
);

/* ------------------------------------------------------------
   INSERT SAMPLE DATA
   ------------------------------------------------------------ */
INSERT INTO Students VALUES
(1, 'Amit', 8.9),
(2, 'Riya', 9.1),
(3, 'Karan', 7.8);

/* ============================================================
   SIMPLE STORED FUNCTION
   Returns CGPA of a student
   ============================================================ */

DELIMITER $$

CREATE FUNCTION getCGPA(stu_id INT)
RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
    DECLARE result DECIMAL(3,2);

    SELECT cgpa INTO result
    FROM Students
    WHERE student_id = stu_id;

    RETURN result;
END $$

DELIMITER ;

/* Usage */
SELECT getCGPA(1);


/* ============================================================
   SIMPLE STORED PROCEDURE
   Displays student name
   ============================================================ */

DELIMITER $$

CREATE PROCEDURE getStudentName(IN stu_id INT)
BEGIN
    SELECT name 
    FROM Students
    WHERE student_id = stu_id;
END $$

DELIMITER ;

/* Usage */
CALL getStudentName(2);


/* ============================================================
   SIMPLE UPDATE PROCEDURE (Optional but easy)
   ============================================================ */

DELIMITER $$

CREATE PROCEDURE updateCGPA(
    IN stu_id INT,
    IN new_cgpa DECIMAL(3,2)
)
BEGIN
    UPDATE Students
    SET cgpa = new_cgpa
    WHERE student_id = stu_id;
END $$

DELIMITER ;

/* Usage */
CALL updateCGPA(3, 8.0);


/* ============================================================
   END OF SIMPLE TASK 8 SQL
   ============================================================ */
