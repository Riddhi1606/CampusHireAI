-- CampusHire AI Sample Seed Data
-- Comprehensive Demo Dataset for Placement & Skill Matching Evaluation

USE campushire_ai;

SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 0;

-- Clean Reset
DROP DATABASE IF EXISTS campushire_ai;
CREATE DATABASE campushire_ai;
USE campushire_ai;

-- 1. Table Structures
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE companies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recruiter_id INT,
    company_name VARCHAR(150) NOT NULL,
    industry VARCHAR(100),
    website VARCHAR(255),
    location VARCHAR(150),
    about TEXT,
    logo_url VARCHAR(255),
    FOREIGN KEY (recruiter_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    college_name VARCHAR(150),
    degree VARCHAR(50),
    branch VARCHAR(100),
    cgpa DECIMAL(3,2),
    graduation_year INT,
    roll_number VARCHAR(50),
    phone VARCHAR(20),
    bio TEXT,
    resume_url VARCHAR(255),
    github_url VARCHAR(255),
    linkedin_url VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    category VARCHAR(100)
);

CREATE TABLE student_skills (
    student_id INT,
    skill_id INT,
    proficiency VARCHAR(20) DEFAULT 'INTERMEDIATE',
    PRIMARY KEY (student_id, skill_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    tech_stack VARCHAR(255),
    project_url VARCHAR(255),
    github_url VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

CREATE TABLE certifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    name VARCHAR(150) NOT NULL,
    issuing_organization VARCHAR(150),
    issue_date DATE,
    credential_url VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

CREATE TABLE jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    department VARCHAR(100),
    job_type VARCHAR(50) DEFAULT 'FULL_TIME',
    location VARCHAR(150),
    package_lpa VARCHAR(50),
    min_cgpa DECIMAL(3,2),
    eligible_branches VARCHAR(255),
    openings INT DEFAULT 1,
    deadline DATE,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);

CREATE TABLE job_skills (
    job_id INT,
    skill_id INT,
    is_mandatory BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

CREATE TABLE applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    student_id INT,
    match_score DECIMAL(5,2),
    status VARCHAR(30) DEFAULT 'APPLIED',
    cover_letter TEXT,
    interview_date DATETIME,
    recruiter_notes TEXT,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

CREATE TABLE recommendations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    job_id INT,
    overall_score DECIMAL(5,2),
    skill_score DECIMAL(5,2),
    cgpa_score DECIMAL(5,2),
    branch_score DECIMAL(5,2),
    cert_score DECIMAL(5,2),
    project_score DECIMAL(5,2),
    missing_skills TEXT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE
);

-- 2. Data Insertion
INSERT INTO users (user_id, email, password, role, full_name, is_active) VALUES
(1, 'admin@campushire.ai', '$2a$12$NqQ07N7o4gJ7dI93pI3pMe27Z8aV7bO.s3.7yW4/Q7W.k8d4l87u.', 'ADMIN', 'System Administrator', TRUE),
(2, 'recruiter@google.com', '$2a$12$tKzQ1L.1eW.zV7Q3I93pMe64X8aV7bO.s3.7yW4/Q7W.k8d4l87u.', 'RECRUITER', 'Sundar Pichai (Talent Acquisition)', TRUE),
(3, 'recruiter@microsoft.com', '$2a$12$tKzQ1L.1eW.zV7Q3I93pMe64X8aV7bO.s3.7yW4/Q7W.k8d4l87u.', 'RECRUITER', 'Satya N (University Recruiter)', TRUE),
(4, 'recruiter@infosys.com', '$2a$12$tKzQ1L.1eW.zV7Q3I93pMe64X8aV7bO.s3.7yW4/Q7W.k8d4l87u.', 'RECRUITER', 'Rajesh K (Lead Campus Recruiter)', TRUE),
(5, 'riddhi.sharma@college.edu', '$2a$12$vCzQ1L.1eW.zV7Q3I93pMe82Z8aV7bO.s3.7yW4/Q7W.k8d4l87u.', 'STUDENT', 'Riddhi Sharma', TRUE),
(6, 'rahul.verma@college.edu', '$2a$12$vCzQ1L.1eW.zV7Q3I93pMe82Z8aV7bO.s3.7yW4/Q7W.k8d4l87u.', 'STUDENT', 'Rahul Verma', TRUE),
(7, 'priya.patel@college.edu', '$2a$12$vCzQ1L.1eW.zV7Q3I93pMe82Z8aV7bO.s3.7yW4/Q7W.k8d4l87u.', 'STUDENT', 'Priya Patel', TRUE),
(8, 'amit.kumar@college.edu', '$2a$12$vCzQ1L.1eW.zV7Q3I93pMe82Z8aV7bO.s3.7yW4/Q7W.k8d4l87u.', 'STUDENT', 'Amit Kumar', TRUE),
(9, 'sneha.rao@college.edu', '$2a$12$vCzQ1L.1eW.zV7Q3I93pMe82Z8aV7bO.s3.7yW4/Q7W.k8d4l87u.', 'STUDENT', 'Sneha Rao', TRUE);

UPDATE users SET password = 'admin123' WHERE user_id = 1;
UPDATE users SET password = 'recruiter123' WHERE role = 'RECRUITER';
UPDATE users SET password = 'student123' WHERE role = 'STUDENT';

INSERT INTO companies (id, recruiter_id, company_name, industry, website, location, about, logo_url) VALUES
(1, 2, 'Google India', 'Technology & Internet', 'https://careers.google.com', 'Bengaluru / Hyderabad', 'Google is a global technology leader.', 'https://images.unsplash.com/photo-1572021335469-31706a17aaef'),
(2, 3, 'Microsoft Corporation', 'Software & Cloud Services', 'https://careers.microsoft.com', 'Bengaluru / Noida', 'Empower every person and organization.', 'https://images.unsplash.com/photo-1642132652075-2b23a54b9d03'),
(3, 4, 'Infosys Technologies', 'IT Consulting & Services', 'https://www.infosys.com/careers', 'Pune / Bengaluru / Chennai', 'Digital services and consulting.', 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab');

INSERT INTO students (id, user_id, college_name, degree, branch, cgpa, graduation_year, roll_number, phone, bio, resume_url, github_url, linkedin_url) VALUES
(1, 5, 'National Institute of Technology', 'B.Tech', 'Computer Science and Engineering', 9.25, 2026, '22CS1045', '+91 9876543210', 'Aspiring Software Engineer', 'https://drive.google.com', 'https://github.com/riddhisharma', 'https://linkedin.com/in/riddhi-sharma'),
(2, 6, 'National Institute of Technology', 'B.Tech', 'Information Technology', 8.60, 2026, '22IT1012', '+91 9876543211', 'Full stack enthusiast', 'https://drive.google.com', 'https://github.com/rahulverma', 'https://linkedin.com/in/rahul-verma'),
(3, 7, 'National Institute of Technology', 'B.Tech', 'Electronics and Communication', 7.85, 2026, '22EC1030', '+91 9876543212', 'IoT and Cloud enthusiast', 'https://drive.google.com', 'https://github.com/priyapatel', 'https://linkedin.com/in/priya-patel'),
(4, 8, 'Delhi Technological University', 'B.Tech', 'Mechanical Engineering', 6.95, 2026, '22ME1088', '+91 9876543213', 'Transitioning to software', 'https://drive.google.com', 'https://github.com/amitkumar', 'https://linkedin.com/in/amit-kumar'),
(5, 9, 'Indian Institute of Information Technology', 'B.Tech', 'Computer Science and Engineering', 8.90, 2026, '22CS2015', '+91 9876543214', 'ML & backend developer', 'https://drive.google.com', 'https://github.com/sneharao', 'https://linkedin.com/in/sneha-rao');

INSERT INTO skills (id, name, category) VALUES
(1, 'Java', 'Programming'), (2, 'Python', 'Programming'), (3, 'C++', 'Programming'),
(4, 'Data Structures & Algorithms', 'Computer Science'), (5, 'Spring Boot', 'Framework'),
(6, 'React.js', 'Web Development'), (7, 'Node.js', 'Web Development'), (8, 'MySQL', 'Database'),
(9, 'PostgreSQL', 'Database'), (10, 'MongoDB', 'Database'), (11, 'Docker', 'DevOps & Cloud'),
(12, 'Kubernetes', 'DevOps & Cloud'), (13, 'AWS', 'DevOps & Cloud'), (14, 'Azure', 'DevOps & Cloud'),
(15, 'Git & GitHub', 'Tools'), (16, 'REST API', 'Web Development'), (17, 'Machine Learning', 'Data Science & AI'),
(18, 'Deep Learning', 'Data Science & AI'), (19, 'Linux & Shell Scripting', 'System'),
(20, 'Microservices Architecture', 'Architecture'), (21, 'HTML5 & CSS3', 'Web Development'),
(22, 'JavaScript', 'Web Development'), (23, 'Hibernate / JPA', 'Framework'),
(24, 'Apache Kafka', 'Distributed Systems'), (25, 'Tableau', 'Data Science & AI');

INSERT INTO student_skills (student_id, skill_id, proficiency) VALUES
(1, 1, 'ADVANCED'), (1, 4, 'ADVANCED'), (1, 5, 'ADVANCED'), (1, 8, 'INTERMEDIATE'), (1, 15, 'ADVANCED'), (1, 16, 'ADVANCED'), (1, 11, 'INTERMEDIATE'), (1, 23, 'INTERMEDIATE'),
(2, 1, 'INTERMEDIATE'), (2, 5, 'INTERMEDIATE'), (2, 6, 'ADVANCED'), (2, 8, 'INTERMEDIATE'), (2, 11, 'INTERMEDIATE'), (2, 16, 'ADVANCED'), (2, 21, 'ADVANCED'), (2, 22, 'ADVANCED'),
(3, 2, 'INTERMEDIATE'), (3, 3, 'ADVANCED'), (3, 14, 'BEGINNER'), (3, 15, 'INTERMEDIATE'), (3, 19, 'ADVANCED'),
(4, 2, 'INTERMEDIATE'), (4, 8, 'BEGINNER'), (4, 21, 'INTERMEDIATE'), (4, 22, 'BEGINNER'),
(5, 1, 'INTERMEDIATE'), (5, 2, 'ADVANCED'), (5, 4, 'ADVANCED'), (5, 9, 'INTERMEDIATE'), (5, 11, 'INTERMEDIATE'), (5, 15, 'ADVANCED'), (5, 17, 'ADVANCED');

INSERT INTO projects (id, student_id, title, description, tech_stack, project_url, github_url) VALUES
(1, 1, 'CampusHire AI Matching Engine', 'Rule-based skill matching engine', 'Java, Servlets, MySQL', 'https://demo.com', 'https://github.com/riddhisharma'),
(2, 1, 'Microservices E-Commerce API', 'Scalable distributed backend service', 'Java 17, Spring Boot', 'https://api.com', 'https://github.com/riddhisharma'),
(3, 2, 'Collaborative Task Management Board', 'Real-time Kanban board', 'React, Spring Boot', 'https://task.com', 'https://github.com/rahulverma'),
(4, 3, 'Smart IoT Environmental Monitor', 'Embedded sensor system', 'C++, ESP32, Azure', 'https://iot.com', 'https://github.com/priyapatel'),
(5, 5, 'Predictive Student Placement Analytics', 'Machine learning classification model', 'Python, Scikit-Learn', 'https://ml.com', 'https://github.com/sneharao');

INSERT INTO certifications (id, student_id, name, issuing_organization, issue_date, credential_url) VALUES
(1, 1, 'Oracle Certified Professional: Java SE 17 Developer', 'Oracle University', '2025-06-15', 'https://oracle.com'),
(2, 1, 'AWS Certified Cloud Practitioner', 'Amazon Web Services', '2025-09-10', 'https://aws.amazon.com'),
(3, 2, 'Meta Certified Front-End Developer', 'Coursera / Meta', '2025-04-20', 'https://coursera.org'),
(4, 3, 'Microsoft Certified: Azure Fundamentals (AZ-900)', 'Microsoft', '2025-08-05', 'https://microsoft.com'),
(5, 5, 'Deep Learning Specialization', 'DeepLearning.AI', '2025-07-12', 'https://coursera.org');

INSERT INTO jobs (id, company_id, title, description, department, job_type, location, package_lpa, min_cgpa, eligible_branches, openings, deadline, status) VALUES
(1, 1, 'Software Development Engineer I (Java Backend)', 'Build scalable backend services powering Google Workspace.', 'Engineering', 'FULL_TIME', 'Bengaluru, Karnataka', '18.0 - 24.0 LPA', 8.00, 'Computer Science and Engineering, Information Technology', 5, '2026-12-31', 'ACTIVE'),
(2, 2, 'Cloud Solutions & DevOps Engineer', 'Architect modern CI/CD pipelines and container orchestration.', 'Azure Infrastructure', 'FULL_TIME', 'Hyderabad, Telangana', '16.0 - 20.0 LPA', 7.50, 'Computer Science and Engineering, Information Technology', 3, '2026-11-30', 'ACTIVE'),
(3, 3, 'Systems Engineer - Digital Transformation', 'Enterprise application modernization with Java platforms.', 'Digital Enterprise', 'FULL_TIME', 'Pune / Bengaluru', '7.5 - 9.5 LPA', 6.50, 'All', 20, '2026-12-15', 'ACTIVE'),
(4, 1, 'Data Science & Machine Learning Intern', 'Internship applying machine learning at scale.', 'Google Research', 'INTERNSHIP', 'Bengaluru, Karnataka', '65,000 / month', 8.50, 'Computer Science and Engineering, Data Science', 2, '2026-10-31', 'ACTIVE'),
(5, 2, 'Software Engineer - Distributed Systems', 'Work on Microsoft 365 core distributed systems.', 'M365 Core', 'FULL_TIME', 'Noida / Bengaluru', '20.0 - 25.0 LPA', 8.20, 'Computer Science and Engineering, Information Technology', 4, '2026-12-30', 'ACTIVE');

INSERT INTO job_skills (job_id, skill_id, is_mandatory) VALUES
(1, 1, TRUE), (1, 4, TRUE), (1, 5, TRUE), (1, 8, TRUE), (1, 16, FALSE), (1, 11, FALSE),
(2, 14, TRUE), (2, 11, TRUE), (2, 12, TRUE), (2, 19, TRUE), (2, 15, FALSE),
(3, 1, TRUE), (3, 8, TRUE), (3, 21, TRUE), (3, 22, FALSE), (3, 16, FALSE),
(4, 2, TRUE), (4, 17, TRUE), (4, 9, FALSE), (4, 15, FALSE),
(5, 3, TRUE), (5, 4, TRUE), (5, 1, FALSE), (5, 19, FALSE);

INSERT INTO applications (id, job_id, student_id, match_score, status, cover_letter, interview_date, recruiter_notes) VALUES
(1, 1, 1, 95.50, 'SHORTLISTED', 'Hands-on experience building production-ready Java services.', '2026-10-25 14:00:00', 'Outstanding Java fundamentals.'),
(2, 3, 1, 92.00, 'OFFERED', 'Excited to contribute to Infosys Digital team.', NULL, 'Offer rolled out.'),
(3, 1, 2, 84.50, 'IN_REVIEW', 'Strong full-stack foundation.', NULL, 'Under screening.'),
(4, 3, 2, 89.00, 'INTERVIEW_SCHEDULED', 'Strong background in web frameworks.', '2026-10-22 11:30:00', 'Scheduled for interview.'),
(5, 4, 5, 96.00, 'SHORTLISTED', 'Passionate about applied machine learning.', '2026-10-28 16:00:00', 'Exceptional ML knowledge.'),
(6, 2, 3, 76.50, 'APPLIED', 'Strong background in systems programming.', NULL, 'Application received.');

INSERT INTO recommendations (id, student_id, job_id, overall_score, skill_score, cgpa_score, branch_score, cert_score, project_score, missing_skills) VALUES
(1, 1, 1, 95.50, 48.00, 20.00, 15.00, 8.00, 4.50, ''),
(2, 1, 2, 45.00, 15.00, 20.00, 0.00, 6.00, 4.00, 'Azure, Kubernetes, Linux & Shell Scripting'),
(3, 1, 3, 92.00, 45.00, 20.00, 15.00, 8.00, 4.00, ''),
(4, 2, 1, 84.50, 40.00, 20.00, 15.00, 6.00, 3.50, 'Data Structures & Algorithms'),
(5, 5, 4, 96.00, 48.00, 20.00, 15.00, 8.50, 4.50, '');

-- Re-enable safety rules
SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1;
