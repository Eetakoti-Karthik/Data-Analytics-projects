-- Hospital Management System
-- Database & Table Setup
CREATE DATABASE hospital_db;
USE hospital_db;

-- Patients table
CREATE TABLE Patients (
    PatientID     INT AUTO_INCREMENT PRIMARY KEY,
    PName          VARCHAR(50) NOT NULL,
    Age           INT,
    Gender        ENUM('Male','Female','Other'),
    Phone         VARCHAR(15),
    City          VARCHAR(60),
    DateRegistered DATE DEFAULT(CURRENT_DATE)
);
desc Patients;
-- Doctors table
CREATE TABLE Doctors (
    DoctorID       INT AUTO_INCREMENT PRIMARY KEY,
    DName           VARCHAR(50) NOT NULL,
    Specialization VARCHAR(60),
    Phone          VARCHAR(15)
);
describe Doctors;

-- Appointments table
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID     INT,
    DoctorID      INT,
    AppDate       DATE NOT NULL,
    Status        ENUM('Scheduled','Completed','Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID)  REFERENCES Doctors(DoctorID)
);
desc Appointments;

-- Medications table
CREATE TABLE Medications (
    MedID       INT AUTO_INCREMENT PRIMARY KEY,
    PatientID   INT,
    DoctorID    INT,
    MedName     VARCHAR(100),
    Dosage      VARCHAR(50),
    PrescDate   DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID)  REFERENCES Doctors(DoctorID)
);
desc Medications;

-- Billing table
CREATE TABLE Billing (
    BillID    INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    Amount    DECIMAL(10,2),
    BillDate  DATE,
    Status    ENUM('Paid','Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);
desc Billing;

-- ***** Data inserted ******
INSERT INTO Patients (PName, Age, Gender, Phone, City) VALUES
('Amit Sharma',    34, 'Male',   '9876543210', 'Mumbai'),
('Priya Patel',    28, 'Female', '9876543211', 'Delhi'),
('Ravi K kumar',   62, 'Male',   '9876543212', 'Mumbai'),
('Sunita Verma',   45, 'Female', '9876543213', 'Pune'),
('Arjun Singh',    70, 'Male',   '9876543214', 'Chennai'),
('Neha Joshi',     23, 'Female', '9876543215', 'Mumbai'),
('Vikram Rathod',  55, 'Male',   '9876543216', 'Kolkata'),
('Pooja Reddy',    38, 'Female', '9876543217', 'Hyderabad'),
('Manish Gupta',   65, 'Male',   '9876543218', 'Delhi'),
('Anjali Nair',    41, 'Female', '9876543219', 'Mumbai');
select *from patients;

INSERT INTO Doctors (DName, Specialization, Phone) VALUES
('Dr. Sharma',  'Orthopedics',   '9111111111'),
('Dr. Mehta',   'Dermatology',   '9111111112'),
('Dr. Kapoor',  'Cardiology',    '9111111113'),
('Dr. Iyer',    'Neurology',     '9111111114'),
('Dr. Reddy',   'Dermatology',   '9111111115'),
('Dr. Bose',    'Orthopedics',   '9111111116');
select *from Doctors;

INSERT INTO Appointments (PatientID, DoctorID, AppDate, Status) VALUES
(1, 1, CURDATE(),              'Scheduled'),
(2, 2, CURDATE() - INTERVAL 1 DAY, 'Completed'),
(3, 1, CURDATE() - INTERVAL 2 DAY, 'Completed'),
(4, 3, CURDATE() - INTERVAL 3 DAY, 'Completed'),
(5, 1, CURDATE() - INTERVAL 4 DAY, 'Cancelled'),
(1, 3, CURDATE() - INTERVAL 5 DAY, 'Completed'),
(6, 2, CURDATE() - INTERVAL 6 DAY, 'Completed'),
(7, 4, CURDATE() - INTERVAL 7 DAY, 'Scheduled'),
(8, 5, CURDATE() - INTERVAL 8 DAY, 'Completed'),
(9, 1, CURDATE() - INTERVAL 9 DAY, 'Completed'),
(2, 3, CURDATE() - INTERVAL 10 DAY,'Completed'),
(1, 2, CURDATE() - INTERVAL 15 DAY,'Completed'),
(3, 4, CURDATE() - INTERVAL 20 DAY,'Completed'),
(10,1, CURDATE() - INTERVAL 25 DAY,'Completed'),
(4, 5, CURDATE() - INTERVAL 35 DAY,'Completed');
select *from Appointments;

INSERT INTO Medications (PatientID, DoctorID, MedName, Dosage, PrescDate) VALUES
(1, 1, 'Ibuprofen',    '400mg twice daily',  CURDATE() - INTERVAL 5 DAY),
(1, 3, 'Aspirin',      '75mg once daily',    CURDATE() - INTERVAL 5 DAY),
(1, 2, 'Cetirizine',   '10mg at night',      CURDATE() - INTERVAL 15 DAY),
(2, 2, 'Hydrocortisone','Apply twice daily', CURDATE() - INTERVAL 1 DAY),
(3, 1, 'Paracetamol',  '500mg thrice daily', CURDATE() - INTERVAL 2 DAY),
(4, 3, 'Metoprolol',   '50mg once daily',    CURDATE() - INTERVAL 3 DAY),
(4, 3, 'Amlodipine',   '5mg once daily',     CURDATE() - INTERVAL 3 DAY),
(4, 3, 'Atorvastatin', '20mg at night',      CURDATE() - INTERVAL 3 DAY),
(6, 2, 'Clindamycin',  '300mg twice daily',  CURDATE() - INTERVAL 6 DAY),
(8, 5, 'Tretinoin',    'Apply nightly',      CURDATE() - INTERVAL 8 DAY);
select *from Medications;

INSERT INTO Billing (PatientID, Amount, BillDate, Status) VALUES
(1,  5500.00,  CURDATE() - INTERVAL 5 DAY,  'Paid'),
(2,  3200.00,  CURDATE() - INTERVAL 1 DAY,  'Unpaid'),
(3,  8800.00,  CURDATE() - INTERVAL 2 DAY,  'Paid'),
(4,  12000.00, CURDATE() - INTERVAL 3 DAY,  'Unpaid'),
(5,  4500.00,  CURDATE() - INTERVAL 4 DAY,  'Paid'),
(6,  2100.00,  CURDATE() - INTERVAL 6 DAY,  'Unpaid'),
(7,  55000.00, CURDATE() - INTERVAL 7 DAY,  'Unpaid'),
(8,  3800.00,  CURDATE() - INTERVAL 8 DAY,  'Paid'),
(9,  9200.00,  CURDATE() - INTERVAL 9 DAY,  'Paid'),
(10, 6700.00,  CURDATE() - INTERVAL 25 DAY, 'Unpaid'),
(4,  62000.00, CURDATE() - INTERVAL 35 DAY, 'Unpaid');
select *from Billing;
