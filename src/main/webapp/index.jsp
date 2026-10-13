<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="CampusHire AI — Intelligent Placement & Skill Matching Platform" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- Hero Section -->
<section class="hero-section text-center position-relative">
    <div class="container py-lg-4">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 rounded-pill fw-semibold mb-3">
                    <i class="fa-solid fa-brain me-1"></i> Transparent AI Placement Matching Architecture
                </span>
                <h1 class="display-4 fw-extrabold text-dark tracking-tight mb-3">
                    Connecting Ambitious Students with <span class="text-gradient">Dream Careers</span> Through Explainable Match Scoring
                </h1>
                <p class="lead text-secondary mb-4 mx-auto" style="max-width: 720px;">
                    CampusHire AI centralizes campus placement discovery, student portfolios,
                    and recruitment workflows powered by a multi-factor rule-based skill compatibility engine.
                </p>

                <div class="d-flex flex-wrap justify-content-center gap-3 mb-5">
                    <c:choose>
                        <c:when test="${sessionScope.currentUser != null}">
                            <a href="${pageContext.request.contextPath}/${sessionScope.currentUser.role.name().toLowerCase()}/dashboard" class="btn btn-primary-custom px-4 py-3 fs-6">
                                <i class="fa-solid fa-arrow-right-to-bracket me-2"></i> Open Your Dashboard
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary-custom px-4 py-3 fs-6">
                                <i class="fa-solid fa-user-plus me-2"></i> Join as Student or Recruiter
                            </a>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-custom px-4 py-3 fs-6">
                                <i class="fa-solid fa-right-to-bracket me-2"></i> Existing User Login
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Evaluator Demo Quick Pill -->
                <div class="p-3 bg-white border rounded-4 shadow-sm mx-auto d-inline-block text-start" style="max-width: 650px;">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="fa-solid fa-flask-vial text-primary"></i>
                        <span class="fw-bold small text-dark">Teacher & Evaluator Demo Credentials:</span>
                    </div>
                    <div class="d-flex flex-wrap gap-2 small">
                        <span class="badge bg-light text-dark border p-2">Student: <code>riddhi.sharma@college.edu</code> / <code>student123</code></span>
                        <span class="badge bg-light text-dark border p-2">Recruiter: <code>recruiter@google.com</code> / <code>recruiter123</code></span>
                        <span class="badge bg-light text-dark border p-2">Admin: <code>admin@campushire.ai</code> / <code>admin123</code></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 5-Pillar Matching Formula Section -->
<section id="methodology" class="py-5 bg-white border-bottom">
    <div class="container py-lg-4">
        <div class="text-center mb-5">
            <span class="badge bg-secondary-subtle text-secondary px-3 py-1 rounded-pill fw-semibold">Algorithm & Methodology</span>
            <h2 class="fw-bold mt-2">Explainable 5-Pillar Skill-Matching Model</h2>
            <p class="text-secondary mx-auto" style="max-width: 650px;">
                Unlike opaque black-box classifiers, CampusHire AI evaluates candidates using a fully transparent,
                mathematically normalized multi-criteria weighting formula:
            </p>
        </div>

        <div class="row g-4">
            <div class="col-lg col-md-4">
                <div class="card-custom h-100 p-4 border-top border-4 border-primary">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="bg-primary-subtle text-primary p-3 rounded-3">
                            <i class="fa-solid fa-code fs-4"></i>
                        </div>
                        <span class="badge bg-primary text-white fs-6 fw-bold">50%</span>
                    </div>
                    <h5 class="fw-bold">Required Skills</h5>
                    <p class="small text-secondary mb-0">
                        Exact overlap and proficiency mapping between student technical skills and mandatory/preferred job skills.
                    </p>
                </div>
            </div>

            <div class="col-lg col-md-4">
                <div class="card-custom h-100 p-4 border-top border-4 border-info">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="bg-info-subtle text-info p-3 rounded-3">
                            <i class="fa-solid fa-graduation-cap fs-4"></i>
                        </div>
                        <span class="badge bg-info text-white fs-6 fw-bold">20%</span>
                    </div>
                    <h5 class="fw-bold">CGPA / Eligibility</h5>
                    <p class="small text-secondary mb-0">
                        Academic score cutoff validation, GPA scaling, and academic excellence bonus calculation.
                    </p>
                </div>
            </div>

            <div class="col-lg col-md-4">
                <div class="card-custom h-100 p-4 border-top border-4 border-warning">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="bg-warning-subtle text-warning p-3 rounded-3">
                            <i class="fa-solid fa-sitemap fs-4"></i>
                        </div>
                        <span class="badge bg-warning text-white fs-6 fw-bold">15%</span>
                    </div>
                    <h5 class="fw-bold">Branch Alignment</h5>
                    <p class="small text-secondary mb-0">
                        Department eligibility matching against listed target disciplines (CSE, IT, ECE, or All-branch).
                    </p>
                </div>
            </div>

            <div class="col-lg col-md-6">
                <div class="card-custom h-100 p-4 border-top border-4 border-success">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="bg-success-subtle text-success p-3 rounded-3">
                            <i class="fa-solid fa-certificate fs-4"></i>
                        </div>
                        <span class="badge bg-success text-white fs-6 fw-bold">10%</span>
                    </div>
                    <h5 class="fw-bold">Certifications</h5>
                    <p class="small text-secondary mb-0">
                        Industry-recognized certifications (AWS, Oracle, Google Cloud) matching job tech stacks.
                    </p>
                </div>
            </div>

            <div class="col-lg col-md-6">
                <div class="card-custom h-100 p-4 border-top border-4 border-danger">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="bg-danger-subtle text-danger p-3 rounded-3">
                            <i class="fa-solid fa-folder-open fs-4"></i>
                        </div>
                        <span class="badge bg-danger text-white fs-6 fw-bold">5%</span>
                    </div>
                    <h5 class="fw-bold">Projects Portfolio</h5>
                    <p class="small text-secondary mb-0">
                        Practical project implementations and GitHub repository tech stack relevance.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Role Breakdown Features -->
<section class="py-5 bg-light">
    <div class="container py-lg-4">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <span class="badge bg-primary-subtle text-primary px-3 py-1 rounded-pill fw-semibold">Role-Based Ecosystem</span>
                <h2 class="fw-bold mt-2">Tailored Experiences for Each Stakeholder</h2>
                <div class="mt-4 d-flex flex-column gap-3">
                    <div class="d-flex gap-3 align-items-start">
                        <div class="bg-primary text-white p-2 rounded-circle mt-1">
                            <i class="fa-solid fa-user-graduate"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1">Student Portal</h6>
                            <p class="text-secondary small mb-0">
                                Maintain academic records, link certifications, get live compatibility scores on every active opening, and access actionable skill-gap roadmap recommendations.
                            </p>
                        </div>
                    </div>

                    <div class="d-flex gap-3 align-items-start">
                        <div class="bg-info text-white p-2 rounded-circle mt-1">
                            <i class="fa-solid fa-building-user"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1">Recruiter Management Console</h6>
                            <p class="text-secondary small mb-0">
                                Publish criteria-rich job descriptions with mandatory/preferred skill flags, review applicants ranked by compatibility score, and coordinate interviews seamlessly.
                            </p>
                        </div>
                    </div>

                    <div class="d-flex gap-3 align-items-start">
                        <div class="bg-dark text-white p-2 rounded-circle mt-1">
                            <i class="fa-solid fa-shield-halved"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1">Placement Cell & Admin Governance</h6>
                            <p class="text-secondary small mb-0">
                                Oversee placement statistics, moderate job openings, manage master skill taxonomy, and monitor branch-wise placement conversion analytics.
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="p-4 bg-white rounded-4 border shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <span class="fw-bold text-dark"><i class="fa-solid fa-sliders text-primary me-2"></i>Live Match Simulation</span>
                        <span class="match-score-badge match-high">95.5% High Match</span>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between small fw-bold mb-1">
                            <span>Required Skills Match (50%)</span>
                            <span class="text-primary">48.0 / 50</span>
                        </div>
                        <div class="score-progress-bar">
                            <div class="score-progress-fill bg-primary" style="width: 96%;"></div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between small fw-bold mb-1">
                            <span>CGPA Eligibility (20%)</span>
                            <span class="text-info">20.0 / 20</span>
                        </div>
                        <div class="score-progress-bar">
                            <div class="score-progress-fill bg-info" style="width: 100%;"></div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between small fw-bold mb-1">
                            <span>Branch Match (15%)</span>
                            <span class="text-warning">15.0 / 15</span>
                        </div>
                        <div class="score-progress-bar">
                            <div class="score-progress-fill bg-warning" style="width: 100%;"></div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between small fw-bold mb-1">
                            <span>Verified Certifications (10%)</span>
                            <span class="text-success">8.0 / 10</span>
                        </div>
                        <div class="score-progress-bar">
                            <div class="score-progress-fill bg-success" style="width: 80%;"></div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between small fw-bold mb-1">
                            <span>Projects Portfolio (5%)</span>
                            <span class="text-danger">4.5 / 5</span>
                        </div>
                        <div class="score-progress-bar">
                            <div class="score-progress-fill bg-danger" style="width: 90%;"></div>
                        </div>
                    </div>

                    <div class="p-3 bg-light rounded-3 small">
                        <strong class="text-success"><i class="fa-solid fa-circle-check me-1"></i> Recommendation:</strong>
                        <span>Strong technical alignment for SDE-1 backend roles. Ready for technical screening!</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
