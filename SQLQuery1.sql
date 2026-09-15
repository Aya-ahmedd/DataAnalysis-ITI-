--Day 5
USE ITI;
GO
--1 Number of students who have a value in their age
SELECT * FROM Student;
SELECT COUNT(St_Age) AS NumberOfStudents
FROM Student;

--2 Get all instructors Names without repetition
SELECT DISTINCT Ins_Name FROM Instructor

--3 Display student with the following Format (use isNull function)
SELECT S.St_Id AS [Student ID],S.St_Fname + ' ' + ISNULL(S.St_Lname, '') AS [Student Full Name],ISNULL(D.Dept_Name, 'No Department') AS [Department Name]
FROM Student S
LEFT JOIN Department D
    ON S.Dept_Id = D.Dept_Id;

--4
SELECT S.St_Id AS [Student ID],S.St_Fname + ' ' + ISNULL(S.St_Lname, '') AS [Student Full Name],ISNULL(D.Dept_Name, 'No Department') AS [Department Name]
FROM Student S
LEFT JOIN Department D
    ON S.Dept_Id = D.Dept_Id;

--5
SELECT S.St_Fname + ' ' + ISNULL(S.St_Lname, '') AS [Student Full Name],
       C.Crs_Name AS [Course Name]
FROM Student S
JOIN Stud_Course SC
    ON S.St_Id = SC.St_Id
JOIN Course C
    ON SC.Crs_Id = C.Crs_Id
WHERE SC.Grade IS NOT NULL;

--6
SELECT T.Top_Name,
       COUNT(C.Crs_Id) AS NumberOfCourses
FROM Topic T
LEFT JOIN Course C
    ON T.Top_Id = C.Top_Id
GROUP BY T.Top_Name;

--7
SELECT MAX(Salary) AS MaxSalary,MIN(Salary) AS MinSalary FROM Instructor;

--8
SELECT *
FROM Instructor
WHERE Salary < (
    SELECT AVG(Salary)
    FROM Instructor
);

--9
SELECT D.Dept_Name
FROM Department D
JOIN Instructor I
    ON D.Dept_Id = I.Dept_Id
WHERE I.Salary = (
    SELECT MIN(Salary)
    FROM Instructor
);

--10
SELECT DISTINCT Salary
FROM Instructor I1
WHERE 2 > (
    SELECT COUNT(DISTINCT Salary)
    FROM Instructor I2
    WHERE I2.Salary > I1.Salary
)
ORDER BY Salary DESC;

--11
SELECT Ins_Name,
       COALESCE(CAST(Salary AS VARCHAR(20)), 'Instructor Bonus') AS Salary
FROM Instructor;

--12
SELECT AVG(Salary) AS AverageSalary
FROM Instructor;

--13
SELECT S.St_Fname AS StudentName,
       Sup.St_Id AS SupervisorID,
       Sup.St_Fname AS SupervisorFirstName,
       Sup.St_Lname AS SupervisorLastName
FROM Student S
LEFT JOIN Student Sup
    ON S.St_super = Sup.St_Id;

--14
CREATE VIEW StudentCourseAbove50
AS
SELECT S.St_Fname + ' ' + ISNULL(S.St_Lname, '') AS StudentFullName,
       C.Crs_Name AS CourseName
FROM Student S
JOIN Stud_Course SC
    ON S.St_Id = SC.St_Id
JOIN Course C
    ON SC.Crs_Id = C.Crs_Id
WHERE SC.Grade > 50;
GO

SELECT *
FROM StudentCourseAbove50;

--15
CREATE VIEW ManagerTopics
AS
SELECT I.Ins_Name AS ManagerName,
       T.Top_Name AS TopicName
FROM Department D
JOIN Instructor I
    ON D.Dept_Manager = I.Ins_Id
JOIN Ins_Course IC
    ON I.Ins_Id = IC.Ins_Id
JOIN Course C
    ON IC.Crs_Id = C.Crs_Id
JOIN Topic T
    ON C.Top_Id = T.Top_Id;
GO

SELECT *
FROM ManagerTopics;
-----------
SELECT *
FROM Department;

SELECT *
FROM Topic;

SELECT *
FROM Instructor;

SELECT *
FROM Course;

SELECT *
FROM Ins_Course;


