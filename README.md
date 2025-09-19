# Graduate Rotation Management Database

## Overview

This project implements a **relational database management system (RDBMS)** in MySQL to manage a graduate rotation program.
It is designed for organizations onboarding new graduate trainees through induction sessions and structured department rotations.

The database provides support for:

* Cohort management
* Learner profiles
* Department and mentor assignments
* Induction sessions
* Rotation periods and department slots
* Staff user management
* Attendance tracking
* Rotation evaluations
* Feedback collection
* A reporting view for current learner schedules

## Features

* **Relational schema** with primary and foreign key constraints.
* **One-to-One, One-to-Many, and Many-to-Many relationships** where applicable.
* **Data integrity enforcement** through constraints and unique indexes.
* **Support for evaluations and feedback** to track learner progress.
* **Predefined view** (`current_schedule_view`) for simplified reporting of rotation schedules.
* **Indexes** for optimized query performance on frequently searched columns.

## Database Schema

Key entities include:

* `cohorts`: Graduate program cohorts.
* `learners`: Individual learners within cohorts.
* `learner_profiles`: Additional learner details (one-to-one with learners).
* `departments`: Departments available for rotations.
* `mentors`: Mentors assigned to departments.
* `induction_sessions`: Cohort-level induction sessions.
* `rotation_periods`: Time-bound periods for department rotations.
* `department_rotation_slots`: Slots available per department during a rotation period.
* `rotation_assignments`: Learners assigned to specific department slots.
* `staff_users`: Staff managing the program.
* `attendance`: Attendance records for inductions and rotations.
* `evaluations`: Mentor evaluations of learners.
* `feedback`: Feedback from learners on sessions or rotations.

A database diagram can be generated using tools such as **MySQL Workbench** to visualize these relationships.

## Installation

1. Ensure you have MySQL installed and running.

2. Clone this repository or download the `.sql` file.

3. Open a terminal and run:

   ```bash
   mysql -u root -p < grad_rotation_db.sql
   ```

   Replace `root` with your MySQL username. You will be prompted for your password.

4. Verify the database is created:

   ```sql
   SHOW DATABASES;
   USE grad_rotation_db;
   SHOW TABLES;
   ```

## Usage

* Insert cohorts, learners, departments, and mentors first.
* Define induction sessions and rotation periods.
* Assign learners to department rotation slots.
* Track attendance, evaluations, and feedback.
* Query the `current_schedule_view` for a consolidated schedule of learners in rotations.

Example query to view all current learner schedules:

```sql
SELECT * FROM current_schedule_view;
```

## Indexes

Indexes have been created to optimize searches on:

* Rotation period dates (`rotation_periods`)
* Department rotation slot lookups (`department_rotation_slots`)
* Attendance tracking (`attendance`)

## Future Enhancements

* Add triggers to enforce department slot capacity.
* Implement stored procedures for automated learner assignment.
* Expand reporting views for analytics.

## Author
Maureen Chelangat.