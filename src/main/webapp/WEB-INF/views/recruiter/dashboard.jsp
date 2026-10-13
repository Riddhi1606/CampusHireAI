<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Recruiter Dashboard — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-lg-4 py-4">
    <!-- Company Profile Header Banner -->
    <div class="card-custom p-4 mb-4 bg-gradient-dark text-white border-0 shadow">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
            <div>
                <span class="badge bg-white bg-opacity-25 text-white mb-2 px-3 py-1 rounded-pill">
                    <i class="fa-solid fa-building me-1"></i> Talent Acquisition Console
                </span>
                <h2 class="fw-bold mb-1">${company.companyName}</h2>
                <p class="mb-0 text-white-50 small">
                    ${company.industry} &bull; <i class="fa-solid fa-location-dot me-1"></i> ${company.location} &bull; Recruiter: ${company.recruiterName}
                </p>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/recruiter/post-job" class="btn btn-primary-custom px-4 rounded-pill">
                    <i class="fa-solid fa-circle-plus me-1"></i> Post New Job
                </a>
                <a href="${pageContext.request.contextPath}/recruiter/company-profile" class="btn btn-outline-light rounded-pill">
                    <i class="fa-solid fa-gear me-1"></i> Company Profile
                </a>
            </div>
        </div>
    </div>

    <!-- Metrics Cards -->
    <div class="row g-3 mb-4">
        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-primary-subtle text-primary">
                    <i class="fa-solid fa-briefcase"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Active Job Postings</div>
                    <h3 class="fw-bold mb-0">${activeJobsCount} / ${jobsCount}</h3>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-info-subtle text-info">
                    <i class="fa-solid fa-users"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Total Applicants</div>
                    <h3 class="fw-bold mb-0">${applicantsCount}</h3>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-warning-subtle text-warning">
                    <i class="fa-solid fa-user-check"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Shortlisted Candidates</div>
                    <h3 class="fw-bold mb-0">${shortlistedCount}</h3>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-success-subtle text-success">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Interviews Scheduled</div>
                    <h3 class="fw-bold mb-0">${interviewCount}</h3>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Recent Applicants -->
        <div class="col-lg-8">
            <div class="card-custom p-4 mb-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0"><i class="fa-solid fa-users text-primary me-2"></i>Recent Candidate Applications</h5>
                    <a href="${pageContext.request.contextPath}/recruiter/applicants" class="btn btn-sm btn-outline-custom">
                        View All Applicants <i class="fa-solid fa-arrow-right ms-1"></i>
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Candidate</th>
                                <th>Position</th>
                                <th>Match Score</th>
                                <th>Status</th>
                                <th class="text-end">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="app" items="${recentApplicants}">
                                <tr>
                                    <td>
                                        <div class="fw-bold text-dark">${app.studentName}</div>
                                        <div class="small text-muted">${app.studentBranch} &bull; CGPA: ${app.studentCgpa}</div>
                                    </td>
                                    <td class="small text-secondary">${app.jobTitle}</td>
                                    <td>
                                        <span class="badge bg-light text-dark border fw-bold fs-7">
                                            <fmt:formatNumber value="${app.matchScore}" maxFractionDigits="1"/>%
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge bg-${app.statusBadgeClass} text-capitalize">
                                            ${app.status.name().replace('_', ' ').toLowerCase()}
                                        </span>
                                    </td>
                                    <td class="text-end">
                                        <a href="${pageContext.request.contextPath}/recruiter/applicants?jobId=${app.jobId}&viewAppId=${app.id}" class="btn btn-sm btn-outline-primary">
                                            Evaluate
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty recentApplicants}">
                                <tr>
                                    <td colspan="5" class="text-center py-4 text-muted small">
                                        No candidate applications received yet.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Active Jobs Quick View -->
        <div class="col-lg-4">
            <div class="card-custom p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0"><i class="fa-solid fa-rectangle-list text-primary me-2"></i>Job Postings</h5>
                    <a href="${pageContext.request.contextPath}/recruiter/jobs" class="small text-primary text-decoration-none fw-bold">Manage</a>
                </div>

                <div class="d-flex flex-column gap-3">
                    <c:forEach var="j" items="${recentJobs}">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="d-flex justify-content-between align-items-start mb-1">
                                <h6 class="fw-bold text-dark mb-0">${j.title}</h6>
                                <span class="badge ${j.status == 'ACTIVE' ? 'bg-success' : 'bg-secondary'} small">${j.status}</span>
                            </div>
                            <div class="small text-secondary mb-2">${j.packageLpa} &bull; ${j.location}</div>
                            <div class="d-flex justify-content-between align-items-center small">
                                <span class="text-muted"><i class="fa-solid fa-users me-1"></i> ${j.applicantCount} applicants</span>
                                <a href="${pageContext.request.contextPath}/recruiter/applicants?jobId=${j.id}" class="btn btn-sm btn-outline-primary py-0">Review</a>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty recentJobs}">
                        <div class="text-center py-4 text-muted small">
                            No job postings created yet.
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
