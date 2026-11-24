USE sen307_11369;

-- 1. Insert Departments
INSERT INTO Department (dept_name) VALUES
('Software Engineering'),
('Computer Science'),
('Artificial Intelligence'),
('Data Science'),
('Cybersecurity');

-- 2. Insert Courses
INSERT INTO Course (course_code, course_title, credit_units, description, dept_id) VALUES
('SEN307', 'Database Systems', 3,
'Relational database design, SQL queries, normalization, transactions and indexing using MySQL.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('SEN301', 'Software Architecture', 3,
'Architectural styles, design patterns, microservices and how to structure large software systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('COS301', 'Operating Systems', 3, 'Processes, threads, CPU scheduling, memory management and file systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('COS305', 'Computer Networks', 3,
'TCP/IP, routing, switching, LAN and WAN design and network protocols.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('AIN301', 'Introduction to Artificial Intelligence', 3,
'Intelligent agents, search algorithms, knowledge representation and reasoning.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN305', 'Machine Learning', 3,
'Supervised and unsupervised learning, neural networks, deep learning and model evaluation.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN307', 'Natural Language Processing', 3,
'Text processing, word embeddings, language models, sentiment analysis and chatbots.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('DTS301', 'Data Visualization and Analytics', 2,
'Exploratory data analysis, charts, dashboards and telling stories with data.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('DTS305', 'Big Data Technologies', 3,
'Distributed storage and processing of very large datasets with Hadoop and Spark.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('CYB301', 'Network Security', 3,
'Firewalls, cryptography, intrusion detection and protecting networks from attacks.',
(SELECT dept_id FROM Department WHERE dept_name = 'Cybersecurity'));

SELECT d.dept_name, COUNT(c.course_id) AS courses
FROM Department d LEFT JOIN Course c ON d.dept_id = c.dept_id
GROUP BY d.dept_id, d.dept_name;

-- 3. Insert Lecturers
INSERT INTO Lecturer (staff_no, full_name, email, dept_id) VALUES
('VUA/ST/101','Dr Jullius Okafor','Okafor@gmail.com',1),
('VUA/ST/102','Dr Musa Bello', 'Musa@gmail.com', 1),
('VUA/ST/103', 'Dr Kamara Jibril', 'Jibril@gmail.com', 1),
('VUA/ST/104', 'Prof. James Chukwudi', 'Chukwudi@gmail.com', 1),
('VUA/ST/105', 'Prof. John Kamal', 'Kamal@gmail.com', 1),
('VUA/ST/106', 'Prof. Isaac Bright', 'Isaac@gmail.com', 1),
('VUA/ST/107', 'Prof. Mark Okafor', 'Mark@gmail.com', 1),
('VUA/ST/108', 'Prof. Nkechi Mmadu', 'Nkechi@gmail.com', 2),
('VUA/ST/109', 'Prof. Nnamdi Emmanuel', 'Emma@gmail.com', 1),
('VUA/ST/110', 'Dr Abin Micheal', 'Micheal@gmail.com', 1);

-- 4. Insert Students (Fixed unique matric numbers and valid department IDs 1-5)
INSERT INTO Student (matric_no, full_name, gender, date_of_birth, dept_id) VALUES
('20231234', 'Ada Obi', 'F', '2005-03-14', 1),
('20231235', 'John Musa', 'M', '2004-11-02', 2),
('12368', 'Eleje Francis', 'M', '2008-11-02', 3),
('20231236', 'James Abin', 'M', '2004-11-02', 4),
('20231237', 'Chukwudi Flavian', 'M', '2004-11-02', 5),
('20231238', 'Kemi Fola', 'M', '2004-11-02', 1),
('20231239', 'Nkechi Rose', 'F', '2005-11-02', 2),
('20231240', 'Jibril Adams', 'M', '2006-11-02', 3),
('20231241', 'Safia Marie', 'F', '2007-11-02', 4),
('20231242', 'Mary Jane', 'F', '2008-11-02', 5);

SELECT student_id, matric_no, full_name FROM Student;
SELECT lecturer_id, full_name FROM Lecturer;

-- 5. Insert Enrolments (Total 40 rows)
INSERT INTO Enrolment (student_id, course_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4),
(2, 1), (2, 2), (2, 3), (2, 5),
(3, 2), (3, 3), (3, 4), (3, 5),
(4, 1), (4, 3), (4, 4), (4, 5),
(5, 1), (5, 2), (5, 4), (5, 5),
(6, 1), (6, 2), (6, 3), (6, 5),
(7, 1), (7, 2), (7, 3), (7, 5),
(8, 1), (8, 2), (8, 4), (8, 5),
(9, 1), (9, 3), (9, 4), (9, 5),
(10, 1), (10, 2), (10, 3), (10, 4);

-- 6. Insert Course Allocations
INSERT INTO CourseAllocation (course_id, lecturer_id) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (2, 5), (4, 2), (5, 2), (8, 2);

-- 7. Update Example
SET SQL_SAFE_UPDATES = 0;
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '20231234';
UPDATE Student SET dept_id = 2 WHERE matric_no = '20231234';
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '20231234';
SET SQL_SAFE_UPDATES = 1;

-- 8. Department Transfer & Deletion Test (Fixed multiline string)
INSERT INTO Department (dept_name) VALUES ('Library and Information Science');

INSERT INTO Student (matric_no, full_name, dept_id)
VALUES ('20239999', 'Transfer Student',
(SELECT dept_id FROM Department WHERE dept_name = 'Library and Information Science'));

-- Step 1: Reassign the dependent student to another department
UPDATE Student
SET dept_id = (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')
WHERE matric_no = '20239999';

-- Step 2: Delete succeeds
DELETE FROM Department WHERE dept_name = 'Library and Information Science';
SELECT * FROM Department;

-- 9. Summary Counts
SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers', COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students', COUNT(*) FROM Student
UNION ALL SELECT 'Courses', COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments', COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;