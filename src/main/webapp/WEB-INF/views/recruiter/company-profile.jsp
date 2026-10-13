<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Company Profile — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card-custom p-4 p-md-5">
                <div class="mb-4 border-bottom pb-3">
                    <h3 class="fw-bold mb-1"><i class="fa-solid fa-building text-primary me-2"></i>Company Profile</h3>
                    <p class="text-secondary small mb-0">Maintain your organization's campus branding and recruiter presence.</p>
                </div>

                <form action="${pageContext.request.contextPath}/recruiter/company-profile" method="post">
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Company Name *</label>
                            <input type="text" class="form-control" name="companyName" value="${company.companyName}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Industry Sector</label>
                            <input type="text" class="form-control" name="industry" value="${company.industry}" placeholder="e.g. Software, Financial Tech, Cloud">
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Corporate Website URL</label>
                            <input type="url" class="form-control" name="website" value="${company.website}" placeholder="https://company.com">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Primary Office Location</label>
                            <input type="text" class="form-control" name="location" value="${company.location}" placeholder="e.g. Bengaluru, Karnataka">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Logo Image URL</label>
                        <input type="url" class="form-control" name="logoUrl" value="${company.logoUrl}" placeholder="https://example.com/logo.png">
                    </div>

                    <div class="mb-4">
                        <label class="form-label small fw-semibold">About Company / Campus Vision</label>
                        <textarea class="form-control" name="about" rows="4" placeholder="Briefly describe your company culture, technology domains, and career acceleration for fresh graduates">${company.about}</textarea>
                    </div>

                    <div class="d-flex justify-content-end gap-2">
                        <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="btn btn-outline-custom">Cancel</a>
                        <button type="submit" class="btn btn-primary-custom px-4">
                            <i class="fa-solid fa-floppy-disk me-2"></i> Save Company Profile
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
