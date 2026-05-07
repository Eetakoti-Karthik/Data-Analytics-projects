-- HR Employee Management System  –  MySQL

CREATE DATABASE hr_db;
USE hr_db;

# ─── Tables ────────
CREATE TABLE Departments (
    DeptID   INT AUTO_INCREMENT PRIMARY KEY,
    DeptName VARCHAR(80) NOT NULL,
    Location VARCHAR(80)
);
desc Departments;

CREATE TABLE  Employees (
    EmpID          INT AUTO_INCREMENT PRIMARY KEY,
    FirstName      VARCHAR(50),
    LastName       VARCHAR(50),
    Email          VARCHAR(100),
    Phone          VARCHAR(15),
    HireDate       DATE,
    JobTitle       VARCHAR(80),
    DeptID         INT,
    Salary         DECIMAL(10,2),
    ManagerID      INT,
    Status         ENUM('Active','Resigned','Terminated') DEFAULT 'Active',
    FOREIGN KEY (DeptID)    REFERENCES Departments(DeptID),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmpID)
);
desc Employees;

CREATE TABLE Attendance (
    AttendanceID INT AUTO_INCREMENT PRIMARY KEY,
    EmpID        INT,
    WorkDate     DATE,
    CheckIn      TIME,
    CheckOut     TIME,
    Status       ENUM('Present','Absent','Late','Leave') DEFAULT 'Present',
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);
desc Attendance;

CREATE TABLE Salaries (
    SalaryID   INT AUTO_INCREMENT PRIMARY KEY,
    EmpID      INT,
    PayMonth   DATE,
    BasicPay   DECIMAL(10,2),
    Bonus      DECIMAL(10,2) DEFAULT 0,
    Deductions DECIMAL(10,2) DEFAULT 0,
    NetPay     DECIMAL(10,2),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);
desc Salaries;

CREATE TABLE LeaveRequests (
    LeaveID   INT AUTO_INCREMENT PRIMARY KEY,
    EmpID     INT,
    LeaveType ENUM('Sick','Annual','Maternity','Unpaid'),
    StartDate DATE,
    EndDate   DATE,
    Status    ENUM('Pending','Approved','Rejected') DEFAULT 'Pending',
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);
desc LeaveRequests;

CREATE table PerformanceReviews (
    ReviewID   INT AUTO_INCREMENT PRIMARY KEY,
    EmpID      INT,
    ReviewDate DATE,
    Rating     TINYINT CHECK (Rating BETWEEN 1 AND 5),
    Comments   TEXT,
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);
desc PerformanceReviews;

-- ****** Data *******

INSERT INTO Departments (DeptName, Location) VALUES
('Engineering',   'Bangalore'),
('Sales',         'Mumbai'),
('HR',            'Delhi'),
('Finance',       'Mumbai'),
('Marketing',     'Delhi');
select * from Departments;

INSERT INTO Employees (FirstName, LastName, Email, Phone, HireDate, JobTitle, DeptID, Salary, ManagerID, Status) VALUES
('Rahul',   'Mehta',  'rahul@company.com',   '9800000001', '2019-03-15', 'Engineering Manager', 1, 120000, NULL,   'Active'),
('Priya',   'Sharma', 'priya@company.com',   '9800000002', '2020-06-01', 'Software Engineer',   1, 75000,  1,      'Active'),
('Vikram',  'Patel',  'vikram@company.com',  '9800000003', '2018-11-20', 'Sales Manager',       2, 95000,  NULL,   'Active'),
('Anita',   'Reddy',  'anita@company.com',   '9800000004', '2021-01-10', 'Sales Executive',     2, 55000,  3,      'Active'),
('Suresh',  'Kumar',  'suresh@company.com',  '9800000005', '2017-07-25', 'HR Manager',          3, 85000,  NULL,   'Active'),
('Neha',    'Joshi',  'neha@company.com',    '9800000006', '2022-03-05', 'HR Executive',        3, 50000,  5,      'Active'),
('Arun',    'Gupta',  'arun@company.com',    '9800000007', '2019-09-14', 'Finance Manager',     4, 110000, NULL,   'Active'),
('Pooja',   'Singh',  'pooja@company.com',   '9800000008', '2021-07-19', 'Accountant',          4, 60000,  7,      'Active'),
('Ravi',    'Nair',   'ravi@company.com',    '9800000009', '2020-04-22', 'Marketing Manager',   5, 90000,  NULL,   'Active'),
('Deepa',   'Iyer',   'deepa@company.com',   '9800000010', '2023-01-15', 'Marketing Executive', 5, 48000,  9,      'Active'),
('Karthik', 'Menon',  'karthik@company.com', '9800000011', '2016-08-30', 'Senior Engineer',     1, 95000,  1,      'Active'),
('Divya',   'Bose',   'divya@company.com',   '9800000012', '2022-11-01', 'Sales Executive',     2, 52000,  3,      'Resigned');
select * from Employees;

INSERT INTO Attendance (EmpID, WorkDate, CheckIn, CheckOut, Status) VALUES
(1, CURDATE() - INTERVAL 1 DAY, '09:00','18:00','Present'),
(2, CURDATE() - INTERVAL 1 DAY, '09:30','18:00','Late'),
(3, CURDATE() - INTERVAL 1 DAY, '09:00','18:00','Present'),
(4, CURDATE() - INTERVAL 1 DAY, NULL,   NULL,   'Absent'),
(5, CURDATE() - INTERVAL 1 DAY, '09:00','17:30','Present'),
(1, CURDATE() - INTERVAL 2 DAY, '09:05','18:00','Present'),
(2, CURDATE() - INTERVAL 2 DAY, '09:00','18:00','Present'),
(6, CURDATE() - INTERVAL 2 DAY, NULL,   NULL,   'Leave'),
(7, CURDATE() - INTERVAL 2 DAY, '09:00','18:30','Present'),
(8, CURDATE() - INTERVAL 2 DAY, '09:15','18:00','Late');
select * from Attendance;

INSERT INTO Salaries (EmpID, PayMonth, BasicPay, Bonus, Deductions, NetPay) VALUES
(1, '2025-03-01', 120000, 15000, 12000, 123000),
(2, '2025-03-01', 75000,  5000,  7500,  72500),
(3, '2025-03-01', 95000,  10000, 9500,  95500),
(4, '2025-03-01', 55000,  2000,  5500,  51500),
(5, '2025-03-01', 85000,  8000,  8500,  84500),
(6, '2025-03-01', 50000,  1500,  5000,  46500),
(7, '2025-03-01', 110000, 12000, 11000, 111000),
(8, '2025-03-01', 60000,  3000,  6000,  57000),
(9, '2025-03-01', 90000,  9000,  9000,  90000),
(10,'2025-03-01', 48000,  1000,  4800,  44200),
(11,'2025-03-01', 95000,  10000, 9500,  95500);
select * from Salaries;

INSERT INTO LeaveRequests (EmpID, LeaveType, StartDate, EndDate, Status) VALUES
(2, 'Sick',   CURDATE() - INTERVAL 10 DAY, CURDATE() - INTERVAL 8 DAY, 'Approved'),
(4, 'Annual', CURDATE() + INTERVAL 5 DAY,  CURDATE() + INTERVAL 9 DAY, 'Pending'),
(6, 'Annual', CURDATE() - INTERVAL 2 DAY,  CURDATE() + INTERVAL 1 DAY, 'Approved'),
(8, 'Sick',   CURDATE() - INTERVAL 1 DAY,  CURDATE(),                  'Approved'),
(10,'Annual', CURDATE() + INTERVAL 15 DAY, CURDATE() + INTERVAL 20 DAY,'Pending');
select * from LeaveRequests;

INSERT INTO PerformanceReviews (EmpID, ReviewDate, Rating, Comments) VALUES
(1, '2024-12-31', 5, 'Outstanding leadership'),
(2, '2024-12-31', 4, 'Consistently delivers quality work'),
(3, '2024-12-31', 4, 'Exceeded sales targets'),
(4, '2024-12-31', 3, 'Meets expectations, needs confidence'),
(5, '2024-12-31', 5, 'Excellent HR processes'),
(6, '2024-12-31', 3, 'Good team player'),
(7, '2024-12-31', 5, 'Strong financial leadership'),
(8, '2024-12-31', 4, 'Accurate and reliable'),
(9, '2024-12-31', 4, 'Creative marketing campaigns'),
(10,'2024-12-31', 2, 'Needs improvement in output quality');
select * from PerformanceReviews;

-- QUERIES for  ANALYSIS
-- 1. All employees with department and salary
SELECT e.EmpID,
       CONCAT(e.FirstName,' ',e.LastName) AS FullName,
       e.JobTitle,d.DeptName,e.Salary,e.Status
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
ORDER BY e.Salary DESC;

-- 2. Headcount(number for employee per department
SELECT d.DeptName,
       COUNT(e.EmpID)               AS HeadCount,
       ROUND(AVG(e.Salary), 2)      AS AvgSalary,
       SUM(e.Salary)                AS TotalSalaryBill
FROM Departments d
LEFT JOIN Employees e ON d.DeptID = e.DeptID AND e.Status = 'Active'
GROUP BY d.DeptID, d.DeptName
ORDER BY HeadCount DESC;

-- 3. Employees and their managers
SELECT 
    CONCAT(e.FirstName,' ',e.LastName)  AS Employee,
    e.JobTitle,
    CONCAT(m.FirstName,' ',m.LastName)  AS Manager
FROM Employees e 
LEFT JOIN Employees m ON e.ManagerID = m.EmpID;

-- 4. Attendance summary - present/late/absent per employee (last 7 days)
SELECT
    CONCAT(e.FirstName,' ',e.LastName) AS Employee,
    SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) AS Present,
    SUM(CASE WHEN a.Status = 'Late'    THEN 1 ELSE 0 END) AS Late,
    SUM(CASE WHEN a.Status = 'Absent'  THEN 1 ELSE 0 END) AS Absent
FROM Employees e
LEFT JOIN Attendance a ON e.EmpID = a.EmpID
    AND a.WorkDate >= CURDATE() - INTERVAL 7 DAY
GROUP BY e.EmpID, e.FirstName, e.LastName;

-- 5. Payroll summary for latest month using CTE
WITH latest_payroll AS (
    SELECT EmpID, NetPay, Bonus, Deductions, PayMonth
    FROM Salaries
    WHERE PayMonth = (SELECT MAX(PayMonth) FROM Salaries)
)
SELECT
    CONCAT(e.FirstName,' ',e.LastName) AS Employee,
    d.DeptName,lp.NetPay,lp.Bonus,lp.Deductions
FROM latest_payroll lp
JOIN Employees   e ON lp.EmpID   = e.EmpID
JOIN Departments d ON e.DeptID   = d.DeptID
ORDER BY lp.NetPay DESC;

-- 6. Employees with pending leave requests
SELECT
    CONCAT(e.FirstName,' ',e.LastName) AS Employee,
    lr.LeaveType,lr.StartDate,lr.EndDate,
    DATEDIFF(lr.EndDate, lr.StartDate) + 1 AS LeaveDays,lr.Status
FROM LeaveRequests lr
JOIN Employees e ON lr.EmpID = e.EmpID
WHERE lr.Status = 'Pending' ORDER BY lr.StartDate;

-- 7. Performance ratings with ranking using window function
SELECT
    CONCAT(e.FirstName,' ',e.LastName) AS Employee,
    d.DeptName,pr.Rating,pr.Comments,
    RANK() OVER (ORDER BY pr.Rating DESC)AS OverallRank,
    RANK() OVER (PARTITION BY d.DeptID ORDER BY pr.Rating DESC) AS RankInDept
FROM PerformanceReviews pr
JOIN Employees   e ON pr.EmpID   = e.EmpID
JOIN Departments d ON e.DeptID   = d.DeptID;

-- 8. Employees earning whose above the department average (correlated subquery is used)
SELECT
    CONCAT(e.FirstName,' ',e.LastName) AS Employee,
    d.DeptName,
    e.Salary,
    ROUND((SELECT AVG(e2.Salary) FROM Employees e2 WHERE e2.DeptID = e.DeptID), 2) AS DeptAvgSalary
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM Employees e2
    WHERE e2.DeptID = e.DeptID
)
ORDER BY e.Salary DESC;

-- 9. Attrition: employees who resigned/terminated
SELECT
    CONCAT(e.FirstName,' ',e.LastName) AS Employee,
    d.DeptName,e.JobTitle,e.HireDate,e.Status,
    DATEDIFF(CURDATE(), e.HireDate) AS DaysEmployed
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
WHERE e.Status IN ('Resigned','Terminated');

-- 10. Full HR dashboard summary.
WITH emp_stats AS (
    SELECT
        e.EmpID,
        CONCAT(e.FirstName,' ',e.LastName) AS FullName,
        d.DeptName,e.Salary,pr.Rating,
        (SELECT COUNT(*) FROM LeaveRequests lr WHERE lr.EmpID = e.EmpID AND lr.Status = 'Approved') AS LeaveTaken,
        (SELECT COUNT(*) FROM Attendance a WHERE a.EmpID = e.EmpID AND a.Status = 'Absent') AS AbsentDays
    FROM Employees e
    JOIN Departments d ON e.DeptID = d.DeptID
    LEFT JOIN PerformanceReviews pr ON e.EmpID = pr.EmpID
    WHERE e.Status = 'Active'
)
SELECT *,
    CASE
        WHEN Rating >= 4 AND AbsentDays <= 1 THEN 'High Performer'
        WHEN Rating = 3 THEN 'Meets Expectations'
        else 'Needs Attention'
    END AS PerformanceCategory
FROM emp_stats
ORDER BY Rating DESC, Salary DESC;
