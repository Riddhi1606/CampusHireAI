<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Review Applicants — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-lg-4 py-4">
    <!-- Header & Job Filter -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-users-viewfinder text-primary me-2"></i>Applicant Evaluation Pipeline</h3>
            <p class="text-secondary small mb-0">Rank candidates by transparent compatibility scores and manage interview rounds.</p>
        </div>

        <form action="${pageContext.request.contextPath}/recruiter/applicants" method="get" class="d-flex align-items-center gap-2">
            <label class="small fw-semibold text-muted text-nowrap">Filter by Opening:</label>
            <select class="form-select form-select-sm" name="jobId" onchange="this.form.submit()">
                <option value="0">All Active Openings (${applicants.size()})</option>
                <c:forEach var="j" items="${companyJobs}">
                    <option value="${j.id}" ${selectedJobId == j.id ? 'selected' : ''}>${j.title}</option>
                </c:forEach>
            </select>
        </form>
    </div>

    <!-- Candidate In-Depth Evaluation Modal / View if triggered -->
    <c:if test="${viewApp != null && viewStudent != null}">
        <div class="card-custom p-4 mb-4 border-primary shadow-sm bg-white">
            <div class="d-flex justify-content-between align-items-start border-bottom pb-3 mb-3">
                <div>
                    <span class="badge bg-primary-subtle text-primary mb-1">In-Depth Evaluation</span>
                    <h4 class="fw-bold mb-1">${viewStudent.fullName} &bull; ${viewApp.jobTitle}</h4>
                    <div class="small text-secondary">
                        ${viewStudent.collegeName} &bull; ${viewStudent.branch} &bull; CGPA: <strong>${viewStudent.cgpa}</strong>
                    </div>
                </div>
                <div class="text-end">
                    <span class="match-score-badge match-high fs-5">
                        <fmt:formatNumber value="${viewApp.matchScore}" maxFractionDigits="1"/>% Match
                    </span>
                    <a href="${pageContext.request.contextPath}/recruiter/applicants" class="btn btn-sm btn-outline-secondary ms-2">Close View</a>
                </div>
            </div>

            <div class="row g-4">
                <!-- Evaluation Criteria Breakdown -->
                <div class="col-md-6">
                    <h6 class="fw-bold text-dark mb-2"><i class="fa-solid fa-chart-pie text-primary me-2"></i>5-Pillar Compatibility Analysis</h6>
                    <c:if test="${viewMatchResult != null}">
                        <div class="p-3 bg-light rounded-3 mb-3">
                            <div class="small mb-2"><strong>Required Skills (50%):</strong> <fmt:formatNumber value="${viewMatchResult.skillScore}" maxFractionDigits="1"/> / 50.0</div>
                            <div class="small mb-2"><strong>CGPA Score (20%):</strong> <fmt:formatNumber value="${viewMatchResult.cgpaScore}" maxFractionDigits="1"/> / 20.0</div>
                            <div class="small mb-2"><strong>Branch Alignment (15%):</strong> <fmt:formatNumber value="${viewMatchResult.branchScore}" maxFractionDigits="1"/> / 15.0</div>
                            <div class="small mb-2"><strong>Certifications (10%):</strong> <fmt:formatNumber value="${viewMatchResult.certScore}" maxFractionDigits="1"/> / 10.0</div>
                            <div class="small"><strong>Projects (5%):</strong> <fmt:formatNumber value="${viewMatchResult.projectScore}" maxFractionDigits="1"/> / 5.0</div>
                        </div>

                        <div class="mb-3">
                            <div class="small fw-bold text-success mb-1">Matched Skills:</div>
                            <c:forEach var="m" items="${viewMatchResult.matchedSkills}">
                                <span class="skill-pill skill-pill-matched">${m}</span>
                            </c:forEach>
                        </div>

                        <c:if test="${not empty viewMatchResult.missingSkills}">
                            <div class="mb-3">
                                <div class="small fw-bold text-danger mb-1">Missing Skills:</div>
                                <c:forEach var="mis" items="${viewMatchResult.missingSkills}">
                                    <span class="skill-pill skill-pill-missing">${mis}</span>
                                </c:forEach>
                            </div>
                        </c:if>
                    </c:if>

                    <div class="mt-3">
                        <c:if test="${not empty viewStudent.resumeUrl}">
                            <a href="${viewStudent.resumeUrl}" target="_blank" class="btn btn-outline-primary btn-sm">
                                <i class="fa-solid fa-file-pdf me-1"></i> View Candidate Resume
                            </a>
                        </c:if>
                        <c:if test="${not empty viewStudent.githubUrl}">
                            <a href="${viewStudent.githubUrl}" target="_blank" class="btn btn-outline-dark btn-sm ms-2">
                                <i class="fa-brands fa-github me-1"></i> GitHub
                            </a>
                        </c:if>
                    </div>
                </div>

                <!-- Status Update Form -->
                <div class="col-md-6 border-start">
                    <h6 class="fw-bold text-dark mb-2"><i class="fa-solid fa-pen-to-square text-info me-2"></i>Update Candidate Recruitment Stage</h6>
                    <form action="${pageContext.request.contextPath}/recruiter/applicants" method="post">
                        <input type="hidden" name="applicationId" value="${viewApp.id}">
                        <input type="hidden" name="returnJobId" value="${selectedJobId}">

                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Application Stage</label>
                            <select class="form-select" name="status">
                                <option value="APPLIED" ${viewApp.status == 'APPLIED' ? 'selected' : ''}>Applied</option>
                                <option value="IN_REVIEW" ${viewApp.status == 'IN_REVIEW' ? 'selected' : ''}>In Review</option>
                                <option value="SHORTLISTED" ${viewApp.status == 'SHORTLISTED' ? 'selected' : ''}>Shortlisted for Interview</option>
                                <option value="INTERVIEW_SCHEDULED" ${viewApp.status == 'INTERVIEW_SCHEDULED' ? 'selected' : ''}>Interview Scheduled</option>
                                <option value="OFFERED" ${viewApp.status == 'OFFERED' ? 'selected' : ''}>Job Offered</option>
                                <option value="REJECTED" ${viewApp.status == 'REJECTED' ? 'selected' : ''}>Rejected</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Interview Schedule (Date & Time)</label>
                            <input type="datetime-local" class="form-control" name="interviewDate" value="${viewApp.interviewDate != null ? viewApp.interviewDate.toString().substring(0, 16) : ''}">
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Interviewer Feedback & Notes</label>
                            <textarea class="form-control" name="recruiterNotes" rows="3" placeholder="Technical round assessment, internal remarks, or student feedback...">${viewApp.recruiterNotes}</textarea>
                        </div>

                        <button type="submit" class="btn btn-primary-custom w-100">
                            <i class="fa-solid fa-floppy-disk me-1"></i> Save Evaluation & Update Status
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Applicants Table -->
    <div class="card-custom bg-white border overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-4">Candidate Profile</th>
                        <th>College & Branch</th>
                        <th>CGPA</th>
                        <th>Position Applied</th>
                        <th>Match Score</th>
                        <th>Status</th>
                        <th>Interview Date</th>
                        <th class="text-end pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="app" items="${applicants}">
                        <tr>
                            <td class="ps-4">
                                <div class="fw-bold text-dark">${app.studentName}</div>
                                <div class="small text-muted">${app.studentEmail} &bull; ${app.studentPhone}</div>
                            </td>
                            <td class="small text-secondary">
                                <div>${app.studentBranch}</div>
                                <div class="text-muted small">${app.studentCollege}</div>
                            </td>
                            <td class="small fw-bold text-dark">${app.studentCgpa}</td>
                            <td class="small fw-semibold text-secondary">${app.jobTitle}</td>
                            <td>
                                <span class="badge bg-light text-dark border fs-7 fw-bold">
                                    <fmt:formatNumber value="${app.matchScore}" maxFractionDigits="1"/>%
                                </span>
                            </td>
                            <td>
                                <span class="badge bg-${app.statusBadgeClass} text-capitalize px-3 py-1 rounded-pill">
                                    ${app.status.name().replace('_', ' ').toLowerCase()}
                                </span>
                            </td>
                            <td class="small text-muted">
                                <c:choose>
                                    <c:when test="${not empty app.interviewDate}">
                                        <div class="text-primary fw-semibold">
                                            <fmt:formatDate value="${app.interviewDate}" pattern="MMM dd, hh:mm a"/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end pe-4">
                                <a href="${pageContext.request.contextPath}/recruiter/applicants?jobId=${app.jobId}&viewAppId=${app.id}" class="btn btn-sm btn-primary-custom">
                                    Evaluate Candidate
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty applicants}">
                        <tr>
                            <td colspan="8" class="text-center py-5 text-muted">
                                <i class="fa-solid fa-users-slash fs-1 mb-2 text-primary opacity-50 d-block"></i>
                                <h5>No applications matching this selection</h5>
                                <p class="small">Check back as students discover and apply for your campus listings.</p>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
