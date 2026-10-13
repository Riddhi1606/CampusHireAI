<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="User Login — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-5 my-auto">
    <div class="row justify-content-center">
        <div class="col-lg-5 col-md-8">
            <div class="card-custom p-4 p-md-5">
                <div class="text-center mb-4">
                    <div class="d-inline-flex p-3 bg-primary-subtle text-primary rounded-circle mb-3">
                        <i class="fa-solid fa-lock fs-3"></i>
                    </div>
                    <h3 class="fw-bold text-dark">Welcome Back</h3>
                    <p class="text-secondary small">Sign in to your CampusHire AI portal account</p>
                </div>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label for="loginEmail" class="form-label fw-semibold small">Registered Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="fa-regular fa-envelope text-muted"></i></span>
                            <input type="email" class="form-control border-start-0" id="loginEmail" name="email" value="${email}" placeholder="you@college.edu or name@company.com" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label for="loginPassword" class="form-label fw-semibold small mb-0">Password</label>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-key text-muted"></i></span>
                            <input type="password" class="form-control border-start-0" id="loginPassword" name="password" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary-custom w-100 py-2 mb-3">
                        <i class="fa-solid fa-right-to-bracket me-2"></i> Sign In to Portal
                    </button>
                </form>

                <!-- Quick Evaluator Demo Fill Buttons -->
                <div class="border-top pt-3 mt-2">
                    <div class="text-center small text-muted mb-2 fw-semibold">
                        <i class="fa-solid fa-wand-magic-sparkles text-primary me-1"></i> Quick 1-Click Demo Login:
                    </div>
                    <div class="d-grid gap-2">
                        <button type="button" class="btn btn-sm btn-outline-primary" onclick="fillDemoLogin('student')">
                            <i class="fa-solid fa-user-graduate me-1"></i> Student Demo (Riddhi Sharma)
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-info text-dark" onclick="fillDemoLogin('recruiter')">
                            <i class="fa-solid fa-building me-1"></i> Recruiter Demo (Google India)
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-dark" onclick="fillDemoLogin('admin')">
                            <i class="fa-solid fa-shield-halved me-1"></i> Admin Demo (System Administrator)
                        </button>
                    </div>
                </div>

                <div class="text-center mt-4 small text-secondary">
                    Don't have an account yet? <a href="${pageContext.request.contextPath}/register" class="text-primary fw-bold text-decoration-none">Create Account</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
