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

