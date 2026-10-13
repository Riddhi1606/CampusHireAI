<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="My Certifications — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="card-custom p-4 mb-4">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2 mb-4 border-bottom pb-3">
                    <div>
                        <h4 class="fw-bold mb-1"><i class="fa-solid fa-certificate text-primary me-2"></i>Professional Certifications</h4>
                        <div class="small text-secondary">Verified credentials contribute 10% toward your placement matching score</div>
                    </div>
                    <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#addCertModal">
                        <i class="fa-solid fa-plus me-1"></i> Add Certification
                    </button>
                </div>

                <div class="row g-3">
                    <c:forEach var="c" items="${certifications}">
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light d-flex justify-content-between align-items-start">
                                <div class="d-flex gap-3 align-items-start">
                                    <div class="bg-success-subtle text-success p-2 rounded-circle mt-1">
                                        <i class="fa-solid fa-award fs-5"></i>
                                    </div>
                                    <div>
                                        <h6 class="fw-bold mb-1 text-dark">${c.name}</h6>
                                        <div class="small text-secondary mb-1">${c.issuingOrganization}</div>
                                        <div class="small text-muted mb-2">
                                            <i class="fa-regular fa-calendar me-1"></i> Issued: <fmt:formatDate value="${c.issueDate}" pattern="MMM yyyy"/>
                                        </div>
                                        <c:if test="${not empty c.credentialUrl}">
                                            <a href="${c.credentialUrl}" target="_blank" class="small text-primary text-decoration-none fw-semibold">
                                                <i class="fa-solid fa-arrow-up-right-from-square me-1"></i> View Credential
                                            </a>
                                        </c:if>
                                    </div>
                                </div>

                                <form action="${pageContext.request.contextPath}/student/certifications" method="post" onsubmit="return confirm('Remove certification?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="certId" value="${c.id}">
                                    <button type="submit" class="btn btn-sm text-danger border-0 p-0">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty certifications}">
                        <div class="col-12 text-center py-5 text-muted">
                            <i class="fa-solid fa-stamp fs-1 mb-2 text-primary opacity-50 d-block"></i>
                            <h5>No certifications added yet</h5>
                            <p class="small mb-3">Add AWS, Oracle, Google Cloud, Coursera, or Microsoft credentials to boost your placement score.</p>
                            <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#addCertModal">
                                <i class="fa-solid fa-plus me-1"></i> Add Your First Credential
                            </button>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Certification Modal -->
<div class="modal fade" id="addCertModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content card-custom">
            <div class="modal-header border-bottom">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-award text-primary me-2"></i>Add Professional Certification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/student/certifications" method="post">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Certification Name *</label>
                        <input type="text" class="form-control" name="name" placeholder="e.g. AWS Certified Cloud Practitioner / OCP Java SE 17" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Issuing Organization *</label>
                        <input type="text" class="form-control" name="issuingOrganization" placeholder="e.g. Amazon Web Services / Oracle / Coursera" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Issue Date</label>
                        <input type="date" class="form-control" name="issueDate">
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Credential Verification URL</label>
                        <input type="url" class="form-control" name="credentialUrl" placeholder="https://coursera.org/verify/...">
                    </div>
                </div>
                <div class="modal-footer border-top">
                    <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary-custom">Save Certification</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
