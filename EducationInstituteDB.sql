/* Create an Education Institute database */
CREATE DATABASE EducationInstituteDB;
SHOW DATABASES;
USE EducationInstituteDB;
CREATE DATABASE EducationInstituteDB;

# Create Students table
# Stores student information such as ID, name, email, date of birth, and gender
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(100) NOT NULL, 
    email VARCHAR(100) UNIQUE NOT NULL, 
    dob DATE NOT NULL, 
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female'))
);

# Create Instructors table
# Stores information about instructors
CREATE TABLE Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(100) NOT NULL, 
    email VARCHAR(100) UNIQUE NOT NULL, 
    department VARCHAR(100) NOT NULL
);

# Create Courses table
# Stores course details including assigned instructor
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY, 
    course_name VARCHAR(100) NOT NULL, 
    instructor_id INT, 
    credits INT CHECK (credits > 0) NOT NULL, 
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id) ON DELETE SET NULL
);

# Create Enrollments table
# Tracks which students are enrolled in which courses
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY, 
    student_id INT, 
    course_id INT, 
    enroll_date DATE NOT NULL, 
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE, 
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

# Create Grades table
# Stores grades assigned to students
CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY, 
    enrollment_id INT, 
    grade DECIMAL(5,2) CHECK (grade BETWEEN 0 AND 100) NOT NULL, 
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id) ON DELETE CASCADE
);

# Insert Data into Students Table
INSERT INTO Students (name, email, dob, gender) VALUES
('Neeraja', 'neeraja@email.com', '2001-05-12', 'Female'),
('Vamsi', 'vamsi@email.com', '2000-08-23', 'Male'),
('Sai', 'sai@email.com', '2002-11-15', 'Male'),
('Chitti', 'chitti@email.com', '2003-07-19', 'Female'),
('Vinay', 'vinay@email.com', '2004-02-25', 'Male');

# Insert Data into Instructors Table
INSERT INTO Instructors (name, email, department) VALUES
('Pavani', 'pavani@email.com', 'Mathematics'),
('Navya', 'navya@email.com', 'Computer Science'),
('Raghu', 'raghu@email.com', 'Physics');

# Insert Sample Data into Courses
INSERT INTO Courses (course_id, course_name, instructor_id, credits) VALUES
(1, 'Database Systems', 1, 4),
(2, 'Data Structures', 1, 3),
(3, 'Linear Algebra', 2, 4),
(4, 'Quantum Mechanics', 3, 3);
SELECT * FROM Courses;


# Insert Sample Data into Enrollments
INSERT INTO Enrollments (student_id, course_id, enroll_date) VALUES
(1, 1, '2025-01-10'),
(2, 1, '2025-01-11'),
(3, 2, '2025-01-12'),
(4, 3, '2025-01-13'),
(5, 4, '2025-01-14');

# Insert grades into table
INSERT INTO Grades (enrollment_id, grade) VALUES
(1, 85.5),
(2, 78.0),
(3, 92.0),
(4, 88.0),
(5, 76.0);
SELECT * FROM Enrollments;

# Basic Queries
SELECT name FROM Students;
SELECT * FROM Students WHERE dob > '2001-05-12';
SELECT c.course_name FROM Courses c 
JOIN Instructors i ON c.instructor_id = i.instructor_id 
WHERE i.department = 'Computer Science';
SELECT * FROM Courses WHERE credits > 3 ORDER BY credits DESC;

# Aggregations and GROUP BY
SELECT course_id, COUNT(student_id) AS total_students FROM Enrollments GROUP BY course_id;
SELECT e.course_id, AVG(g.grade) AS average_grade FROM Grades g 
JOIN Enrollments e ON g.enrollment_id = e.enrollment_id 
GROUP BY e.course_id;
SELECT gender, COUNT(*) FROM Students GROUP BY gender;

# JOIN Queries
SELECT s.name, c.course_name FROM Students s 
JOIN Enrollments e ON s.student_id = e.student_id 
JOIN Courses c ON e.course_id = c.course_id;
SELECT c.course_name, i.name AS instructor FROM Courses c 
JOIN Instructors i ON c.instructor_id = i.instructor_id;
SELECT s.name, g.grade FROM Students s 
JOIN Enrollments e ON s.student_id = e.student_id 
JOIN Grades g ON e.enrollment_id = g.enrollment_id;

# Subqueries
SELECT s.name FROM Students s WHERE NOT EXISTS (
    SELECT c.course_id FROM Courses c WHERE c.instructor_id = 1
    EXCEPT
    SELECT e.course_id FROM Enrollments e WHERE e.student_id = s.student_id
);
SELECT course_id FROM Enrollments GROUP BY course_id ORDER BY COUNT(student_id) DESC LIMIT 1;
SELECT s.name FROM Students s 
JOIN Enrollments e ON s.student_id = e.student_id 
JOIN Grades g ON e.enrollment_id = g.enrollment_id 
WHERE g.grade > (SELECT AVG(grade) FROM Grades);

# Window Functions
SELECT e.course_id, s.name, g.grade, 
       RANK() OVER (PARTITION BY e.course_id ORDER BY g.grade DESC) AS `rank` 
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id;


SELECT enroll_date, COUNT(enrollment_id) 
       OVER (ORDER BY enroll_date) AS cumulative_enrollments 
FROM Enrollments;

SELECT s.name, 
       AVG(g.grade) OVER (PARTITION BY s.student_id) AS avg_student_grade, 
       AVG(g.grade) OVER () AS overall_avg 
FROM Students s 
JOIN Enrollments e ON s.student_id = e.student_id 
JOIN Grades g ON e.enrollment_id = g.enrollment_id;
