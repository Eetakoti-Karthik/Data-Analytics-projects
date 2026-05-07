Hospital Management System in MySQL

> Tool used: I used MySQL Workbench desktop app.  
> Description: This project was done while in my training at Besant Technologies after finishing my Sql course.
> Levels: In terms of difficulty there were three level of questions to be answered are given by the sql trainer which are Beginner (Q1–15), Intermediate (Q16–30), Advanced (Q31–40).

---
What this project is for:
This project solves every problem questions from the Hospital Management SQL pdf document given by my trainer in Besant Technologies. I built the database schema from scratch first,then created five tables covering patients, doctors, appointments, medications, and billing, then i wrote all 40 queries for it to answer the problems.
The schema was designed to make the queries actually meaningful rather than trivially simple. For example, some patients have appointments with multiple doctors, some have unpaid bills over Rs.50,000, and there are cancelled appointments and patients who've never been seen — which makes the more complex queries actually return useful results.
I used MySQL query Language in this project and used MySql Workbench 8.0 CE desktop application. This project showcases the skills i have learnt and provides practical hands-on experience.
---

Database Schema:
Patients :      PatientID, Name, Age, Gender, Phone, City
Doctors   :     DoctorID, Name, Specialization, Phone
Appointments :  AppointmentID, PatientID, DoctorID, AppDate, Status
Medications :   MedID, PatientID, DoctorID, MedName, Dosage, PrescDate
Billing :       BillID, PatientID, Amount, BillDate, Status
```

SQL concepts covered in this project:
 i implemented SELECT, WHERE, JOIN, LIKE, DISTINCT, CURDATE(),GROUP BY, HAVING, COUNT, SUM, AVG, subqueries, LEFT JOIN,CTEs-WITH(common table expression), 
 LAG() window function, CASE, multi-table aggregation.
---

Sample query i used in this project for quich review:
    Q21 — Latest appointment per patient
    >(MySQL)
    SELECT p.Name AS Patient, MAX(a.AppDate) AS LatestAppointment
    FROM Patients p
    JOIN Appointments a ON p.PatientID = a.PatientID
    GROUP BY p.PatientID, p.Name;

Files:
in HospitalManagentSystem folder,there are following files-> 
 1. `HMS_DataAndTables.sql` - Creates database, tables, and inserts data when queries are executed.
 2. `QueriesForHMS.sql`- All 40 questions with queries.
 3. `Hospital_Management_Question_pdf file`
 4. `Readme file`
---
