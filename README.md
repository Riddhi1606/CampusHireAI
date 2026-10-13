# CampusHire AI — Intelligent Placement & Skill Matching Platform

<p align="center">
  <strong>A Java Enterprise placement platform that connects students with relevant job opportunities through explainable, transparent 5-pillar skill matching.</strong>
</p>

<p align="center">
  <img alt="Backend-Java" src="https://img.shields.io/badge/Backend-Java%2017-orange">
  <img alt="Web-Servlets%20JSP" src="https://img.shields.io/badge/Web-Servlets%20%7C%20JSP%20%7C%20JSTL-blue">
  <img alt="Database-MySQL" src="https://img.shields.io/badge/Database-MySQL%208-4479A1">
  <img alt="Server-Apache%20Tomcat%209" src="https://img.shields.io/badge/Server-Apache%20Tomcat%209-yellow">
  <img alt="Security-BCrypt" src="https://img.shields.io/badge/Security-BCrypt%20%7C%20RBAC-green">
  <img alt="Build-Maven" src="https://img.shields.io/badge/Build-Maven%20WAR-red">
  <img alt="Project Status-Production Ready" src="https://img.shields.io/badge/Status-Completed-success">
</p>

---

## 📌 Table of Contents

1. [Executive Summary](#executive-summary)
2. [Problem Statement & Objectives](#problem-statement--objectives)
3. [System Architecture](#system-architecture)
4. [Explainable 5-Pillar Skill-Matching Engine](#explainable-5-pillar-skill-matching-engine)
5. [Role-Based Feature Matrix](#role-based-feature-matrix)
6. [Database Schema & Entity Relationships](#database-schema--entity-relationships)
7. [Default Test & Demo Credentials](#default-test--demo-credentials)
8. [Local Installation & Setup Guide](#local-installation--setup-guide)
9. [Project Directory Layout](#project-directory-layout)
10. [12-Week Development Roadmap & Contribution Log](#12-week-development-roadmap--contribution-log)
11. [Testing & Quality Assurance](#testing--quality-assurance)
12. [Deployment & Production Packaging](#deployment--production-packaging)

---

## 📖 Executive Summary

**CampusHire AI** is a full-featured Java EE / Jakarta web application designed to modernize university placement departments and corporate talent acquisition. By moving away from subjective or black-box recruitment pipelines, CampusHire AI computes an **explainable compatibility score** for every applicant based on mathematically normalized, transparent weighted criteria.

Students gain actionable visibility into missing skills (Skill Gap Roadmaps), recruiters receive sorted candidate pipelines with granular match justifications, and university administrators govern the entire placement ecosystem in real-time.

---

## 🎯 Problem Statement & Objectives

### Problem
- **Fragmented Discovery:** Students struggle to navigate disjointed placement notices across message boards and emails.
- **Skill Blindspots:** Fresh graduates frequently lack insight into why they are screened out or which exact technologies they need to learn for high-value roles.
- **Manual Recruiter Screening:** Campus recruiters drown in hundreds of unstructured resumes without clear eligibility or skills verification.

### Objectives
- Establish a single, centralized web application supporting Students, Corporate Recruiters, and Placement Administrators.
- Implement a **transparent 5-pillar scoring algorithm** implemented in pure Java.
- Provide a personalized **Market Skill Gap Roadmap** highlighting high-demand competencies.
- Enforce strict role-based access control (RBAC), BCrypt password hashing, and SQL injection prevention via PreparedStatements.

---

## 🏛 System Architecture

The project adheres to a strict MVC (Model-View-Controller) enterprise layered architecture:

```text
                           [ Web Browser / Client ]
                                      |
                     HTTP / HTTPS Requests (UTF-8, Sessions)
                                      |
                          +-----------v-----------+
                          |   Filter Chain Layer  |
                          | (Encoding, Auth/RBAC) |
                          +-----------+-----------+
                                      |
                         +------------v------------+
                         | Java Servlets Controller|
                         |   (com.campushire.      |
                         |       controller)       |
                         +------------+------------+
                                      |
                   +------------------+------------------+
                   |                                     |
         +---------v---------+                 +---------v---------+
         |   Service Layer   |                 | Presentation / JSP|
         | (Auth, Matching,  |                 | (Bootstrap 5, JS, |
         | Student, Recruiter|                 | JSTL, Chart.js)   |
         +---------+---------+                 +-------------------+
                   |
         +---------v---------+
         |     DAO Layer     |
         |  (PreparedStmt)   |
         +---------+---------+
                   |
         +---------v---------+
         | HikariCP Connection|
         |       Pool        |
         +---------+---------+
                   |
         +---------v---------+
         |  MySQL Database   |
         |  (campushire_ai)  |
         +-------------------+
```

---

## 🧮 Explainable 5-Pillar Skill-Matching Engine

The compatibility score between a Candidate ($C$) and a Job Opening ($J$) is calculated using a rule-based formula normalized between 0 and 100%:

$$\text{Overall Compatibility Score} = \sum_{i=1}^{5} (W_i \times S_i)$$

| Pillar | Criterion | Weight ($W_i$) | Normalization Formula ($S_i$) |
|---|---|:---:|---|
| **1** | **Required Technical Skills** | **50%** | Ratio of matched mandatory ($1.5\times$) & preferred ($1.0\times$) skills with proficiency modifiers (Advanced: $+10\%$, Beginner: $-15\%$). |
| **2** | **CGPA / Academic Cutoff** | **20%** | Validates cutoff ($\text{CGPA}_{student} \ge \text{CGPA}_{min}$). Includes academic excellence scaling up to 10.0. Penalty applied if cutoff not met. |
| **3** | **Branch Eligibility** | **15%** | Evaluates listed target branches (e.g., CSE, IT, ECE, or All-disciplines). |
| **4** | **Verified Certifications** | **10%** | Counts accredited credentials (AWS, Oracle, Google Cloud) and relevance to job tech stack. |
| **5** | **Projects Portfolio** | **5%** | Evaluates GitHub projects and tech stack keywords overlap. |
| **Total** | | **100%** | Final rounded score with actionable advice and missing skill badges. |

---

## 👥 Role-Based Feature Matrix

| Feature | Student | Recruiter | Administrator |
|---|:---:|:---:|:---:|
| Self-Registration & BCrypt Auth | ✅ | ✅ | 🔒 (Controlled only) |
| Academic Profile (CGPA, Branch, Year) | ✅ | — | ✅ (Review only) |
| Skill Management (Proficiency levels) | ✅ | — | ✅ (Master Catalog) |
| Project & Certification Portfolio | ✅ | — | — |
| Job Exploration & Live Compatibility | ✅ | — | ✅ (Moderation) |
| 1-Click Application Submission | ✅ | — | — |
| Status Tracking (Applied &rarr; Offer) | ✅ | ✅ | ✅ |
| Skill Gap Roadmap & Upskilling Advice | ✅ | — | — |
| Post/Edit Job with Skill Weights | — | ✅ | ✅ |
| Candidate Pipeline Evaluation | — | ✅ | — |
| Interview Scheduling & Notes | — | ✅ | — |
| Platform Analytics & In-Demand Charts | — | — | ✅ |

---

## 🗄 Database Schema & Entity Relationships

The relational database is named `campushire_ai` and consists of 11 normalized tables:

1. `users`: Credentials, email, BCrypt password, system role (`STUDENT`, `RECRUITER`, `ADMIN`), active status.
2. `students`: Education profile, college, branch, CGPA, graduation year, phone, resume URL, GitHub/LinkedIn.
3. `companies`: Recruiter organization profile, industry, website, location, logo URL.
4. `skills`: Master taxonomy catalog with category classifications.
5. `student_skills`: Foreign key bridge with `proficiency` (`BEGINNER`, `INTERMEDIATE`, `ADVANCED`).
6. `projects`: Student software portfolio items with tech stack and repository URLs.
7. `certifications`: Professional licenses and verification links.
8. `jobs`: Placement openings, package/CTC, min CGPA, target branches, deadlines, status.
9. `job_skills`: Job requirements with `is_mandatory` weightage flags.
10. `applications`: Application status pipeline (`APPLIED`, `IN_REVIEW`, `SHORTLISTED`, `INTERVIEW_SCHEDULED`, `OFFERED`, `REJECTED`), interview date, recruiter feedback notes.
11. `recommendations`: Cached explainable score breakdowns.

---

## 🔑 Default Test & Demo Credentials

Pre-loaded with sample data in `database/seed_data.sql`:

| Role | Email Address | Password | Profile Details |
|---|---|---|---|
| **Student (High Match)** | `riddhi.sharma@college.edu` | `student123` | B.Tech CSE, 9.25 CGPA, Java/Spring Boot/Docker/AWS certified |
| **Student (Full Stack)** | `rahul.verma@college.edu` | `student123` | B.Tech IT, 8.60 CGPA, React, Node.js, Spring Boot |
| **Student (ECE / Embedded)** | `priya.patel@college.edu` | `student123` | B.Tech ECE, 7.85 CGPA, C++, Python, Azure certified |
| **Recruiter 1** | `recruiter@google.com` | `recruiter123` | Google India (SDE-1 & ML Internships) |
| **Recruiter 2** | `recruiter@microsoft.com` | `recruiter123` | Microsoft (Azure Cloud & Distributed Systems) |
| **Recruiter 3** | `recruiter@infosys.com` | `recruiter123` | Infosys Technologies (Systems Engineer) |
| **System Administrator** | `admin@campushire.ai` | `admin123` | Root Governance & Analytics Dashboard |

*Note: On the login page, you can also use the 1-Click quick fill buttons to instantly test any profile without typing credentials!*

---

## ⚙️ Local Installation & Setup Guide

### Prerequisites
- **JDK 17** or higher
- **MySQL Server 8.0**
- **Apache Tomcat 9.0**
- **Eclipse IDE for Enterprise Java and Web Developers** (or IntelliJ IDEA Ultimate)
- **Maven** (built into Eclipse / IntelliJ)

### Step 1: Database Setup
1. Open MySQL Workbench or MySQL CLI:
   ```bash
   mysql -u root -p
   ```
2. Execute the schema script:
   ```sql
   source /path/to/CampusHireAI/database/schema.sql;
   ```
3. Load the sample evaluation data:
   ```sql
   source /path/to/CampusHireAI/database/seed_data.sql;
   ```

### Step 2: Configure Database Credentials
Edit `src/main/resources/db.properties` with your local MySQL password:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/campushire_ai?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata&characterEncoding=UTF-8
db.username=root
db.password=YOUR_MYSQL_PASSWORD
```

### Step 3: Import into Eclipse IDE
1. Open Eclipse &rarr; **File** &rarr; **Import** &rarr; **Maven** &rarr; **Existing Maven Projects**.
2. Browse to the `CampusHireAI` root folder and click **Finish**.
3. Right click project &rarr; **Maven** &rarr; **Update Project** (Alt + F5).
4. Configure Apache Tomcat 9 under the **Servers** tab.
5. Right click project &rarr; **Run As** &rarr; **Run on Server** &rarr; select Tomcat 9.

### Step 4: Access in Web Browser
Open your browser and navigate to:
```text
http://localhost:8080/CampusHireAI/
```

---

## 📁 Project Directory Layout

```text
CampusHireAI/
├── pom.xml
├── README.md
├── .gitignore
├── database/
│   ├── schema.sql
│   └── seed_data.sql
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── campushire/
        │           ├── controller/
        │           │   ├── auth/          # Login, Register, Logout
        │           │   ├── student/       # Dashboard, Jobs, Apply, Portfolio, SkillGap
        │           │   ├── recruiter/     # Dashboard, PostJob, ManageJobs, Applicants
        │           │   └── admin/         # Dashboard, Users, Jobs, Skills Taxonomy
        │           ├── dao/               # UserDAO, StudentDAO, JobDAO, ApplicationDAO, etc.
        │           ├── filter/            # EncodingFilter (UTF-8), AuthFilter (RBAC)
        │           ├── model/             # User, Student, Company, Job, MatchResult, etc.
        │           ├── service/           # MatchingService, AuthService, StudentService, etc.
        │           └── util/              # DBConnection (HikariCP), PasswordUtil (BCrypt), DateUtil
        ├── resources/
        │   └── db.properties
        └── webapp/
            ├── assets/
            │   ├── css/                   # style.css
            │   └── js/                    # main.js (1-click fill, UI triggers)
            ├── WEB-INF/
            │   ├── web.xml
            │   └── views/
            │       ├── common/            # header, footer, navbar, alerts
            │       ├── auth/              # login.jsp, register.jsp
            │       ├── student/           # dashboard, jobs, job-detail, profile, skills, etc.
            │       ├── recruiter/         # dashboard, post-job, manage-jobs, applicants, etc.
            │       ├── admin/             # dashboard, users, jobs, skills
            │       └── error/             # 403, 404, 500
            └── index.jsp                  # High-impact SaaS landing page
```

---

## 🗓 12-Week Development Roadmap & Contribution Log

| Week | Goal | Deliverables | Key Contributors |
|:---:|---|---|---|
| **1-2** | Requirements, Architecture & DB | SRS document, MVC layout, MySQL schema DDL, ER model | Riddhi Sharma & Team |
| **3-4** | Project Setup & Authentication | Maven configuration, BCrypt security, Login/Register Servlets, RBAC AuthFilter | Riddhi Sharma & Team |
| **5-6** | Student Profile & Portfolio | Student profile CRUD, Skills taxonomy, Projects, Certifications | Riddhi Sharma & Team |
| **7-8** | Recruiter Job Management | Company profiles, Job creation, Mandatory/Preferred skill tagging, Application submission | Riddhi Sharma & Team |
| **9-10**| Explainable Matching Engine | Pure Java 5-pillar matching formula, Skill gap roadmap, Admin oversight | Riddhi Sharma & Team |
| **11-12**| Testing, UI Polish & Packaging | Unit/functional testing, Edge cases, WAR packaging, Final documentation | Riddhi Sharma & Team |

---

## 🧪 Testing & Quality Assurance

1. **Authentication Testing:** Validated BCrypt password hashing, session fixation prevention, and invalid credential handling.
2. **Authorization Testing:** Verified that students cannot access `/recruiter/*` or `/admin/*` routes (redirects to 403 Forbidden).
3. **Data Integrity Testing:** Verified foreign keys and cascade deletions across students, jobs, skills, and applications.
4. **Matching Formula Boundary Cases:** Tested 0% skill match, CGPA below cutoff, mismatched engineering branch, and multi-skill combinations against manual calculations.

---

## 📦 Deployment & Production Packaging

To build the production-ready WAR (Web Application Archive) file:
```bash
mvn clean package
```
This generates `target/CampusHireAI.war`. Deploy this WAR to any Apache Tomcat 9+ webapps directory:
```bash
cp target/CampusHireAI.war /opt/tomcat/webapps/
```

---

<p align="center">
  <strong>CampusHire AI</strong> &bull; Intelligent Placement & Skill Matching Platform<br>
  Academic Major Project developed by <strong>Riddhi Sharma</strong> & Team.
</p>
