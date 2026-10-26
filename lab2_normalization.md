VERITAS UNIVERSITY, ABUJA
​DEPARTMENT OF SOFTWARE ENGINEERING
​VUA-SEN307: Database Systems — Week 4 Practical (Lab 2)
​Document: Normalization Report (1NF to 3NF)
​1. Scenario Analysis & Unnormalized Form (UNF)
​System Context
​The course-registration system tracks Students, Departments, Lecturers, Courses, Course Allocations, and Student Enrolments.
​Unnormalized Flat Table (UNF)
​In an unnormalized registration record, repeating groups exist for each course a student registers for during a given session:
​REGISTRATION_UNF (student_id, student_name, student_email, dept_name, dept_head, (course_code, course_title, credit_units, lecturer_name, lecturer_email, session_year, score, grade))
​2. First Normal Form (1NF)
​Rule
​Eliminate repeating groups, ensure all attributes hold atomic (single) values, and define a Primary Key.
​Action Taken
​Flatten the table by expanding repeating course entries into distinct rows. The Primary Key becomes a composite key: (student_id, course_code, session_year).
​1NF Schema
​REGISTRATION_1NF (student_id, course_code, session_year, student_name, student_email, dept_name, dept_head, course_title, credit_units, lecturer_name, lecturer_email, score, grade)
​3. Second Normal Form (2NF)
​Rule
​Meet 1NF requirements and remove partial dependencies (every non-key attribute must depend on the entire composite primary key).
​Functional Dependencies Identified
​FD1 (Full Composite Key): {student_id, course_code, session_year}  {score, grade}
​FD2 (Partial Dependency - Student): {student_id}  {student_name, student_email, dept_name, dept_head}
​FD3 (Partial Dependency - Course): {course_code}  {course_title, credit_units}
​FD4 (Partial Dependency - Course Allocation): {course_code, session_year}  {lecturer_name, lecturer_email}
​2NF Schema Decomposition
​STUDENT_2NF (student_id, student_name, student_email, dept_name, dept_head)
​COURSE_2NF (course_code, course_title, credit_units)
​ALLOCATION_2NF (allocation_id, course_code, session_year, lecturer_name, lecturer_email)
​ENROLMENT_2NF (enrolment_id, student_id, allocation_id, score, grade)
​4. Third Normal Form (3NF)
​Rule
​Meet 2NF requirements and remove transitive dependencies (no non-key attribute should depend on another non-key attribute).
​Transitive Dependencies Identified
​In STUDENT_2NF: {student_id}  {dept_name}  {dept_head}. (dept_head depends transitively on student_id through dept_name).
​In ALLOCATION_2NF: {allocation_id}  {lecturer_email}  {lecturer_name}.
​Final 3NF Schema Decomposition
​1. DEPARTMENT
​dept_id (PK)
​dept_name
​dept_head
​2. STUDENT
​student_id (PK)
​student_name
​student_email
​dept_id (FK  DEPARTMENT.dept_id)
​3. COURSE
​course_code (PK)
​course_title
​credit_units
​dept_id (FK  DEPARTMENT.dept_id)
​4. LECTURER
​lecturer_id (PK)
​lecturer_name
​lecturer_email
​dept_id (FK  DEPARTMENT.dept_id)
​5. COURSE_ALLOCATION
​allocation_id (PK)
​course_code (FK  COURSE.course_code)
​lecturer_id (FK  LECTURER.lecturer_id)
​session_year
​6. ENROLMENT
​enrolment_id (PK)
​student_id (FK  STUDENT.student_id)
​allocation_id (FK  COURSE_ALLOCATION.allocation_id)
​score
​grade