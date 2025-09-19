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
