-- CampusHire AI Sample Seed Data
-- Comprehensive Demo Dataset for Placement & Skill Matching Evaluation

USE campushire_ai;

-- Clear previous data in correct order
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE recommendations;
TRUNCATE TABLE applications;
TRUNCATE TABLE job_skills;
TRUNCATE TABLE jobs;
TRUNCATE TABLE certifications;
TRUNCATE TABLE projects;
TRUNCATE TABLE student_skills;
TRUNCATE TABLE skills;
TRUNCATE TABLE companies;
TRUNCATE TABLE students;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Insert Users (Admin, Recruiters, Students)
-- Passwords: 
-- admin123 for Admin
-- recruiter123 for Recruiters
-- student123 for Students
-- (Supports BCrypt hashes and fallback)
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

-- Update with readable fallback plain equivalents for demo resilience if tested with raw text
-- Note: PasswordUtil checks BCrypt first, then plaintext if needed.
UPDATE users SET password = 'admin123' WHERE id = 1;
UPDATE users SET password = 'recruiter123' WHERE id IN (2, 3, 4);
UPDATE users SET password = 'student123' WHERE id IN (5, 6, 7, 8, 9);

-- 2. Insert Companies
INSERT INTO companies (id, recruiter_id, company_name, industry, website, location, about, logo_url) VALUES
(1, 2, 'Google India', 'Technology & Internet', 'https://careers.google.com', 'Bengaluru / Hyderabad', 'Google is a global technology leader focused on improving the ways people connect with information.', 'https://images.unsplash.com/photo-1572021335469-31706a17aaef?w=120&auto=format&fit=crop&q=80'),
(2, 3, 'Microsoft Corporation', 'Software & Cloud Services', 'https://careers.microsoft.com', 'Bengaluru / Noida', 'Our mission is to empower every person and every organization on the planet to achieve more.', 'https://images.unsplash.com/photo-1642132652075-2b23a54b9d03?w=120&auto=format&fit=crop&q=80'),
(3, 4, 'Infosys Technologies', 'IT Consulting & Services', 'https://www.infosys.com/careers', 'Pune / Bengaluru / Chennai', 'A global leader in next-generation digital services and consulting, enabling clients across 56 countries.', 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=120&auto=format&fit=crop&q=80');

-- 3. Insert Students Profiles
INSERT INTO students (id, user_id, college_name, degree, branch, cgpa, graduation_year, roll_number, phone, bio, resume_url, github_url, linkedin_url) VALUES
(1, 5, 'National Institute of Technology', 'B.Tech', 'Computer Science and Engineering', 9.25, 2026, '22CS1045', '+91 9876543210', 'Aspiring Software Engineer passionate about Java backend architectures, distributed systems, and cloud-native applications.', 'https://drive.google.com/file/d/sample-riddhi-resume/view', 'https://github.com/riddhisharma', 'https://linkedin.com/in/riddhi-sharma'),
(2, 6, 'National Institute of Technology', 'B.Tech', 'Information Technology', 8.60, 2026, '22IT1012', '+91 9876543211', 'Full stack enthusiast with experience in Spring Boot, React, and containerization using Docker.', 'https://drive.google.com/file/d/sample-rahul-resume/view', 'https://github.com/rahulverma', 'https://linkedin.com/in/rahul-verma'),
(3, 7, 'National Institute of Technology', 'B.Tech', 'Electronics and Communication', 7.85, 2026, '22EC1030', '+91 9876543212', 'Interested in embedded systems, IoT, and cloud edge computing. Active open source contributor.', 'https://drive.google.com/file/d/sample-priya-resume/view', 'https://github.com/priyapatel', 'https://linkedin.com/in/priya-patel'),
(4, 8, 'Delhi Technological University', 'B.Tech', 'Mechanical Engineering', 6.95, 2026, '22ME1088', '+91 9876543213', 'Transitioning into software development with strong fundamentals in Python, SQL, and web technologies.', 'https://drive.google.com/file/d/sample-amit-resume/view', 'https://github.com/amitkumar', 'https://linkedin.com/in/amit-kumar'),
(5, 9, 'Indian Institute of Information Technology', 'B.Tech', 'Computer Science and Engineering', 8.90, 2026, '22CS2015', '+91 9876543214', 'Machine learning and backend systems developer with strong foundation in algorithms and clean code.', 'https://drive.google.com/file/d/sample-sneha-resume/view', 'https://github.com/sneharao', 'https://linkedin.com/in/sneha-rao');

-- 4. Master Skills Catalogue
INSERT INTO skills (id, name, category) VALUES
(1, 'Java', 'Programming'),
(2, 'Python', 'Programming'),
(3, 'C++', 'Programming'),
(4, 'Data Structures & Algorithms', 'Computer Science'),
(5, 'Spring Boot', 'Framework'),
(6, 'React.js', 'Web Development'),
(7, 'Node.js', 'Web Development'),
(8, 'MySQL', 'Database'),
(9, 'PostgreSQL', 'Database'),
(10, 'MongoDB', 'Database'),
(11, 'Docker', 'DevOps & Cloud'),
(12, 'Kubernetes', 'DevOps & Cloud'),
(13, 'AWS', 'DevOps & Cloud'),
(14, 'Azure', 'DevOps & Cloud'),
(15, 'Git & GitHub', 'Tools'),
(16, 'REST API', 'Web Development'),
(17, 'Machine Learning', 'Data Science & AI'),
(18, 'Deep Learning', 'Data Science & AI'),
(19, 'Linux & Shell Scripting', 'System'),
(20, 'Microservices Architecture', 'Architecture'),
(21, 'HTML5 & CSS3', 'Web Development'),
(22, 'JavaScript', 'Web Development'),
(23, 'Hibernate / JPA', 'Framework'),
(24, 'Apache Kafka', 'Distributed Systems'),
(25, 'Tableau', 'Data Science & AI');

-- 5. Student Skills Association
-- Riddhi (Student 1): Java, Spring Boot, MySQL, REST API, Git, Docker, Data Structures
INSERT INTO student_skills (student_id, skill_id, proficiency) VALUES
(1, 1, 'ADVANCED'),
(1, 4, 'ADVANCED'),
(1, 5, 'ADVANCED'),
(1, 8, 'INTERMEDIATE'),
(1, 15, 'ADVANCED'),
(1, 16, 'ADVANCED'),
(1, 11, 'INTERMEDIATE'),
(1, 23, 'INTERMEDIATE');

-- Rahul (Student 2): Java, React, Node.js, Spring Boot, MySQL, Docker, HTML5 & CSS3
INSERT INTO student_skills (student_id, skill_id, proficiency) VALUES
(2, 1, 'INTERMEDIATE'),
(2, 5, 'INTERMEDIATE'),
(2, 6, 'ADVANCED'),
(2, 8, 'INTERMEDIATE'),
(2, 11, 'INTERMEDIATE'),
(2, 16, 'ADVANCED'),
(2, 21, 'ADVANCED'),
(2, 22, 'ADVANCED');

-- Priya (Student 3): C++, Python, Linux, Azure, Git
INSERT INTO student_skills (student_id, skill_id, proficiency) VALUES
(3, 2, 'INTERMEDIATE'),
(3, 3, 'ADVANCED'),
(3, 14, 'BEGINNER'),
(3, 15, 'INTERMEDIATE'),
(3, 19, 'ADVANCED');

-- Amit (Student 4): Python, MySQL, HTML5 & CSS3
INSERT INTO student_skills (student_id, skill_id, proficiency) VALUES
(4, 2, 'INTERMEDIATE'),
(4, 8, 'BEGINNER'),
(4, 21, 'INTERMEDIATE'),
(4, 22, 'BEGINNER');

-- Sneha (Student 5): Python, Machine Learning, Java, PostgreSQL, Docker, Git
INSERT INTO student_skills (student_id, skill_id, proficiency) VALUES
(5, 1, 'INTERMEDIATE'),
(5, 2, 'ADVANCED'),
(5, 4, 'ADVANCED'),
(5, 9, 'INTERMEDIATE'),
(5, 11, 'INTERMEDIATE'),
(5, 15, 'ADVANCED'),
(5, 17, 'ADVANCED');

-- 6. Student Projects
INSERT INTO projects (student_id, title, description, tech_stack, project_url, github_url) VALUES
(1, 'CampusHire AI Matching Engine', 'A rule-based and machine-assisted skill matching engine using Java Servlets, JDBC, and MySQL with explainable decision support.', 'Java, Servlets, MySQL, Bootstrap 5, HikariCP', 'https://campushire-demo.com', 'https://github.com/riddhisharma/campushire-ai'),
(1, 'Microservices E-Commerce API', 'Scalable distributed backend service implementing JWT auth, payment gateway webhook handling, and Redis caching.', 'Java 17, Spring Boot, Redis, Docker, PostgreSQL', 'https://api.shopkart.com', 'https://github.com/riddhisharma/shop-backend'),
(2, 'Collaborative Task Management Board', 'Real-time Kanban board with drag-and-drop, WebSocket notifications, and user workspaces.', 'React, Spring Boot, MySQL, WebSocket', 'https://taskboard-demo.vercel.app', 'https://github.com/rahulverma/kanban-board'),
(3, 'Smart IoT Environmental Monitor', 'Embedded sensor system sending telemetry over MQTT to Azure IoT Hub with real-time alerting.', 'C++, ESP32, Azure IoT, Python', 'https://iot-dash.azurewebsites.net', 'https://github.com/priyapatel/iot-sensor-hub'),
(5, 'Predictive Student Placement Analytics', 'Machine learning classification model predicting placement readiness based on academic & coding challenge performance.', 'Python, Scikit-Learn, Flask, Pandas, PostgreSQL', 'https://placement-ml.streamlit.app', 'https://github.com/sneharao/placement-predictor');

-- 7. Student Certifications
INSERT INTO certifications (student_id, name, issuing_organization, issue_date, credential_url) VALUES
(1, 'Oracle Certified Professional: Java SE 17 Developer', 'Oracle University', '2025-06-15', 'https://catalog-education.oracle.com/ords/certview/sharebadge?id=OCP-JAVA-17'),
(1, 'AWS Certified Cloud Practitioner', 'Amazon Web Services', '2025-09-10', 'https://aws.amazon.com/verification/AWS-CCP-9872'),
(2, 'Meta Certified Front-End Developer', 'Coursera / Meta', '2025-04-20', 'https://coursera.org/verify/professional-cert/META-FED-332'),
(3, 'Microsoft Certified: Azure Fundamentals (AZ-900)', 'Microsoft', '2025-08-05', 'https://learn.microsoft.com/en-us/users/credentials/az900-priya'),
(5, 'Deep Learning Specialization', 'DeepLearning.AI', '2025-07-12', 'https://coursera.org/verify/specialization/DLAI-2025');

-- 8. Job Postings
INSERT INTO jobs (id, company_id, title, description, department, job_type, location, package_lpa, min_cgpa, eligible_branches, openings, deadline, status) VALUES
(1, 1, 'Software Development Engineer I (Java Backend)', 'We are looking for passionate Software Engineers to build scalable, fault-tolerant backend services powering Google Workspace and Cloud integrations. Candidates must demonstrate deep understanding of Core Java, data structures, and relational databases.', 'Engineering', 'FULL_TIME', 'Bengaluru, Karnataka', '18.0 - 24.0 LPA', 8.00, 'Computer Science and Engineering, Information Technology', 5, '2026-12-31', 'ACTIVE'),

(2, 2, 'Cloud Solutions & DevOps Engineer', 'Join Microsoft Azure engineering team to architect modern CI/CD pipelines, container orchestration, and cloud infrastructure monitoring. You will collaborate with cross-functional teams across the globe.', 'Azure Infrastructure', 'FULL_TIME', 'Hyderabad, Telangana', '16.0 - 20.0 LPA', 7.50, 'Computer Science and Engineering, Information Technology, Electronics and Communication', 3, '2026-11-30', 'ACTIVE'),

(3, 3, 'Systems Engineer - Digital Transformation', 'Infosys is hiring enthusiastic graduates for enterprise application modernization. You will work on full stack Java platforms, microservices architecture, and client-facing digital transformation projects.', 'Digital Enterprise', 'FULL_TIME', 'Pune / Bengaluru', '7.5 - 9.5 LPA', 6.50, 'All', 20, '2026-12-15', 'ACTIVE'),

(4, 1, 'Data Science & Machine Learning Intern', 'Exciting 6-month internship with Google Research India. Work alongside top scientists applying machine learning and statistical modeling to solve real-world problems at billion-user scale.', 'Google Research', 'INTERNSHIP', 'Bengaluru, Karnataka', '65,000 / month', 8.50, 'Computer Science and Engineering, Data Science', 2, '2026-10-31', 'ACTIVE'),

(5, 2, 'Software Engineer - Distributed Systems', 'Work on next-generation Microsoft 365 core distributed systems. Solve tough problems in fault tolerance, low latency, high throughput, and high reliability using C++, Java, and modern architectural patterns.', 'M365 Core', 'FULL_TIME', 'Noida / Bengaluru', '20.0 - 25.0 LPA', 8.20, 'Computer Science and Engineering, Information Technology', 4, '2026-12-30', 'ACTIVE');

-- 9. Job Required Skills
-- Job 1 (Google SDE-1 Java): Java (mandatory), Data Structures (mandatory), Spring Boot (mandatory), MySQL (mandatory), REST API (preferred), Docker (preferred)
INSERT INTO job_skills (job_id, skill_id, is_mandatory) VALUES
(1, 1, TRUE),   -- Java
(1, 4, TRUE),   -- Data Structures & Algorithms
(1, 5, TRUE),   -- Spring Boot
(1, 8, TRUE),   -- MySQL
(1, 16, FALSE), -- REST API
(1, 11, FALSE); -- Docker

-- Job 2 (Microsoft Cloud & DevOps): Azure (mandatory), Docker (mandatory), Kubernetes (mandatory), Linux (mandatory), Git (preferred)
INSERT INTO job_skills (job_id, skill_id, is_mandatory) VALUES
(2, 14, TRUE),  -- Azure
(2, 11, TRUE),  -- Docker
(2, 12, TRUE),  -- Kubernetes
(2, 19, TRUE),  -- Linux & Shell Scripting
(2, 15, FALSE); -- Git & GitHub

-- Job 3 (Infosys Systems Engineer): Java (mandatory), MySQL (mandatory), HTML5 & CSS3 (mandatory), JavaScript (preferred), REST API (preferred)
INSERT INTO job_skills (job_id, skill_id, is_mandatory) VALUES
(3, 1, TRUE),   -- Java
(3, 8, TRUE),   -- MySQL
(3, 21, TRUE),  -- HTML5 & CSS3
(3, 22, FALSE), -- JavaScript
(3, 16, FALSE); -- REST API

-- Job 4 (Google Data Science Intern): Python (mandatory), Machine Learning (mandatory), PostgreSQL (preferred), Git (preferred)
INSERT INTO job_skills (job_id, skill_id, is_mandatory) VALUES
(4, 2, TRUE),   -- Python
(4, 17, TRUE),  -- Machine Learning
(4, 9, FALSE),  -- PostgreSQL
(4, 15, FALSE); -- Git & GitHub

-- Job 5 (Microsoft Distributed Systems): C++ (mandatory), Data Structures (mandatory), Java (preferred), Linux (preferred)
INSERT INTO job_skills (job_id, skill_id, is_mandatory) VALUES
(5, 3, TRUE),   -- C++
(5, 4, TRUE),   -- Data Structures & Algorithms
(5, 1, FALSE),  -- Java
(5, 19, FALSE); -- Linux & Shell Scripting

-- 10. Student Applications
INSERT INTO applications (job_id, student_id, match_score, status, cover_letter, interview_date, recruiter_notes) VALUES
(1, 1, 95.50, 'SHORTLISTED', 'I have hands-on experience building production-ready Java microservices and solving algorithmic challenges. Google has always been my dream workplace!', '2026-10-25 14:00:00', 'Outstanding Java fundamentals and impressive project portfolio. Highly recommended for technical round 1.'),
(3, 1, 92.00, 'OFFERED', 'Excited to contribute to Infosys Digital Enterprise team with my Java and database development background.', NULL, 'Excellent profile. Offer rolled out for SDE track.'),
(1, 2, 84.50, 'IN_REVIEW', 'Strong full-stack foundation with Spring Boot and React. Eager to solve challenging problems at Google scale.', NULL, 'Profile currently under screening by engineering manager.'),
(3, 2, 89.00, 'INTERVIEW_SCHEDULED', 'Strong background in web frameworks, databases, and microservices.', '2026-10-22 11:30:00', 'Scheduled for technical interview on Google Meet.'),
(4, 5, 96.00, 'SHORTLISTED', 'Passionate about applied machine learning and statistical modeling with a verified Deep Learning specialization.', '2026-10-28 16:00:00', 'Exceptional domain knowledge in ML with hands-on research project.'),
(2, 3, 76.50, 'APPLIED', 'Strong background in systems programming, embedded devices, and cloud fundamentals.', NULL, 'Application received.');

-- 11. Cached Recommendations & Matching Breakdown
INSERT INTO recommendations (student_id, job_id, overall_score, skill_score, cgpa_score, branch_score, cert_score, project_score, missing_skills) VALUES
(1, 1, 95.50, 48.00, 20.00, 15.00, 8.00, 4.50, ''),
(1, 2, 45.00, 15.00, 20.00, 0.00, 6.00, 4.00, 'Azure, Kubernetes, Linux & Shell Scripting'),
(1, 3, 92.00, 45.00, 20.00, 15.00, 8.00, 4.00, ''),
(2, 1, 84.50, 40.00, 20.00, 15.00, 6.00, 3.50, 'Data Structures & Algorithms'),
(5, 4, 96.00, 48.00, 20.00, 15.00, 8.50, 4.50, '');
