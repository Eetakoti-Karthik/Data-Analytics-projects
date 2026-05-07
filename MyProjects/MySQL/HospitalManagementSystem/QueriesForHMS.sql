-- Hospital Management System
--  In this file –  All 40 Assignment Questions of the pdf are answered
-- Run HMS_DataAndTables.sql first to set up tables and data

USE hospital_db;

-- Q1. List all patients with their name, age, gender, and phone number.
SELECT PName, Age, Gender, Phone
FROM Patients;

-- Q2. List all doctors with their name and specialization.
SELECT DName, Specialization
FROM Doctors;

-- Q3. Show all appointments scheduled for today.
SELECT a.AppointmentID, p.PName AS Patient, d.DName AS Doctor, a.AppDate, a.Status
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors  d ON a.DoctorID  = d.DoctorID
WHERE a.AppDate = CURDATE();

-- Q4. Find the total number of patients in the system.
SELECT COUNT(*) AS TotalPatients FROM Patients;

-- Q5. Find the total number of doctors in the hospital.
SELECT COUNT(*) AS TotalDoctors FROM Doctors;

-- Q6. List all bills with status 'Paid'.
SELECT b.BillID, p.PName AS Patient, b.Amount, b.BillDate
FROM Billing b
JOIN Patients p ON b.PatientID = p.PatientID
WHERE b.Status = 'Paid';

-- Q7. List all bills with status 'Unpaid'.
SELECT b.BillID, p.PName AS Patient, b.Amount, b.BillDate
FROM Billing b
JOIN Patients p ON b.PatientID = p.PatientID
WHERE b.Status = 'Unpaid';

-- Q8. Display all medications prescribed to patient named 'Amit'.
-- i am Using LIKE keyword because there could be full name. i.e'Amit Sharma'.
SELECT m.MedName, m.Dosage, m.PrescDate, d.DName AS PrescribedBy
FROM Medications m
JOIN Patients p ON m.PatientID = p.PatientID
JOIN Doctors  d ON m.DoctorID  = d.DoctorID
WHERE p.PName LIKE '%Amit%';

-- Q9. Retrieve details of doctors who specialise in 'Orthopedics'.
SELECT DoctorID, DName, Specialization, Phone
FROM Doctors
WHERE Specialization = 'Orthopedics';

-- Q10. List names of patients older than 60.
SELECT PName, Age, City
FROM Patients
WHERE Age > 60;

-- Q11. Show all appointments for doctor named 'Dr. Sharma'.
SELECT a.AppointmentID, p.PName AS Patient, a.AppDate, a.Status
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors  d ON a.DoctorID  = d.DoctorID
WHERE d.DName = 'Dr. Sharma'
ORDER BY a.AppDate DESC;

-- Q12. Show phone numbers of patients who had appointments in the last 7 days.
SELECT DISTINCT p.PName, p.Phone
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
WHERE a.AppDate >= CURDATE() - INTERVAL 7 DAY;

-- Q13. Find all appointments that were cancelled.
SELECT a.AppointmentID, p.PName AS Patient, d.DName AS Doctor, a.AppDate
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors  d ON a.DoctorID  = d.DoctorID
WHERE a.Status = 'Cancelled';

-- Q14. Show all unique specializations available in the hospital.
SELECT DISTINCT Specialization
FROM Doctors
ORDER BY Specialization;

-- Q15. List patients who live in 'Mumbai'.
SELECT PName, Age, Gender, Phone
FROM Patients
WHERE City = 'Mumbai';

-- Q16. Count the number of appointments each doctor has had.
SELECT d.DName AS Doctor, d.Specialization,
       COUNT(a.AppointmentID) AS TotalAppointments
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.DName, d.Specialization
ORDER BY TotalAppointments DESC;

-- Q17. Find the number of appointments made by each patient.
SELECT p.PName AS Patient,
       COUNT(a.AppointmentID) AS TotalAppointments
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.PName
ORDER BY TotalAppointments DESC;

-- Q18. Calculate the total amount billed to each patient.
SELECT p.PName AS Patient,
       SUM(b.Amount)   AS TotalBilled,
       COUNT(b.BillID) AS NumberOfBills
FROM Patients p
JOIN Billing b ON p.PatientID = b.PatientID
GROUP BY p.PatientID, p.PName
ORDER BY TotalBilled DESC;

-- Q19. List all doctors who have more than 5 appointments.
SELECT d.DName AS Doctor, COUNT(a.AppointmentID) AS AppCount
FROM Doctors d
JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.DName
HAVING COUNT(a.AppointmentID) > 5;

-- Q20. Show patients who have been prescribed more than 2 medications.
SELECT p.PName AS Patient, COUNT(m.MedID) AS MedCount
FROM Patients p
JOIN Medications m ON p.PatientID = m.PatientID
GROUP BY p.PatientID, p.PName
HAVING COUNT(m.MedID) > 2;

-- Q21. Retrieve the latest appointment for each patient.
SELECT p.PName AS Patient, MAX(a.AppDate) AS LatestAppointment
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.PName;

-- Q22. Display patients who have unpaid bills greater than Rs.10,000.
SELECT p.PName AS Patient, b.Amount, b.BillDate
FROM Patients p
JOIN Billing b ON p.PatientID = b.PatientID
WHERE b.Status = 'Unpaid'
  AND b.Amount > 10000
ORDER BY b.Amount DESC;

-- Q23. List patients who have had appointments with more than one doctor.
SELECT p.PName AS Patient,
       COUNT(DISTINCT a.DoctorID) AS DoctorsSeen
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.PName
HAVING COUNT(DISTINCT a.DoctorID) > 1;

-- Q24. Show all patients who don't have any upcoming appointments.
-- "Upcoming" means which is scheduled or Appointment Date is greater than today date.
SELECT p.PName, p.Phone
FROM Patients p
WHERE p.PatientID NOT IN (
    SELECT DISTINCT PatientID
    FROM Appointments
    WHERE AppDate >= CURDATE()
      AND Status = 'Scheduled'
);

-- Q25. Find the total revenue generated in the current month.
SELECT SUM(Amount) AS MonthlyRevenue
FROM Billing
WHERE Status = 'Paid'
  AND MONTH(BillDate)  = MONTH(CURDATE())
  AND YEAR(BillDate)   = YEAR(CURDATE());

-- Q26. Show the number of medications prescribed to each patient.
SELECT p.PName AS Patient,
       COUNT(m.MedID) AS MedicationCount
FROM Patients p
LEFT JOIN Medications m ON p.PatientID = m.PatientID
GROUP BY p.PatientID, p.PName
ORDER BY MedicationCount DESC;

-- Q27. List all patients treated by doctors specialised in 'Dermatology'.
SELECT DISTINCT p.PName AS Patient, p.Age, p.City
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
JOIN Doctors d      ON a.DoctorID  = d.DoctorID
WHERE d.Specialization = 'Dermatology';

-- Q28. Show appointments grouped by status.
SELECT Status,
       COUNT(*) AS Count
FROM Appointments
GROUP BY Status;

-- Q29. Display the average bill amount for each patient.
SELECT p.PName AS Patient,
       ROUND(AVG(b.Amount), 2) AS AvgBillAmount,
       COUNT(b.BillID)         AS TotalBills
FROM Patients p
JOIN Billing b ON p.PatientID = b.PatientID
GROUP BY p.PatientID, p.PName
ORDER BY AvgBillAmount DESC;

-- Q30. Find doctors who have not had any appointments in the past 30 days.
SELECT d.DName AS Doctor, d.Specialization
FROM Doctors d
WHERE d.DoctorID NOT IN (
    SELECT DISTINCT DoctorID
    FROM Appointments
    WHERE AppDate >= CURDATE() - INTERVAL 30 DAY
);

-- Q31. Find the top 3 doctors with the most completed appointments.
SELECT d.DName AS Doctor, d.Specialization,
       COUNT(a.AppointmentID) AS CompletedCount
FROM Doctors d
JOIN Appointments a ON d.DoctorID = a.DoctorID
WHERE a.Status = 'Completed'
GROUP BY d.DoctorID, d.DName, d.Specialization
ORDER BY CompletedCount DESC
LIMIT 3;

-- Q32. List patients who have visited doctors of more than one specialization.
SELECT p.PName AS Patient,
       COUNT(DISTINCT d.Specialization) AS SpecializationsVisited
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
JOIN Doctors d      ON a.DoctorID  = d.DoctorID
GROUP BY p.PatientID, p.PName
HAVING COUNT(DISTINCT d.Specialization) > 1;

-- Q33. Generate a monthly report of total billed and paid amounts.
-- also included unpaid amounts so that we can get idea about how much amount is unpaid
SELECT
    YEAR(BillDate)  AS Year,
    MONTH(BillDate) AS Month,
    DATE_FORMAT(BillDate, '%b %Y') AS MonthYear,
    SUM(Amount) AS TotalBilled,
    SUM(CASE WHEN Status = 'Paid' THEN Amount ELSE 0 END)   AS TotalPaid,
    SUM(CASE WHEN Status = 'Unpaid' THEN Amount ELSE 0 END) AS TotalUnpaid
FROM Billing
GROUP BY YEAR(BillDate), MONTH(BillDate), DATE_FORMAT(BillDate, '%b %Y')
ORDER BY Year, Month;

-- Q34. Identify patients who have never had an appointment.
SELECT p.PName, p.Age, p.Phone
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
WHERE a.AppointmentID IS NULL;

-- Q35. Identify patients who have never been prescribed any medication.
SELECT p.PName, p.Age, p.City
FROM Patients p
LEFT JOIN Medications m ON p.PatientID = m.PatientID
WHERE m.MedID IS NULL;

-- Q36. Show patients with total unpaid bills exceeding Rs.50,000.
SELECT p.PName AS Patient,
       SUM(b.Amount) AS TotalUnpaid
FROM Patients p
JOIN Billing b ON p.PatientID = b.PatientID
WHERE b.Status = 'Unpaid'
GROUP BY p.PatientID, p.PName
HAVING SUM(b.Amount) > 50000
ORDER BY TotalUnpaid DESC;

-- Q37. Display the doctor who has treated the most unique patients.
SELECT d.DName AS Doctor, d.Specialization,
       COUNT(DISTINCT a.PatientID) AS UniquePatients
FROM Doctors d
JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.DName, d.Specialization
ORDER BY UniquePatients DESC
LIMIT 1;

-- Q38. List patients who had appointments on consecutive days.
select distinct a1.patientId from appointments a1 join appointments a2 on a1.patientId = a2.patientId and a2.appdate = a1.appdate + interval 1 day;

-- Q39. For each doctor, list their name and number of unique patients treated.
SELECT d.DName AS Doctor,
       d.Specialization,
       COUNT(DISTINCT a.PatientID) AS UniquePatients
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.DName, d.Specialization
ORDER BY UniquePatients DESC;

-- Q40. Report: patients, total appointments, total bill, medications count.
-- This is a nice summary CTE tying everything together
WITH appointment_counts AS (
    SELECT PatientID, COUNT(*) AS TotalAppointments
    FROM Appointments
    GROUP BY PatientID
),
bill_totals AS (
    SELECT PatientID, ROUND(SUM(Amount), 2) AS TotalBilled
    FROM Billing
    GROUP BY PatientID
),
med_counts AS (
    SELECT PatientID, COUNT(*) AS TotalMedications
    FROM Medications
    GROUP BY PatientID
)
SELECT
    p.PName AS Patient,
    p.Age,
    COALESCE(ac.TotalAppointments, 0) AS TotalAppointments,
    COALESCE(bt.TotalBilled,       0) AS TotalBilled,
    COALESCE(mc.TotalMedications,  0) AS TotalMedications
FROM Patients p
LEFT JOIN appointment_counts ac ON p.PatientID = ac.PatientID
LEFT JOIN bill_totals         bt ON p.PatientID = bt.PatientID
LEFT JOIN med_counts          mc ON p.PatientID = mc.PatientID
ORDER BY TotalBilled DESC;
