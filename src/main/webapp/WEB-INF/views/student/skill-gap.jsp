<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Market Skill Gap Roadmap — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-lg-4 py-4">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-route text-primary me-2"></i>Market Skill Gap Roadmap</h3>
            <p class="text-secondary small mb-0">
                Identify high-demand skills sought by recruiters to systematically upskill and elevate your match percentages.
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/student/skills" class="btn btn-primary-custom">
            <i class="fa-solid fa-plus me-1"></i> Update Your Skills
        </a>
    </div>

    <!-- Comparative Breakdown Cards -->
    <div class="row g-4 mb-4">
        <!-- Acquired Skills in Demand -->
        <div class="col-lg-6">
            <div class="card-custom p-4 h-100 bg-white border border-success border-opacity-25">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-success mb-0"><i class="fa-solid fa-circle-check me-2"></i>Your Acquired In-Demand Skills</h5>
                    <span class="badge bg-success-subtle text-success fs-7">${acquiredSkills.size()} Skills Matched</span>
                </div>
                <p class="small text-secondary mb-3">
                    These skills currently align with active company requirements in our placement database:
                </p>

                <div class="d-flex flex-column gap-2">
                    <c:forEach var="entry" items="${acquiredSkills}">
                        <div class="p-3 bg-light rounded-3 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold text-dark">${entry.key}</span>
                                <span class="badge bg-success-subtle text-success ms-2 small">In Demand</span>
                            </div>
                            <span class="small text-muted">${entry.value} active job postings</span>
                        </div>
                    </c:forEach>

                    <c:if test="${empty acquiredSkills}">
                        <div class="text-center py-4 text-muted small">
                            No active industry skills registered yet. Add skills to your profile to see your alignment!
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Missing High-Value Skills -->
        <div class="col-lg-6">
            <div class="card-custom p-4 h-100 bg-white border border-danger border-opacity-25">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-danger mb-0"><i class="fa-solid fa-circle-exclamation me-2"></i>High-Value Skill Gaps</h5>
                    <span class="badge bg-danger-subtle text-danger fs-7">${missingSkills.size()} Gaps Identified</span>
                </div>
                <p class="small text-secondary mb-3">
                    Acquiring these key competencies can significantly boost your eligibility across campus postings:
                </p>

                <div class="d-flex flex-column gap-2">
                    <c:forEach var="entry" items="${missingSkills}">
                        <div class="p-3 bg-light rounded-3 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold text-dark">${entry.key}</span>
                                <span class="badge bg-danger-subtle text-danger ms-2 small">+ Opportunity</span>
                            </div>
                            <span class="small text-muted">Required in ${entry.value} jobs</span>
                        </div>
                    </c:forEach>

                    <c:if test="${empty missingSkills}">
                        <div class="text-center py-4 text-success small">
                            <i class="fa-solid fa-trophy fs-3 mb-2 d-block"></i>
                            Outstanding! You possess all primary in-demand skills in the current placement cycle.
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Structured 4-Step Action Plan -->
    <div class="card-custom p-4 bg-white border">
        <h5 class="fw-bold mb-3"><i class="fa-solid fa-graduation-cap text-primary me-2"></i>Recommended Upskilling Milestone Strategy</h5>
        <div class="row g-3">
            <div class="col-md-3">
                <div class="p-3 bg-light rounded-3 border h-100">
                    <span class="badge bg-primary text-white mb-2">Phase 1</span>
                    <h6 class="fw-bold">Foundation & Core Java</h6>
                    <p class="small text-secondary mb-0">Deepen OOP principles, multi-threading, JVM internals, and LeetCode algorithmic problem solving.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="p-3 bg-light rounded-3 border h-100">
                    <span class="badge bg-info text-white mb-2">Phase 2</span>
                    <h6 class="fw-bold">Web Architectures & APIs</h6>
                    <p class="small text-secondary mb-0">Build RESTful services, understand Spring Boot, database indexing, and secure session management.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="p-3 bg-light rounded-3 border h-100">
                    <span class="badge bg-warning text-dark mb-2">Phase 3</span>
                    <h6 class="fw-bold">Cloud & Containerization</h6>
                    <p class="small text-secondary mb-0">Dockerize applications, learn container lifecycle, and complete foundational cloud certifications (AWS / Azure).</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="p-3 bg-light rounded-3 border h-100">
                    <span class="badge bg-success text-white mb-2">Phase 4</span>
                    <h6 class="fw-bold">Portfolio & Live Demos</h6>
                    <p class="small text-secondary mb-0">Deploy real projects on GitHub and cloud hosting with explainable technical documentation.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
