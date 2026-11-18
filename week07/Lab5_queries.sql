-- ============================================
-- VUA-SEN307 Lab 5: SELECT, Filtering and Joins
-- Name: Eleje Francis Matric: 12368
-- ============================================
USE sen307_12368;

-- Task 1: Students in one department, sorted A-Z
-- Explanation: Joins Student and Department tables, filters for Software Engineering, and sorts alphabetically.
SELECT s.matric_no, s.full_name, d.dept_name
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;

-- Task 2: Courses with their lecturers (INNER JOIN)
-- Explanation: Links Course to Lecturer through the CourseAllocation bridge table using INNER JOINs.
SELECT c.course_code, c.course_title, l.full_name AS lecturer_name
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id;

-- Task 3: Students and their courses (LEFT JOIN)
-- Explanation: Uses LEFT JOIN to show all students, including those with no enrolments, filtered to show only students with no courses.
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
WHERE c.course_title IS NULL
ORDER BY s.full_name;

-- Task 4: Filtering with AND / IN / BETWEEN
-- Explanation: Combines gender, department IDs, and a birth date range using AND, IN, and BETWEEN operators with proper precedence.
SELECT s.full_name, s.gender, s.date_of_birth, d.dept_name
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
WHERE s.gender = 'F' 
  AND s.dept_id IN (1, 3) 
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31';

-- Task 5: Paginating enrolments with LIMIT and OFFSET
-- Explanation: Uses ORDER BY with LIMIT and OFFSET to fetch rows 1-10 (Page 1) and rows 11-20 (Page 2). (ORDER BY is required to guarantee deterministic ordering).
-- Page 1 (Rows 1–10)
SELECT enrolment_id, student_id, course_id
FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 0;

-- Page 2 (Rows 11–20)
SELECT enrolment_id, student_id, course_id
FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 10;

-- Challenge (Optional): Task 3 rewritten using RIGHT JOIN
-- Explanation: Reverses the table order using RIGHT JOIN to achieve the same result. 
-- Note: The LEFT JOIN version is significantly easier to read because it flows naturally from Student -> Enrolment -> Course.
SELECT s.full_name, c.course_title
FROM Course c
RIGHT JOIN Enrolment e ON c.course_id = e.course_id
RIGHT JOIN Student s ON e.student_id = s.student_id
WHERE c.course_title IS NULL
ORDER BY s.full_name;