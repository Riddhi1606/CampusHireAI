<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Student Dashboard — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-lg-4 py-4">
    <!-- Welcome Profile Banner -->
    <div class="card-custom p-4 mb-4 bg-gradient-primary text-white border-0 shadow">
        <div class="row align-items-center">
            <div class="col-md-8">
                <span class="badge bg-white bg-opacity-25 text-white mb-2 px-3 py-1 rounded-pill">
                    <i class="fa-solid fa-graduation-cap me-1"></i> Candidate Profile: ${student.branch}
                </span>
                <h2 class="fw-bold mb-1">Hello, ${student.fullName}! 👋</h2>
                <p class="mb-3 opacity-90">
                    ${student.collegeName} &bull; CGPA: <strong>${student.cgpa}</strong> &bull; Class of ${student.graduationYear}
                </p>

                <!-- Profile Completion Indicator -->
                <div style="max-width: 420px;">
                    <div class="d-flex justify-content-between small fw-semibold mb-1">
                        <span>Profile Readiness Score</span>
                        <span>${student.profileCompletionPercentage}%</span>
                    </div>
                    <div class="progress" style="height: 8px; background-color: rgba(255,255,255,0.3);">
                        <div class="progress-bar bg-white" style="width: ${student.profileCompletionPercentage}%;"></div>
                    </div>
                </div>
            </div>

            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <a href="${pageContext.request.contextPath}/student/profile" class="btn btn-light fw-bold px-3 py-2 shadow-sm rounded-pill">
                    <i class="fa-regular fa-pen-to-square me-1"></i> Update Profile
                </a>
                <a href="${pageContext.request.contextPath}/student/skills" class="btn btn-outline-light fw-bold px-3 py-2 ms-2 rounded-pill">
                    <i class="fa-solid fa-code me-1"></i> Add Skills
                </a>
            </div>
        </div>
    </div>

    <!-- Quick Stat Cards -->
    <div class="row g-3 mb-4">
        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-primary-subtle text-primary">
                    <i class="fa-solid fa-paper-plane"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Applications Sent</div>
                    <h3 class="fw-bold mb-0">${appliedCount}</h3>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-info-subtle text-info">
                    <i class="fa-solid fa-user-check"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Shortlists & Interviews</div>
                    <h3 class="fw-bold mb-0">${shortlistedCount}</h3>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-success-subtle text-success">
                    <i class="fa-solid fa-award"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Offers Extended</div>
                    <h3 class="fw-bold mb-0">${offeredCount}</h3>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-warning-subtle text-warning">
                    <i class="fa-solid fa-bolt"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Skills Registered</div>
                    <h3 class="fw-bold mb-0">${student.skills.size()}</h3>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Recommended Jobs Based on Skill Compatibility -->
        <div class="col-lg-8">
            <div class="card-custom p-4 mb-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h5 class="fw-bold mb-0"><i class="fa-solid fa-wand-magic-sparkles text-primary me-2"></i>Top Matched Openings</h5>
                        <div class="small text-secondary">Opportunities dynamically ranked by your profile compatibility</div>
                    </div>
                    <a href="${pageContext.request.contextPath}/student/jobs" class="btn btn-sm btn-outline-custom">
                        View All Openings <i class="fa-solid fa-arrow-right ms-1"></i>
                    </a>
                </div>

                <div class="d-flex flex-column gap-3">
                    <c:forEach var="job" items="${recommendedJobs}">
                        <div class="p-3 border rounded-3 bg-white card-hover-lift">
                            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
                                <div>
                                    <div class="d-flex align-items-center gap-2 mb-1">
                                        <span class="badge bg-light text-dark border">${job.companyName}</span>
                                        <span class="badge bg-primary-subtle text-primary">${job.jobType}</span>
                                        <c:choose>
                                            <c:when test="${job.matchResult.overallScore >= 85}">
                                                <span class="match-score-badge match-high"><i class="fa-solid fa-bolt"></i> <fmt:formatNumber value="${job.matchResult.overallScore}" maxFractionDigits="1"/>% Match</span>
                                            </c:when>
                                            <c:when test="${job.matchResult.overallScore >= 70}">
                                                <span class="match-score-badge match-medium"><i class="fa-solid fa-check"></i> <fmt:formatNumber value="${job.matchResult.overallScore}" maxFractionDigits="1"/>% Match</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="match-score-badge match-moderate"><fmt:formatNumber value="${job.matchResult.overallScore}" maxFractionDigits="1"/>% Match</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <h6 class="fw-bold mb-1">${job.title}</h6>
                                    <div class="small text-secondary mb-2">
                                        <i class="fa-solid fa-location-dot me-1"></i> ${job.location} &bull;
                                        <i class="fa-solid fa-money-bill-wave me-1"></i> ${job.packageLpa} &bull;
                                        <i class="fa-solid fa-graduation-cap me-1"></i> Min CGPA: ${job.minCgpa}
                                    </div>

                                    <!-- Matched Skills Pills -->
                                    <div class="d-flex flex-wrap align-items-center">
                                        <span class="small text-muted me-1">Matched:</span>
                                        <c:forEach var="mskill" items="${job.matchResult.matchedSkills}">
                                            <span class="skill-pill skill-pill-matched"><i class="fa-solid fa-check text-success"></i> ${mskill}</span>
                                        </c:forEach>
                                        <c:if test="${not empty job.matchResult.missingSkills}">
                                            <span class="small text-muted ms-2 me-1">Missing:</span>
                                            <c:forEach var="missSkill" items="${job.matchResult.missingSkills}">
                                                <span class="skill-pill skill-pill-missing"><i class="fa-solid fa-xmark text-danger"></i> ${missSkill}</span>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="text-md-end flex-shrink-0">
                                    <c:choose>
                                        <c:when test="${job.hasApplied}">
                                            <span class="badge bg-secondary-subtle text-secondary px-3 py-2 rounded-pill"><i class="fa-solid fa-check me-1"></i> Applied</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/student/job-detail?id=${job.id}" class="btn btn-sm btn-primary-custom">
                                                Review & Apply
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty recommendedJobs}">
                        <div class="text-center py-4 text-muted">
                            <i class="fa-solid fa-inbox fs-3 mb-2 d-block"></i>
                            No active job postings found. Check back soon!
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Right Side: Recent Applications and Quick Shortcuts -->
        <div class="col-lg-4">
            <div class="card-custom p-4 mb-4">
                <h5 class="fw-bold mb-3"><i class="fa-solid fa-clock-rotate-left text-primary me-2"></i>Recent Applications</h5>

                <div class="d-flex flex-column gap-3">
                    <c:forEach var="app" items="${recentApplications}">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="d-flex justify-content-between align-items-start mb-1">
                                <span class="fw-bold small text-dark">${app.jobTitle}</span>
                                <span class="badge bg-${app.statusBadgeClass} text-capitalize">${app.status.name().replace('_', ' ').toLowerCase()}</span>
                            </div>
                            <div class="small text-muted mb-2">${app.companyName}</div>
                            <div class="d-flex justify-content-between align-items-center small text-secondary">
                                <span>Match: <strong><fmt:formatNumber value="${app.matchScore}" maxFractionDigits="1"/>%</strong></span>
                                <a href="${pageContext.request.contextPath}/student/applications" class="text-primary text-decoration-none">Track <i class="fa-solid fa-chevron-right ms-1"></i></a>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty recentApplications}">
                        <div class="text-center py-4 text-muted small">
                            You have not submitted any applications yet.
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Profile Growth Shortcuts -->
            <div class="card-custom p-4">
                <h5 class="fw-bold mb-3"><i class="fa-solid fa-compass text-primary me-2"></i>Upskilling & Tools</h5>
                <ul class="list-unstyled d-flex flex-column gap-2 mb-0">
                    <li>
                        <a href="${pageContext.request.contextPath}/student/skill-gap" class="d-flex align-items-center justify-content-between p-2 rounded text-decoration-none text-dark hover-bg">
                            <span><i class="fa-solid fa-route text-primary me-2"></i> Skill Gap Roadmap</span>
                            <i class="fa-solid fa-chevron-right text-muted small"></i>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/student/projects" class="d-flex align-items-center justify-content-between p-2 rounded text-decoration-none text-dark hover-bg">
                            <span><i class="fa-solid fa-laptop-code text-info me-2"></i> Projects Portfolio (${student.projects.size()})</span>
                            <i class="fa-solid fa-chevron-right text-muted small"></i>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/student/certifications" class="d-flex align-items-center justify-content-between p-2 rounded text-decoration-none text-dark hover-bg">
                            <span><i class="fa-solid fa-certificate text-success me-2"></i> Certifications (${student.certifications.size()})</span>
                            <i class="fa-solid fa-chevron-right text-muted small"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
