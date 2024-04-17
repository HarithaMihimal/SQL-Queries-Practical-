-- 1) Find the names of all the instructors from the “Finance” department (sort by instructor name in ascending order).

SELECT name
FROM instructor
WHERE dept_name = 'Finance'
ORDER BY name ASC;

-- 2) Find the names of courses in the “Biology” department which 3 or more credits (sort by course title in ascending order).

SELECT title
FROM course
WHERE dept_name = 'Biology' AND credits >= 3
ORDER BY title ASC;

-- 3) Find the names of students who are from the “Computer Science” department who have taken more than 50 credits  (sort by name in the ascending order) .
SELECT name
FROM student
WHERE dept_name = 'Comp. Sci.' AND tot_cred > 50
ORDER BY name ASC;


-- 4) Find the names of all instructors who have taught courses during the 2010 “Summer” semester (sort by name in the ascending order).

SELECT DISTINCT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN section s ON t.course_id = s.course_id AND t.sec_id = s.sec_id
WHERE s.semester = 'Summer' AND s.year = 2010
ORDER BY i.name ASC;

-- 5) Find the total amount that needs to be paid for the instructors in the “Comp. Sci.” Department.

SELECT SUM(salary) AS total_salary
FROM instructor
WHERE dept_name = 'Comp. Sci.';

-- 6) Find the number of instructors in “Finance” department.

SELECT COUNT(*) AS num_instructors
FROM instructor
WHERE dept_name = 'Finance';

-- 7) Find the name of the student who has taken the highest number of total credits.

SELECT name
FROM student
ORDER BY tot_cred DESC
LIMIT 1;

-- 8) For the student with ID “45678”, show all course_id, title, year, and semester of all courses registered for by the student  (sort by course_id).

SELECT c.course_id, c.title, s.year, s.semester
FROM takes t
JOIN course c ON t.course_id = c.course_id
JOIN section s ON t.course_id = s.course_id AND t.sec_id = s.sec_id AND t.semester = s.semester AND t.year = s.year
WHERE t.ID = '45678'
ORDER BY c.course_id;

-- 9) Find the names of students who are supervised by instructor “Einstein” (sort by student name in the ascending order). 

SELECT s.name
FROM student s
JOIN advisor a ON s.ID = a.s_ID
JOIN instructor i ON a.i_ID = i.ID
WHERE i.name = 'Einstein'
ORDER BY s.name ASC;

-- 10) Find the name of the course that is designated as a prerequisite by most number of courses (sort by course title in the ascending order).

SELECT c.title
FROM course c
JOIN prereq p ON c.course_id = p.prereq_id
GROUP BY p.prereq_id
ORDER BY COUNT(*) DESC, c.title ASC
LIMIT 1;

-- 11) Find the names of all students who have taken any Comp. Sci. course ever (there should be no duplicate names and they should be sorted by student name in the ascending order). 
SELECT DISTINCT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE c.dept_name = 'Comp. Sci.'
ORDER BY s.name ASC;


-- 12) Display the IDs of all instructors who have never taught a course (sort by instructor ID in ascending order).

SELECT ID
FROM instructor
WHERE ID NOT IN (SELECT DISTINCT ID FROM teaches)
ORDER BY ID ASC;

-- 13) As in Q12, but display the names of the instructors also, not just the IDs (sort by instructor name in ascending order).
SELECT ID, name
FROM instructor
WHERE ID NOT IN (SELECT DISTINCT ID FROM teaches)
ORDER BY name ASC;


-- 14) How many “A” grades have been given for the course “Intro. to Computer Science”
SELECT COUNT(*) AS num_A_grades
FROM takes
WHERE course_id = 'CS-101' AND grade = 'A';


-- 15) Find the course names, year, semester, and grades obtained by the student “Shankar” (sort by course title in the ascending order).
SELECT c.title, t.year, t.semester, t.grade
FROM takes t
JOIN course c ON t.course_id = c.course_id
JOIN student s ON t.ID = s.ID
WHERE s.name = 'Shankar'
ORDER BY c.title ASC;


-- 16) List the names of all CS hundred level courses (Course codes that starts as CS-1). Sort by course title in descending order. 
SELECT title
FROM course
WHERE course_id LIKE 'CS-1%'
ORDER BY title DESC;


-- 17) Find the names of departments who have instructors that get annual salaries between 60,000 to 80,000 (sort by dept_name in ascending order and there should be no duplicates). 

SELECT DISTINCT dept_name
FROM instructor
WHERE salary BETWEEN 60000 AND 80000
ORDER BY dept_name ASC;

-- 18) List the names of instructors in ascending order with their respective salaries.
SELECT name, salary
FROM instructor
ORDER BY salary ASC, name ASC;


-- 19) Find the names and average salaries of all departments whose average salary is greater than 40,000 (sort by dept_name in the ascending order).
SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor
GROUP BY dept_name
HAVING avg_salary > 40000
ORDER BY dept_name ASC;


-- 20) Find names of instructors with salary greater than that of some (at least one) instructor in the “Biology” department (sort by instructor name in ascending order).

SELECT name
FROM instructor
WHERE salary > ANY (SELECT salary FROM instructor WHERE dept_name = 'Biology')
ORDER BY name ASC;


