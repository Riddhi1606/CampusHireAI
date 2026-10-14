# CampusHire AI --- Intelligent Placement & Skill Matching Platform
> **Live Demo:** `ADD_VERIFIED_PUBLIC_DEPLOYMENT_URL`\
> **GitHub Repository:** https://github.com/Riddhi1606/CampusHireAI 

> **Status note:** This README is prepared for the final deployment
> stage. Change the status and add a public URL only after the
> application is deployed and verified.

------------------------------------------------------------------------

## **Abstract**

CampusHire AI: Intelligent Placement & Skill Matching Platform is a web-based application designed to simplify and improve the campus placement process by connecting students, recruiters, and administrators through a centralized platform. The system enables students to create profiles, showcase their skills, projects, and certifications, explore job opportunities, and track their applications. Recruiters can manage company details, post job openings, review applications, and identify suitable candidates, while administrators can manage platform activities.

The platform incorporates a rule-based weighted matching mechanism to evaluate the suitability of students for job opportunities. The matching score considers technical skills (50%), CGPA (20%), branch eligibility (15%), certifications (10%), and projects (5%). Based on these criteria, the system calculates match scores and helps students discover relevant opportunities while assisting recruiters in identifying suitable candidates.

The application is developed using Java, JSP, Servlets, JDBC, MySQL, CSS, JavaScript, and Bootstrap, with Apache Tomcat as the application server. The system follows a structured web application architecture to support database connectivity, user authentication, job management, and application tracking. CampusHire AI aims to make campus recruitment more organized, transparent, and efficient by reducing manual effort and improving student-job matching. Deployment and final verification are part of the project’s completion process.

## 📌 Table of Contents

-   [Overview](#overview)
-   [Problem Statement and
    Objectives](#problem-statement-and-objectives)
-   [Features](#features)
-   [Technology Stack](#technology-stack)
-   [Architecture](#architecture)
-   [Project Directory Layout](#project-directory-layout)
-   [Skill-Matching Method](#skill-matching-method)
-   [Database Design](#database-design)
-   [Local Setup](#local-setup)
-   [Production Deployment Checklist](#production-deployment-checklist)
-   [12-Week Development Roadmap](#12-week-development-roadmap)
-   [Weekly Contribution Log](#weekly-contribution-log)
-   [Testing and Security](#testing-and-security)
-   [Current Status](#current-status)
-   [Team](#team)

## 📖 Overview

**CampusHire AI** is a web application designed to bring student
profiles, job opportunities, applications, and skill matching into one
place. Students can maintain a profile and explore relevant
opportunities. Recruiters can publish jobs and review applications.
Administrative features can be provided to authorized administrators
where implemented.

The planned stack uses a Java backend, JSP-based presentation, JDBC
database access, and MySQL persistence. The matching module uses an
explainable weighted scoring approach. A match score is a compatibility
indicator---not a guarantee of selection or a prediction of hiring
probability.

## 🎯 Problem Statement and Objectives

Students may need to search across multiple sources for placement
opportunities and may not know which skills are missing for a role.
Recruiters need a structured way to review candidate profiles against
job requirements. CampusHire AI aims to centralize job discovery and
applications while making skill alignment more transparent.

Objectives: - Centralize student profiles and job listings. - Store
education, skills, projects, and certifications in a structured
database. - Support job posting and application workflows. - Provide
explainable compatibility scoring based on defined criteria. - Highlight
missing skills where the skill-gap module is implemented. - Enforce
role-based access to protected functions. - Test and deploy the
application with clear documentation.

## Features

The following is the intended feature set. Mark a feature as complete
only after it has been implemented and tested.

### Student

-   Registration, login, and student profile.
-   Academic details, skills, projects, and certifications.
-   Browse active job listings.
-   View match scores and explanations, if implemented.
-   Apply for jobs and track application status.

### Recruiter

-   Recruiter login and company profile.
-   Create, edit, and deactivate job listings.
-   Define eligibility requirements and required skills.
-   Review applications and candidate profiles.
-   View candidate match scores, if implemented.

### Administrator

-   Manage or review users, recruiters, jobs, and skills where
    implemented.
-   View platform statistics where implemented.
-   Administrator accounts must be created through a controlled process,
    not public self-registration.

## 👨‍💻 Technology Stack

  Layer                Technology
  -------------------- ------------------------------------------------
  Backend              Java
  Web                  Java Servlets, JSP
  Frontend             HTML5, CSS3, JavaScript, Bootstrap if included
  Database             MySQL
  Database access      JDBC
  Application server   Apache Tomcat 9
  IDE                  Eclipse IDE
  Build                Maven / WAR
  Version control      Git and GitHub

**Backend requirement:** The application backend is Java-based. Tomcat 9
uses `javax.servlet`; Tomcat 10+ uses `jakarta.servlet` and may require
code/dependency changes.

## 🏛 Architecture

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
         |Student, Recruiter)|                 | JSTL, Chart.js)   |
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

Adjust this diagram to match the actual implementation. Show a
connection pool or additional middleware only if it is configured and
used.

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

## 🧮 Skill-Matching Method

The proposed explainable scoring model uses five weighted criteria:

  Criterion                       Proposed Weight
  ----------------------------- -----------------
  Required skill match                        50%
  CGPA / academic eligibility                 20%
  Branch eligibility                          15%
  Relevant certifications                     10%
  Relevant projects                            5%
  **Total**                              **100%**

A general representation is:

`Compatibility Score = Σ (criterion weight × normalized criterion score)`

Each criterion score should be normalized from 0 to 100, and the final
score should be bounded between 0 and 100. The exact calculation must
match the Java implementation. This is a rule-based compatibility score,
not a scientifically validated hiring model.

## 🗄 Database Design

Confirm these table names against the SQL scripts in the repository:

  Table               Purpose
  ------------------- -------------------------------------------------
  `users`             User identity, email, hashed password, and role
  `students`          Student education and profile details
  `companies`         Recruiter/company profile
  `skills`            Shared skill catalogue
  `student_skills`    Skills associated with students
  `projects`          Student project portfolio
  `certifications`    Student certifications
  `jobs`              Job listings and eligibility criteria
  `job_skills`        Skills required for each job
  `applications`      Job applications and statuses
  `recommendations`   Stored matching scores, if used

Document additional tables only if they exist in the final schema. Keep
this section synchronized with `database/schema.sql`.

## ⚙️ Local Setup

### Prerequisites

-   JDK version configured in `pom.xml` (JDK 17 is the planned
    baseline).
-   Eclipse IDE for Enterprise Java and Web Developers.
-   Apache Tomcat 9 for a `javax.servlet`-based project.
-   MySQL Server and MySQL Workbench.
-   Git and Maven support.

### 1. Clone the repository

``` bash
git clone YOUR_GITHUB_REPOSITORY_URL
cd CampusHireAI
```

Replace the placeholder with the real repository URL.

### 2. Create the database

1.  Start MySQL Server and connect through MySQL Workbench.
2.  Open `database/schema.sql` and execute it.
3.  Execute `database/seed_data.sql` only if it exists and contains safe
    dummy data.
4.  Confirm the database and tables were created.

Use the database name specified by your SQL scripts if it differs from
`campushire_ai`.

### 3. Configure database connectivity

Configure the JDBC URL, username, and password using the method
supported by your application. Example properties:

``` properties
db.url=jdbc:mysql://localhost:3306/campushire_ai?serverTimezone=Asia/Kolkata
db.username=YOUR_LOCAL_DB_USERNAME
db.password=YOUR_LOCAL_DB_PASSWORD
```

These property names are examples and must match your actual connection
utility. Never commit real credentials. For production, use environment
variables or the hosting provider's secret configuration.

### 4. Import into Eclipse

1.  Open Eclipse.
2.  Select **File → Import → Maven → Existing Maven Projects**.
3.  Select the project root and finish the import.
4.  Wait for dependencies to resolve.
5.  Verify the JDK and project build path.
6.  Configure Tomcat 9 in the **Servers** view.
7.  Right-click the project and select **Run As → Run on Server**.

The local URL is typically `http://localhost:8080/CampusHireAI/`, but
the context path may differ. A localhost URL is not a public deployment
URL.

## 📦 Production Deployment Checklist

Deployment is complete only after the application is deployed to a
public hosting environment and verified through its public URL.

### Before deployment

-   [ ] WAR build succeeds.
-   [ ] Hosting supports the required Java and Servlet/Tomcat versions.
-   [ ] Production MySQL database is reachable by the application.
-   [ ] Production credentials are stored outside source control.
-   [ ] Production schema is applied.
-   [ ] Production configuration does not use local-only file paths or
    `localhost` database settings.
-   [ ] Public registration cannot create administrator accounts.
-   [ ] Errors do not expose SQL statements, stack traces, or secrets.

### Deploy and verify

-   [ ] Deploy the WAR using the hosting provider's supported process.
-   [ ] Configure HTTPS and secure session-cookie settings where
    supported.
-   [ ] Open the public URL in a private/incognito browser window.
-   [ ] Test registration, login, logout, and role restrictions.
-   [ ] Test implemented student and recruiter workflows.
-   [ ] Verify production database reads and writes.
-   [ ] Test matching scores against known examples, if the matching
    module is enabled.
-   [ ] Check application logs and resolve startup/runtime errors.
-   [ ] Capture demo screenshots without exposing private information.

### Final deployment details

Fill these in only after successful deployment:

-   **Public application URL:** `ADD_VERIFIED_HTTPS_URL`
-   **Hosting platform:** `ADD_HOSTING_PROVIDER`
-   **Deployment date:** `YYYY-MM-DD`
-   **Verified commit:** `ADD_GIT_COMMIT_HASH`

Do not invent a live URL. Until deployment is complete, keep the status
as **Deployment in Progress**.

## 🗓 12-Week Development Roadmap

This is the high-level plan. Weekly portal submissions should describe
the work actually completed, not just the planned work.

  ----------------------- ----------------------- ----------------------
  Week                     Main focus              Expected deliverables
  ----------------------- ----------------------- -----------------------
  **1**                   Requirements and        Problem statement,
                          planning                objectives, scope,
                                                  roles, task allocation

  **2**                   Architecture and        Use cases, MVC design,
                          database design         ER diagram, initial
                                                  schema

  **3**                   Development environment Eclipse/Maven project,
                                                  Tomcat setup, JDBC
                                                  connection test

  **4**                   Authentication          Registration/login,
                                                  password hashing,
                                                  validation, sessions

  **5**                   Student profile         Profile create/update
                                                  and academic details

  **6**                   Student portfolio       Skills, projects,
                                                  certifications and
                                                  persistence

  **7**                   Recruiter/company       Company profile and job
                                                  CRUD

  **8**                   Job discovery and       Job listing/search,
                          applications            application workflow,
                                                  status tracking

  **9**                   Matching engine         Java scoring logic and
                                                  test cases

  **10**                  Integration and UI      Integration fixes,
                                                  responsive UI, admin
                                                  functions if
                                                  implemented

  **11**                  Testing and deployment  Functional/security
                          preparation             checks, bug fixes, WAR
                                                  build, hosting
                                                  configuration

  **12**                  Deployment and final    Public URL
                          submission              verification, final
                                                  README,
                                                  screenshots,
                                                  report and presentation
  -----------------------------------------------------------------------

## 🗓️ Weekly Contribution Log

Replace placeholders with the real names of all five team members. This
table is a role-planning guide, not proof that tasks are complete.

  ------------------------------------------------------------------------------------------------------------------------
  Week        Riddhi Sharma --- Java Sai--- Frontend/UI       Saloni Kumari         Shubham Purohit     Toyeshh 
              backend / coordination                          MySQL/JDBC            Matching logic   QA/deployment/docs
  ----------- ---------------------- ------------------------ --------------------- ---------------- ---------------------
  **1**       Scope and requirements User journeys            Identify data         Matching         Reporting/evidence
                                                              entities              requirements     format

  **2**       Review architecture    Wireframes               ER diagram/schema     Scoring criteria Acceptance criteria

  **3**       Java project setup     Base page layout         Schema and JDBC test  Sample matching  Git workflow and
                                                                                    cases            setup notes

  **4**       Auth                   Login/register UI        User                  Define matching  Test auth cases
              controllers/services                            queries/constraints   inputs           

  **5**       Profile workflow       Profile UI               Student/profile       Skill            Profile validation
                                                              queries               normalization    
                                                                                    rules            

  **6**       Portfolio handling     Projects/certification   Related DAO methods   Portfolio        Persistence tests
                                     UI                                             scoring inputs   

  **7**       Job workflow/access    Recruiter screens        Company/job queries   Eligibility and  Recruiter permission
                                                                                    skill rules      tests

  **8**       Application workflow   Job list/details/apply   Application queries   Prepare match    Duplicate/status
                                     UI                                             test data        tests

  **9**       Integrate matching     Match-score display      Score persistence if  Implement/test   Manual score
              service                                         needed                scoring          comparison

  **10**      Integration and bug    Responsive polish        Data integrity checks Boundary-case    Regression tests
              fixes                                                                 tests            

  **11**      Backend fixes/WAR      UI fixes                 Production DB checks  Retest matching  Deployment smoke-test
              build                                                                                  plan

  **12**      Final integration/demo Final screenshots        Schema documentation  Scoring          Deployment
                                                                                    explanation      verification/report
  ------------------------------------------------------------------------------------------------------------------------

## 🧪 Testing and Security

Mark a testing item complete only after testing the current build.

-   [ ] Valid registration succeeds and invalid inputs are handled.
-   [ ] Login rejects incorrect credentials.
-   [ ] Logout invalidates the session.
-   [ ] Student, recruiter, and admin routes enforce authorization.
-   [ ] Database operations use parameterized queries.
-   [ ] Profile, job, and application changes persist correctly.
-   [ ] Duplicate applications are handled according to project rules.
-   [ ] Matching scores are checked against manual examples, if
    implemented.
-   [ ] Empty states and database errors are handled safely.
-   [ ] Core workflows pass a smoke test on the deployed URL.

Security checklist: - Hash passwords using BCrypt or another suitable
password-hashing function; never store plaintext passwords. - Validate
input on the server and use `PreparedStatement`. - Enforce authorization
for every protected operation. - Never allow public registration as
`ADMIN`. - Regenerate the session ID after login and invalidate the
session on logout. - Escape user-generated content before rendering
HTML. - Add CSRF protection to state-changing forms. - Keep passwords,
tokens, and private configuration out of Git. - Use HTTPS and secure
session-cookie settings in production. - Use dummy demo data and do not
publish real student records. - Do not publish reusable admin passwords
in this README.

## ⏱️ Current Status

Update this checklist according to the real build:

-   [ ] Database schema verified
-   [ ] JDBC connection verified
-   [ ] Authentication and authorization tested
-   [ ] Student module tested
-   [ ] Recruiter/job module tested
-   [ ] Application workflow tested
-   [ ] Matching module tested, if included
-   [ ] Final WAR build successful
-   [ ] Production database configured
-   [ ] Public deployment accessible
-   [ ] Core workflows verified on public deployment
-   [ ] Final report, presentation, and demo prepared

**Current stage:** Deployment in progress.\
**Known issues:** Add the actual outstanding issues here.

## 🔮 Known Limitations and Future Enhancements

Document any incomplete modules or limitations of the current release.
Potential future enhancements include resume parsing, saved jobs, job
alerts, interview scheduling, notifications, skill-gap learning
recommendations, recruiter analytics, accessibility improvements, and
additional automated tests.

## 👥 Team

  Member                  Responsibility
  ----------------------- -------------------------------------------
  **Riddhi Sharma**       Java backend and project coordination
  **Sai Prasad**          Frontend and UI
  **Saloni Kumari**       MySQL and JDBC
  **Shubham Purohit**     Matching logic and scoring tests
  **Toyeshh Somvansi**    QA, deployment support, and documentation


## 📝 Academic Project Note

CampusHire AI is an academic team project intended to demonstrate Java
web development, JSP/Servlets, JDBC, relational database design,
role-based workflows, testing, and deployment. Matching scores should be
presented as compatibility guidance, not a guarantee of hiring outcomes.

------------------------------------------------------------------------

CampusHire AI Intelligent Placement & Skill Matching Platform` 
Developed by Team Code Avengers
