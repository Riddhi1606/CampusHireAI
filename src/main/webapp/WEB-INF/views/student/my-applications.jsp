<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="My Placement Applications — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-lg-4 py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-paper-plane text-primary me-2"></i>My Job Applications</h3>
            <p class="text-secondary small mb-0">Track your application lifecycle stages, interview rounds, and feedback.</p>
        </div>
        <a href="${pageContext.request.contextPath}/student/jobs" class="btn btn-primary-custom">
            <i class="fa-solid fa-magnifying-glass me-1"></i> Explore More Jobs
        </a>
    </div>

    <div class="card-custom bg-white border overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-4">Company & Role</th>
                        <th>Applied On</th>
                        <th>Match Score</th>
                        <th>Current Status</th>
                        <th>Interview Date</th>
                        <th>Recruiter Feedback / Notes</th>
                        <th class="text-end pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="app" items="${applications}">
                        <tr>
                            <td class="ps-4">
                                <div class="fw-bold text-dark">${app.jobTitle}</div>
                                <div class="small text-muted">${app.companyName} &bull; ${app.jobLocation}</div>
                            </td>
                            <td class="small text-secondary">
                                <fmt:formatDate value="${app.appliedAt}" pattern="MMM dd, yyyy"/>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border fw-bold fs-7">
                                    <fmt:formatNumber value="${app.matchScore}" maxFractionDigits="1"/>%
                                </span>
                            </td>
                            <td>
                                <span class="badge bg-${app.statusBadgeClass} text-capitalize px-3 py-2 rounded-pill">
                                    ${app.status.name().replace('_', ' ').toLowerCase()}
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty app.interviewDate}">
                                        <div class="small text-primary fw-bold">
                                            <i class="fa-solid fa-calendar-check me-1"></i>
                                            <fmt:formatDate value="${app.interviewDate}" pattern="MMM dd, yyyy hh:mm a"/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="small text-muted fst-italic">Pending schedule</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="max-width: 250px;">
                                <div class="small text-secondary text-truncate" title="${app.recruiterNotes}">
                                    ${not empty app.recruiterNotes ? app.recruiterNotes : '<span class="text-muted fst-italic">No notes yet</span>'}
                                </div>
                            </td>
                            <td class="text-end pe-4">
                                <a href="${pageContext.request.contextPath}/student/job-detail?id=${app.jobId}" class="btn btn-sm btn-outline-custom">
                                    View Job
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty applications}">
                        <tr>
                            <td colspan="7" class="text-center py-5 text-muted">
                                <i class="fa-solid fa-inbox fs-1 mb-2 text-primary opacity-50 d-block"></i>
                                <h5>No applications submitted yet</h5>
                                <p class="small mb-3">Browse available placement openings and match your profile.</p>
                                <a href="${pageContext.request.contextPath}/student/jobs" class="btn btn-primary-custom">
                                    Browse Jobs Now
                                </a>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
