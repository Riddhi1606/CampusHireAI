<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Manage Job Postings — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-lg-4 py-4">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-rectangle-list text-primary me-2"></i>Job Postings Management</h3>
            <p class="text-secondary small mb-0">Publish openings, manage eligibility requirements, and monitor applications.</p>
        </div>
        <a href="${pageContext.request.contextPath}/recruiter/post-job" class="btn btn-primary-custom">
            <i class="fa-solid fa-circle-plus me-1"></i> Post New Job Opening
        </a>
    </div>

    <div class="card-custom bg-white border overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-4">Role Title & Department</th>
                        <th>Type & Location</th>
                        <th>Package</th>
                        <th>Min CGPA</th>
                        <th>Openings</th>
                        <th>Status</th>
                        <th>Applicants</th>
                        <th class="text-end pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="j" items="${jobs}">
                        <tr>
                            <td class="ps-4">
                                <div class="fw-bold text-dark">${j.title}</div>
                                <div class="small text-muted">${j.department}</div>
                            </td>
                            <td class="small text-secondary">
                                <span class="badge bg-light text-dark border">${j.jobType}</span>
                                <div>${j.location}</div>
                            </td>
                            <td class="small fw-semibold text-dark">${j.packageLpa}</td>
                            <td class="small">${j.minCgpa}</td>
                            <td class="small">${j.openings}</td>
                            <td>
                                <span class="badge ${j.status == 'ACTIVE' ? 'bg-success' : 'bg-secondary'} px-3 py-1 rounded-pill">
                                    ${j.status}
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/recruiter/applicants?jobId=${j.id}" class="badge bg-primary-subtle text-primary border border-primary-subtle text-decoration-none fs-7 p-2">
                                    <i class="fa-solid fa-users me-1"></i> ${j.applicantCount} Candidates
                                </a>
                            </td>
                            <td class="text-end pe-4">
                                <div class="d-inline-flex gap-2">
                                    <a href="${pageContext.request.contextPath}/recruiter/post-job?id=${j.id}" class="btn btn-sm btn-outline-secondary" title="Edit Job">
                                        <i class="fa-solid fa-pen"></i>
                                    </a>

                                    <form action="${pageContext.request.contextPath}/recruiter/jobs" method="post" class="d-inline">
                                        <input type="hidden" name="jobId" value="${j.id}">
                                        <c:choose>
                                            <c:when test="${j.status == 'ACTIVE'}">
                                                <input type="hidden" name="action" value="close">
                                                <button type="submit" class="btn btn-sm btn-outline-warning" title="Close Applications">
                                                    <i class="fa-solid fa-pause"></i>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="action" value="activate">
                                                <button type="submit" class="btn btn-sm btn-outline-success" title="Activate Job">
                                                    <i class="fa-solid fa-play"></i>
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>

                                    <form action="${pageContext.request.contextPath}/recruiter/jobs" method="post" class="d-inline" onsubmit="return confirm('Permanently delete this job posting?');">
                                        <input type="hidden" name="jobId" value="${j.id}">
                                        <input type="hidden" name="action" value="delete">
                                        <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete Job">
                                            <i class="fa-regular fa-trash-can"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty jobs}">
                        <tr>
                            <td colspan="8" class="text-center py-5 text-muted">
                                <i class="fa-solid fa-briefcase fs-1 mb-2 text-primary opacity-50 d-block"></i>
                                <h5>No job openings published yet</h5>
                                <p class="small mb-3">Post an opening to start matching with eligible student talent.</p>
                                <a href="${pageContext.request.contextPath}/recruiter/post-job" class="btn btn-primary-custom">
                                    Create First Opening
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
