<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-custom sticky-top">
    <div class="container-fluid px-lg-4">
        <a class="brand-logo" href="${pageContext.request.contextPath}/">
            <i class="fa-solid fa-graduation-cap"></i>
            <span>Campus<span class="text-primary">Hire</span> <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1 rounded-pill fs-7">AI</span></span>
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <c:choose>
                    <c:when test="${sessionScope.currentUser != null && sessionScope.currentUser.role == 'STUDENT'}">
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/student/dashboard">
                                <i class="fa-solid fa-chart-pie me-1 text-primary"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/student/jobs">
                                <i class="fa-solid fa-briefcase me-1 text-primary"></i> Explore Jobs & Match
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/student/applications">
                                <i class="fa-solid fa-paper-plane me-1 text-primary"></i> My Applications
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/student/skill-gap">
                                <i class="fa-solid fa-route me-1 text-primary"></i> Skill Gap Roadmap
                            </a>
                        </li>
                    </c:when>

                    <c:when test="${sessionScope.currentUser != null && sessionScope.currentUser.role == 'RECRUITER'}">
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/recruiter/dashboard">
                                <i class="fa-solid fa-chart-line me-1 text-primary"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/recruiter/jobs">
                                <i class="fa-solid fa-rectangle-list me-1 text-primary"></i> Manage Jobs
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/recruiter/post-job">
                                <i class="fa-solid fa-circle-plus me-1 text-primary"></i> Post New Job
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/recruiter/applicants">
                                <i class="fa-solid fa-users me-1 text-primary"></i> Review Applicants
                            </a>
                        </li>
                    </c:when>

                    <c:when test="${sessionScope.currentUser != null && sessionScope.currentUser.role == 'ADMIN'}">
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fa-solid fa-gauge-high me-1 text-primary"></i> Overview
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fa-solid fa-users-gear me-1 text-primary"></i> Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/admin/jobs">
                                <i class="fa-solid fa-list-check me-1 text-primary"></i> Jobs Moderation
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/admin/skills">
                                <i class="fa-solid fa-tags me-1 text-primary"></i> Skills Taxonomy
                            </a>
                        </li>
                    </c:when>

                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="${pageContext.request.contextPath}/login">Explore Roles</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold px-3" href="#methodology">5-Pillar Matching Formula</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>

            <div class="d-flex align-items-center gap-2">
                <c:choose>
                    <c:when test="${sessionScope.currentUser != null}">
                        <div class="dropdown">
                            <button class="btn btn-light border dropdown-toggle d-flex align-items-center gap-2 py-1 px-3 rounded-pill" type="button" data-bs-toggle="dropdown">
                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 32px; height: 32px; font-weight: 700; font-size: 0.85rem;">
                                    ${sessionScope.currentUser.fullName.substring(0, 1)}
                                </div>
                                <div class="text-start d-none d-md-block">
                                    <div class="fw-bold small lh-1">${sessionScope.currentUser.fullName}</div>
                                    <span class="badge bg-secondary-subtle text-secondary py-0 px-1 rounded-pill" style="font-size: 0.65rem;">${sessionScope.currentUser.role}</span>
                                </div>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2 rounded-3">
                                <c:if test="${sessionScope.currentUser.role == 'STUDENT'}">
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/student/profile"><i class="fa-regular fa-user me-2 text-muted"></i> Academic Profile</a></li>
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/student/skills"><i class="fa-solid fa-code me-2 text-muted"></i> Manage Skills</a></li>
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/student/projects"><i class="fa-solid fa-laptop-code me-2 text-muted"></i> Portfolio Projects</a></li>
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/student/certifications"><i class="fa-solid fa-award me-2 text-muted"></i> Certifications</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <c:if test="${sessionScope.currentUser.role == 'RECRUITER'}">
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/recruiter/company-profile"><i class="fa-regular fa-building me-2 text-muted"></i> Company Profile</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li>
                                    <a class="dropdown-item text-danger py-2" href="${pageContext.request.contextPath}/logout">
                                        <i class="fa-solid fa-right-from-bracket me-2"></i> Log Out
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-custom">Log In</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary-custom">Get Started</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>
