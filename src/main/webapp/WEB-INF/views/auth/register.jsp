<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Create Account — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-5 my-auto">
    <div class="row justify-content-center">
        <div class="col-lg-7 col-md-10">
            <div class="card-custom p-4 p-md-5">
                <div class="text-center mb-4">
                    <div class="d-inline-flex p-3 bg-primary-subtle text-primary rounded-circle mb-3">
                        <i class="fa-solid fa-user-plus fs-3"></i>
                    </div>
                    <h3 class="fw-bold text-dark">Join CampusHire AI</h3>
                    <p class="text-secondary small">Select your portal role to initialize your profile</p>
                </div>

                <form action="${pageContext.request.contextPath}/register" method="post" id="regForm">
                    <!-- Role Selection Radio Group -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold small d-block">Account Role</label>
                        <div class="row g-2">
                            <div class="col-6">
                                <input type="radio" class="btn-check" name="role" id="roleStudent" value="STUDENT" checked onchange="toggleRoleFields()">
                                <label class="btn btn-outline-primary w-100 py-2 d-flex flex-column align-items-center gap-1" for="roleStudent">
                                    <i class="fa-solid fa-user-graduate fs-5"></i>
                                    <span class="fw-bold small">Student Candidate</span>
                                </label>
                            </div>
                            <div class="col-6">
                                <input type="radio" class="btn-check" name="role" id="roleRecruiter" value="RECRUITER" onchange="toggleRoleFields()">
                                <label class="btn btn-outline-info w-100 py-2 d-flex flex-column align-items-center gap-1 text-dark" for="roleRecruiter">
                                    <i class="fa-solid fa-building-user fs-5 text-info"></i>
                                    <span class="fw-bold small">Company Recruiter</span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Common Credentials -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Full Name *</label>
                            <input type="text" class="form-control" name="fullName" placeholder="e.g. Riddhi Sharma" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Email Address *</label>
                            <input type="email" class="form-control" name="email" placeholder="e.g. name@college.edu" required>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Password *</label>
                            <input type="password" class="form-control" name="password" placeholder="Min. 6 characters" minlength="6" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Confirm Password *</label>
                            <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm password" minlength="6" required>
                        </div>
                    </div>

                    <!-- Student Specific Fields -->
                    <div id="studentFields">
                        <div class="p-3 bg-light rounded-3 mb-3 border">
                            <h6 class="fw-bold text-dark mb-3"><i class="fa-solid fa-graduation-cap text-primary me-2"></i>Academic Details</h6>
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">College / University Name</label>
                                    <input type="text" class="form-control" name="collegeName" placeholder="e.g. National Institute of Technology">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Branch / Department</label>
                                    <input type="text" class="form-control" name="branch" placeholder="e.g. Computer Science and Engineering">
                                </div>
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Cumulative CGPA (0 - 10.0)</label>
                                    <input type="number" step="0.01" min="0" max="10" class="form-control" name="cgpa" placeholder="e.g. 8.75">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Graduation Year</label>
                                    <input type="number" class="form-control" name="graduationYear" value="2026">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recruiter Specific Fields -->
                    <div id="recruiterFields" style="display: none;">
                        <div class="p-3 bg-light rounded-3 mb-3 border">
                            <h6 class="fw-bold text-dark mb-3"><i class="fa-solid fa-building text-info me-2"></i>Company Information</h6>
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Company / Organisation Name</label>
                                    <input type="text" class="form-control" name="companyName" placeholder="e.g. Microsoft / Google">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Industry Sector</label>
                                    <input type="text" class="form-control" name="industry" placeholder="e.g. Software & Cloud Computing">
                                </div>
                            </div>
                            <div class="row g-3">
                                <div class="col-12">
                                    <label class="form-label small fw-semibold">Headquarters / Primary Office Location</label>
                                    <input type="text" class="form-control" name="location" placeholder="e.g. Bengaluru / Hyderabad / Remote">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="alert alert-light border small text-muted py-2 mb-3">
                        <i class="fa-solid fa-circle-info text-primary me-1"></i>
                        Notice: Administrator permissions cannot be registered publicly and are provisioned by system configuration.
                    </div>

                    <button type="submit" class="btn btn-primary-custom w-100 py-2 mb-3">
                        <i class="fa-solid fa-check me-2"></i> Complete Registration
                    </button>
                </form>

                <div class="text-center small text-secondary">
                    Already registered? <a href="${pageContext.request.contextPath}/login" class="text-primary fw-bold text-decoration-none">Sign In</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function toggleRoleFields() {
    const isStudent = document.getElementById('roleStudent').checked;
    document.getElementById('studentFields').style.display = isStudent ? 'block' : 'none';
    document.getElementById('recruiterFields').style.display = isStudent ? 'none' : 'block';
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
