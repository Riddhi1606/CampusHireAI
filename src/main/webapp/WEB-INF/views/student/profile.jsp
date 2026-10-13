<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="My Academic Profile — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="card-custom p-4 p-md-5">
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <div>
                        <h4 class="fw-bold mb-1"><i class="fa-solid fa-id-card text-primary me-2"></i>Academic & Career Profile</h4>
                        <div class="small text-secondary">Keep your academic metrics up-to-date for accurate match scoring</div>
                    </div>
                    <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill fw-bold">
                        Readiness: ${student.profileCompletionPercentage}%
                    </span>
                </div>

                <form action="${pageContext.request.contextPath}/student/profile" method="post">
                    <!-- Academic Credentials -->
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-graduation-cap text-info me-2"></i>Educational Qualifications</h5>
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">College / University Name *</label>
                            <input type="text" class="form-control" name="collegeName" value="${student.collegeName}" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-semibold">Degree Program</label>
                            <input type="text" class="form-control" name="degree" value="${student.degree != null ? student.degree : 'B.Tech'}">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-semibold">Graduation Year</label>
                            <input type="number" class="form-control" name="graduationYear" value="${student.graduationYear}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Branch / Department *</label>
                            <input type="text" class="form-control" name="branch" value="${student.branch}" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-semibold">Cumulative CGPA (0.0 - 10.0) *</label>
                            <input type="number" step="0.01" min="0" max="10" class="form-control" name="cgpa" value="${student.cgpa}" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-semibold">Roll / Registration No.</label>
                            <input type="text" class="form-control" name="rollNumber" value="${student.rollNumber}">
                        </div>
                    </div>

                    <!-- Contact & Professional Links -->
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-link text-primary me-2"></i>Contact & Portfolios</h5>
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Contact Phone Number</label>
                            <input type="text" class="form-control" name="phone" value="${student.phone}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Live Resume Drive / PDF Link</label>
                            <input type="url" class="form-control" name="resumeUrl" value="${student.resumeUrl}" placeholder="https://drive.google.com/...">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">GitHub Profile URL</label>
                            <input type="url" class="form-control" name="githubUrl" value="${student.githubUrl}" placeholder="https://github.com/username">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">LinkedIn Profile URL</label>
                            <input type="url" class="form-control" name="linkedinUrl" value="${student.linkedinUrl}" placeholder="https://linkedin.com/in/username">
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-semibold">Career Bio / Summary</label>
                            <textarea class="form-control" name="bio" rows="3" placeholder="Brief statement highlighting your engineering passions and career objectives">${student.bio}</textarea>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2">
                        <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-outline-custom">Cancel</a>
                        <button type="submit" class="btn btn-primary-custom px-4">
                            <i class="fa-solid fa-floppy-disk me-2"></i> Save Profile Details
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
