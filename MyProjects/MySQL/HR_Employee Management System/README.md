HR Employee Management System — MySQL

> Tool used : I used MySQL Workbench desktop application.  
> Type: self-designed project(schema + analysis)  
> Dataset or data used: Custom(self given data)

---
About the Project:
I built this as a realistic HR database that a small company might actually use. The idea was to go beyond simple SELECT queries and design something with proper relationships — managers linking back to employees, attendance tied to specific dates, salary records by month, and performance reviews.
I researched and used data and ideas from various websites so that i can use it in this project. Then I answered 10 analysis queries that answer Business requirement problems that an HR team would genuinely care about: who's earning above their department average, which employees are high risk for leaving, what does the full performance picture look like per person. These query questions are generated with the help of AI and i used it to solve them.
I used MySQL Language to do this project and used MySql Workbench 8.0 CE desktop application. This project showcases the skills i have learnt and provides me practical hands-on experience.

---
Database Schema:
Departments        - DeptID, DeptName, Location
Employees          - EmpID, Name, JobTitle, DeptID, Salary, ManagerID, Status
Attendance         - EmpID, WorkDate, CheckIn, CheckOut, Status
Salaries           - EmpID, PayMonth, BasicPay, Bonus, Deductions, NetPay
LeaveRequests      - EmpID, LeaveType, StartDate, EndDate, Status
PerformanceReviews - EmpID, ReviewDate, Rating (1 – 5), Comments(or remarks)
```
The `ManagerID` in Employees is that we need a LEFT JOIN back to the same table to get manager names.
---

Queries  for Analysis:
#  I used the following business questions to write queries and get Solutions. 
  1 All employees with dept & salary
  2 | Headcount & salary per department
  3 | Employee–manager relationships
  4 | Attendance summary last 7 days
  5 | Latest payroll summary 
  6 | Pending leave requests
  7 | Performance rankings 
  8 | Employees above dept average
  9 | Resigned/terminated employees
  10 | Full HR dashboard report 
---

Files:
in HR_EmployeeSystem folder,it consists of the  following files->
1. `HR_Employee_Management_System_dataAnd.queries.sql`- It establishes a Full schema, data inserted, and answers all 10 analysis queries when executed.
2. `Readme file`

