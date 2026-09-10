-- ============================================
-- Hospital Management System - Database Schema
-- ============================================

CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- 1. ADMIN TABLE (login credentials for the system)
CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL
);

-- Default login: username = admin, password = admin123
INSERT INTO admin (username, password) VALUES ('admin', 'admin123');

-- 2. DOCTOR TABLE
CREATE TABLE doctor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);

-- 3. PATIENT TABLE
CREATE TABLE patient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    address VARCHAR(255),
    disease VARCHAR(255)
);

-- 4. APPOINTMENT TABLE (links patient <-> doctor)
CREATE TABLE appointment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patient(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctor(id) ON DELETE CASCADE
);

-- Sample data (optional)
INSERT INTO doctor (name, specialization, phone, email) VALUES
('Dr. Ashok Mehta', 'Cardiologist', '9876543210', 'ashok.mehta@hms.com'),
('Dr. Priya Sharma', 'Orthopedic', '9876543211', 'priya.sharma@hms.com');

INSERT INTO patient (name, age, gender, phone, address, disease) VALUES
('Ramesh Kumar', 45, 'Male', '9998887771', 'Lucknow, UP', 'Chest pain'),
('Sunita Verma', 30, 'Female', '9998887772', 'Kanpur, UP', 'Fracture');
