-- Create Database
DROP DATABASE IF EXISTS grad_rotation_db;
CREATE DATABASE grad_rotation_db;
USE grad_rotation_db;

-- cohorts
CREATE TABLE cohorts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  start_date DATE NOT NULL,
  end_date DATE DEFAULT NULL,
  description TEXT
);

-- learners
CREATE TABLE learners (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cohort_id INT NOT NULL,
  first_name VARCHAR(80) NOT NULL,
  last_name VARCHAR(80) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(30),
  date_of_birth DATE DEFAULT NULL,
  joined_date DATE NOT NULL,
  status ENUM('active','completed','withdrawn','on_hold') NOT NULL DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_learners_cohort FOREIGN KEY (cohort_id) REFERENCES cohorts(id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- learner_profiles (one-to-one)
CREATE TABLE learner_profiles (
  learner_id INT PRIMARY KEY,
  address VARCHAR(255),
  emergency_contact_name VARCHAR(120),
  emergency_contact_phone VARCHAR(30),
  education_summary TEXT,
  linkedin_url VARCHAR(255),
  CONSTRAINT fk_profile_learner FOREIGN KEY (learner_id) REFERENCES learners(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- departments
CREATE TABLE departments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(20) NOT NULL UNIQUE,
  name VARCHAR(120) NOT NULL,
  location VARCHAR(120),
  description TEXT
);

-- mentors
CREATE TABLE mentors (
  id INT AUTO_INCREMENT PRIMARY KEY,
  department_id INT NOT NULL,
  first_name VARCHAR(80) NOT NULL,
  last_name VARCHAR(80) NOT NULL,
  email VARCHAR(150),
  phone VARCHAR(30),
  role VARCHAR(100),
  is_primary BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_mentors_department FOREIGN KEY (department_id) REFERENCES departments(id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- induction_sessions
CREATE TABLE induction_sessions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cohort_id INT NOT NULL,
  session_date DATE NOT NULL,
  title VARCHAR(150) NOT NULL,
  agenda TEXT,
  duration_hours DECIMAL(4,2) DEFAULT 3.00,
  CONSTRAINT fk_induction_cohort FOREIGN KEY (cohort_id) REFERENCES cohorts(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE KEY ux_induction_cohort_date (cohort_id, session_date)
);

-- rotation_periods
CREATE TABLE rotation_periods (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cohort_id INT NOT NULL,
  name VARCHAR(150) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  notes TEXT,
  CONSTRAINT fk_rotation_cohort FOREIGN KEY (cohort_id) REFERENCES cohorts(id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- department_rotation_slots
CREATE TABLE department_rotation_slots (
  id INT AUTO_INCREMENT PRIMARY KEY,
  rotation_period_id INT NOT NULL,
  department_id INT NOT NULL,
  capacity INT DEFAULT 5,
  notes TEXT,
  CONSTRAINT fk_slot_rotation FOREIGN KEY (rotation_period_id) REFERENCES rotation_periods(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_slot_department FOREIGN KEY (department_id) REFERENCES departments(id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  UNIQUE KEY ux_slot_rotation_department (rotation_period_id, department_id)
);

-- staff_users
CREATE TABLE staff_users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(80) NOT NULL UNIQUE,
  first_name VARCHAR(80),
  last_name VARCHAR(80),
  email VARCHAR(150) UNIQUE,
  role VARCHAR(80),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

