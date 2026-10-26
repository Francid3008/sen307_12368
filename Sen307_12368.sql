
CREATE DATABASE IF NOT EXISTS sen307_lab2;
USE sen307_12368;


DROP TABLE IF EXISTS ENROLMENT;
DROP TABLE IF EXISTS COURSE_ALLOCATION;
DROP TABLE IF EXISTS SESSION;
DROP TABLE IF EXISTS LECTURER;
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS STUDENT;
DROP TABLE IF EXISTS DEPARTMENT;




CREATE TABLE DEPARTMENT (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    dept_head VARCHAR(100) NOT NULL
) ENGINE=InnoDB;


CREATE TABLE STUDENT (
    student_id VARCHAR(20) PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    student_email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    CONSTRAINT fk_student_department
        FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE COURSE (
    course_code VARCHAR(10) PRIMARY KEY,
    course_title VARCHAR(100) NOT NULL,
    credit_units INT NOT NULL CHECK (credit_units > 0),
    department_id INT NOT NULL,
    CONSTRAINT fk_course_department
        FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE LECTURER (
    lecturer_id INT AUTO_INCREMENT PRIMARY KEY,
    lecturer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    CONSTRAINT fk_lecturer_department
        FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE SESSION (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    session_name VARCHAR(20) NOT NULL, 
    semester VARCHAR(10) NOT NULL     
) ENGINE=InnoDB;


CREATE TABLE COURSE_ALLOCATION (
    allocation_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) NOT NULL,
    lecturer_id INT NOT NULL,
    session_id INT NOT NULL,
    CONSTRAINT fk_alloc_course
        FOREIGN KEY (course_code) REFERENCES COURSE(course_code)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_alloc_lecturer
        FOREIGN KEY (lecturer_id) REFERENCES LECTURER(lecturer_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_alloc_session
        FOREIGN KEY (session_id) REFERENCES SESSION(session_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_course_session UNIQUE (course_code, lecturer_id, session_id)
) ENGINE=InnoDB;


CREATE TABLE ENROLMENT (
    enrolment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL,
    allocation_id INT NOT NULL,
    score DECIMAL(5,2) DEFAULT 0.00 CHECK (score >= 0.00 AND score <= 100.00),
    grade CHAR(1),
    CONSTRAINT fk_enrolment_student
        FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_enrolment_allocation
        FOREIGN KEY (allocation_id) REFERENCES COURSE_ALLOCATION(allocation_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_student_allocation UNIQUE (student_id, allocation_id)
) ENGINE=InnoDB;



INSERT INTO DEPARTMENT (department_name, dept_head) VALUES
('Software Engineering', 'Dr. Victor Ayamba'),
('Computer Science', 'Prof. O. Okonjo'),
('Mathematics', 'Dr. A. Bello');

INSERT INTO STUDENT (student_id, student_name, student_email, department_id) VALUES
('VUA/2024/001', 'Emmanuel David', 'emmanuel.d@veritas.edu.ng', 1),
('VUA/2024/002', 'Blessing Okoro', 'blessing.o@veritas.edu.ng', 1),
('VUA/2024/003', 'Francis Classics', 'francis.c@veritas.edu.ng', 2);

INSERT INTO COURSE (course_code, course_title, credit_units, department_id) VALUES
('SEN307', 'Database Systems', 3, 1),
('SEN305', 'Software Architecture', 3, 1),
('GST311', 'Entrepreneurship', 2, 1),
('MTH301', 'Numerical Methods', 3, 3);

INSERT INTO LECTURER (lecturer_name, email, department_id) VALUES
('Victor Ndoma Ayamba', 'ayamba.v@veritas.edu.ng', 1),
('Dr. Grace John', 'john.g@veritas.edu.ng', 1),
('Mr. Paul Usman', 'usman.p@veritas.edu.ng', 3);

INSERT INTO SESSION (session_name, semester) VALUES
('2025/2026', 'First'),
('2025/2026', 'Second');

INSERT INTO COURSE_ALLOCATION (course_code, lecturer_id, session_id) VALUES
('SEN307', 1, 1),
('SEN305', 2, 1),
('MTH301', 3, 1);

INSERT INTO ENROLMENT (student_id, allocation_id, score, grade) VALUES
('VUA/2024/001', 1, 75.00, 'A'),
('VUA/2024/001', 2, 68.00, 'B'),
('VUA/2024/002', 1, 88.00, 'A'),
('VUA/2024/003', 3, 55.00, 'C');


SELECT 'DATABASE SETUP COMPLETED SUCCESSFULLY' AS Status;