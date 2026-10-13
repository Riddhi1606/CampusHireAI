<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Job Moderation — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-lg-4 py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-list-check text-primary me-2"></i>Job Postings Moderation</h3>
            <p class="text-secondary small mb-0">Review company listings, verify eligibility requirements, and audit placement status.</p>
        </div>
        <span class="badge bg-primary fs-6 px-3 py-2 rounded-pill">${jobs.size()} Total Job Openings</span>
    </div>

    <div class="card-custom bg-white border overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-4">Title & Department</th>
                        <th>Company</th>
                        <th>Type & Location</th>
                        <th>Package</th>
                        <th>Min CGPA</th>
                        <th>Status</th>
                        <th>Applicants</th>
                        <th class="text-end pe-4">Moderation Status Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="j" items="${jobs}">
                        <tr>
                            <td class="ps-4">
                                <div class="fw-bold text-dark">${j.title}</div>
                                <div class="small text-muted">${j.department}</div>
                            </td>
                            <td class="small fw-semibold">${j.companyName}</td>
                            <td class="small text-secondary">
                                <span class="badge bg-light text-dark border">${j.jobType}</span>
                                <div>${j.location}</div>
                            </td>
                            <td class="small fw-bold">${j.packageLpa}</td>
                            <td class="small">${j.minCgpa}</td>
                            <td>
                                <span class="badge ${j.status == 'ACTIVE' ? 'bg-success' : (j.status == 'UNDER_REVIEW' ? 'bg-warning' : 'bg-secondary')} px-3 py-1 rounded-pill">
                                    ${j.status}
                                </span>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border">${j.applicantCount} applicants</span>
                            </td>
                            <td class="text-end pe-4">
                                <form action="${pageContext.request.contextPath}/admin/jobs" method="post" class="d-inline-flex gap-1 align-items-center">
                                    <input type="hidden" name="jobId" value="${j.id}">
                                    <select class="form-select form-select-sm" name="action" style="width: 140px;">
                                        <option value="ACTIVE" ${j.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                                        <option value="UNDER_REVIEW" ${j.status == 'UNDER_REVIEW' ? 'selected' : ''}>Under Review</option>
                                        <option value="CLOSED" ${j.status == 'CLOSED' ? 'selected' : ''}>Closed</option>
                                    </select>
                                    <button type="submit" class="btn btn-sm btn-outline-primary">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
