<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Explore Jobs & Live Compatibility — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-lg-4 py-4">
    <!-- Header with Explanation Badge -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-briefcase text-primary me-2"></i>Campus Placement Openings</h3>
            <p class="text-secondary small mb-0">
                Jobs are ordered in real-time by your personalized <strong>5-Pillar Compatibility Score</strong>.
            </p>
        </div>
        <div class="d-flex gap-2">
            <span class="match-score-badge match-high"><i class="fa-solid fa-bolt"></i> &ge;85% High Match</span>
            <span class="match-score-badge match-medium"><i class="fa-solid fa-check"></i> 70-84% Good Match</span>
            <span class="match-score-badge match-moderate">50-69% Moderate</span>
        </div>
    </div>

    <!-- Filter Bar Card -->
    <div class="card-custom p-3 mb-4 bg-white">
        <form action="${pageContext.request.contextPath}/student/jobs" method="get" class="row g-2 align-items-center">
            <div class="col-lg-4 col-md-6">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                    <input type="text" class="form-control border-start-0" name="keyword" value="${keyword}" placeholder="Role title, keywords, or company...">
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-location-dot text-muted"></i></span>
                    <input type="text" class="form-control border-start-0" name="location" value="${location}" placeholder="Location (e.g. Bengaluru / All)">
                </div>
            </div>

            <div class="col-lg-2 col-md-4">
                <select class="form-select" name="jobType">
                    <option value="All">All Job Types</option>
                    <option value="FULL_TIME" ${jobType == 'FULL_TIME' ? 'selected' : ''}>Full-Time</option>
                    <option value="INTERNSHIP" ${jobType == 'INTERNSHIP' ? 'selected' : ''}>Internship</option>
                </select>
            </div>

            <div class="col-lg-2 col-md-4">
                <input type="number" step="0.1" class="form-control" name="minCgpa" value="${minCgpa}" placeholder="Max CGPA Cutoff">
            </div>

            <div class="col-lg-1 col-md-4 d-grid">
                <button type="submit" class="btn btn-primary-custom">Filter</button>
            </div>
        </form>
    </div>

    <!-- Jobs Grid -->
    <div class="row g-4">
        <c:forEach var="job" items="${jobs}">
            <div class="col-xl-6">
                <div class="card-custom p-4 h-100 bg-white border d-flex flex-column justify-content-between card-hover-lift">
                    <div>
                        <!-- Company & Header -->
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div>
                                <div class="d-flex align-items-center gap-2 mb-1">
                                    <span class="badge bg-light text-dark border fw-bold">${job.companyName}</span>
                                    <span class="badge bg-secondary-subtle text-secondary">${job.department}</span>
                                    <span class="badge bg-primary-subtle text-primary">${job.jobType}</span>
                                </div>
                                <h5 class="fw-bold text-dark mb-1">${job.title}</h5>
                                <div class="small text-secondary">
                                    <i class="fa-solid fa-location-dot me-1"></i> ${job.location} &bull;
                                    <i class="fa-solid fa-money-bill-wave me-1"></i> ${job.packageLpa}
                                </div>
                            </div>

                            <!-- Live Compatibility Score Badge -->
                            <div class="text-end flex-shrink-0">
                                <c:choose>
                                    <c:when test="${job.matchResult.overallScore >= 85}">
                                        <div class="match-score-badge match-high fs-6">
                                            <i class="fa-solid fa-bolt"></i> <fmt:formatNumber value="${job.matchResult.overallScore}" maxFractionDigits="1"/>%
                                        </div>
                                        <div class="small text-success fw-bold mt-1">Excellent Fit</div>
                                    </c:when>
                                    <c:when test="${job.matchResult.overallScore >= 70}">
                                        <div class="match-score-badge match-medium fs-6">
                                            <i class="fa-solid fa-check"></i> <fmt:formatNumber value="${job.matchResult.overallScore}" maxFractionDigits="1"/>%
                                        </div>
                                        <div class="small text-primary fw-bold mt-1">Strong Fit</div>
                                    </c:when>
                                    <c:when test="${job.matchResult.overallScore >= 50}">
                                        <div class="match-score-badge match-moderate fs-6">
                                            <fmt:formatNumber value="${job.matchResult.overallScore}" maxFractionDigits="1"/>%
                                        </div>
                                        <div class="small text-warning fw-bold mt-1">Moderate Fit</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="match-score-badge match-low fs-6">
                                            <fmt:formatNumber value="${job.matchResult.overallScore}" maxFractionDigits="1"/>%
                                        </div>
                                        <div class="small text-danger fw-bold mt-1">Low Fit</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Eligibility Check Notes -->
                        <div class="d-flex flex-wrap gap-2 small mb-3">
                            <span class="badge bg-light text-muted border">
                                <i class="fa-solid fa-graduation-cap me-1"></i> Min CGPA: ${job.minCgpa}
                            </span>
                            <span class="badge bg-light text-muted border">
                                <i class="fa-solid fa-sitemap me-1"></i> Branches: ${job.eligibleBranches}
                            </span>
                            <span class="badge bg-light text-muted border">
                                <i class="fa-solid fa-users me-1"></i> Openings: ${job.openings}
                            </span>
                        </div>

                        <!-- Matching Skills vs Missing Skills Analysis -->
                        <div class="p-3 bg-light rounded-3 mb-3">
                            <div class="small fw-bold text-dark mb-2">Explainable Match Breakdown:</div>
                            <div class="d-flex flex-wrap align-items-center mb-1">
                                <span class="small text-success fw-semibold me-1"><i class="fa-solid fa-circle-check"></i> Matched (${job.matchResult.matchedSkills.size()}):</span>
                                <c:forEach var="m" items="${job.matchResult.matchedSkills}">
                                    <span class="skill-pill skill-pill-matched">${m}</span>
                                </c:forEach>
                                <c:if test="${empty job.matchResult.matchedSkills}">
                                    <span class="small text-muted fst-italic">None registered yet</span>
                                </c:if>
                            </div>

                            <c:if test="${not empty job.matchResult.missingSkills}">
                                <div class="d-flex flex-wrap align-items-center mt-2">
                                    <span class="small text-danger fw-semibold me-1"><i class="fa-solid fa-circle-xmark"></i> Missing (${job.matchResult.missingSkills.size()}):</span>
                                    <c:forEach var="mis" items="${job.matchResult.missingSkills}">
                                        <span class="skill-pill skill-pill-missing">${mis}</span>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="d-flex justify-content-between align-items-center border-top pt-3">
                        <a href="${pageContext.request.contextPath}/student/job-detail?id=${job.id}" class="text-primary text-decoration-none fw-bold small">
                            <i class="fa-solid fa-chart-pie me-1"></i> View Explainable Score & Details
                        </a>

                        <div>
                            <c:choose>
                                <c:when test="${job.hasApplied}">
                                    <span class="badge bg-secondary-subtle text-secondary px-3 py-2 rounded-pill">
                                        <i class="fa-solid fa-check me-1"></i> Application Submitted
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/student/job-detail?id=${job.id}#applySection" class="btn btn-primary-custom btn-sm">
                                        <i class="fa-solid fa-paper-plane me-1"></i> Apply Now
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty jobs}">
            <div class="col-12 text-center py-5">
                <i class="fa-solid fa-magnifying-glass fs-1 mb-2 text-muted opacity-50 d-block"></i>
                <h5>No matching placement openings found</h5>
                <p class="text-secondary small">Try adjusting your search criteria or clearing filters.</p>
                <a href="${pageContext.request.contextPath}/student/jobs" class="btn btn-outline-custom">Reset Filters</a>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
