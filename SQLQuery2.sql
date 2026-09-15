USE ITI;
GO

--1
CREATE OR ALTER PROCEDURE GetStudentsCountPerDepartment
AS
BEGIN
    SELECT 
        d.Dept_Name,
        COUNT(s.St_Id) AS NumberOfStudents
    FROM Department d
    LEFT JOIN Student s
        ON d.Dept_Id = s.Dept_Id
    GROUP BY d.Dept_Name;
END;
GO
-----------------------------
--2
USE Company_SD;
GO
Select * from Project

CREATE OR ALTER PROCEDURE CheckP1Employees
AS
BEGIN
    DECLARE @CountEmployees INT;
    SELECT @CountEmployees = COUNT(*)
    FROM Works_for
    WHERE Pno = 1;
    IF @CountEmployees >= 3
    BEGIN
        PRINT 'The number of employees in the project p1 is 3 or more';
    END
    ELSE
    BEGIN
        PRINT 'The following employees work for the project p1';

        SELECT  e.Fname,e.Lname   
        FROM Employee e
        INNER JOIN Works_for w
            ON e.SSN = w.ESSn
        WHERE w.Pno = 1;
    END
END;
GO
-------------------------------------
--3
CREATE OR ALTER PROCEDURE ReplaceEmployee
    @OldEmpNo INT,
    @NewEmpNo INT,
    @ProjectNo INT
AS
BEGIN
    UPDATE Works_for
    SET ESSn = @NewEmpNo
    WHERE ESSn = @OldEmpNo
      AND Pno = @ProjectNo;
END;
GO
---------------------------
--4
ALTER TABLE Project
ADD Budget DECIMAL(18,2);

UPDATE Project
SET Budget = 95000
WHERE Pnumber = 100;

UPDATE Project
SET Budget = 120000
WHERE Pnumber = 200;

UPDATE Project
SET Budget = 150000
WHERE Pnumber = 300;

UPDATE Project
SET Budget = 180000
WHERE Pnumber = 400;

UPDATE Project
SET Budget = 200000
WHERE Pnumber = 500;

UPDATE Project
SET Budget = 220000
WHERE Pnumber = 600;

UPDATE Project
SET Budget = 250000
WHERE Pnumber = 700;

CREATE TABLE Project_Audit
(ProjectNo INT,
    UserName VARCHAR(100),
    ModifiedDate DATETIME,
    Budget_Old DECIMAL(18,2),
    Budget_New DECIMAL(18,2)   );

CREATE OR ALTER TRIGGER trg_Project_Budget_Audit
ON Project
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Budget)
    BEGIN
        INSERT INTO Project_Audit
        (ProjectNo, UserName,ModifiedDate,Budget_Old, Budget_New)
        SELECT
            i.Pnumber,SUSER_SNAME(), GETDATE(), d.Budget, i.Budget
        FROM inserted i
        INNER JOIN deleted d
            ON i.Pnumber = d.Pnumber;
    END
END;
GO

UPDATE Project
SET Budget = 200000
WHERE Pnumber = 100;
SELECT * FROM Project_Audit;
