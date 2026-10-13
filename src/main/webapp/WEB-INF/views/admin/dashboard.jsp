<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="System Admin Console — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-lg-4 py-4">
    <!-- Admin Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <span class="badge bg-danger-subtle text-danger px-3 py-1 rounded-pill fw-bold mb-1">
                <i class="fa-solid fa-shield-halved me-1"></i> Root Governance
            </span>
            <h3 class="fw-bold mb-0">Platform Administration & Ecosystem Analytics</h3>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-custom">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/skills" class="btn btn-primary-custom">Manage Skills</a>
        </div>
    </div>

    <!-- Platform KPI Metrics -->
    <div class="row g-3 mb-4">
        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-primary-subtle text-primary">
                    <i class="fa-solid fa-user-graduate"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Registered Students</div>
                    <h3 class="fw-bold mb-0">${stats.totalStudents}</h3>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-info-subtle text-info">
                    <i class="fa-solid fa-building"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Partner Companies / Recruiters</div>
                    <h3 class="fw-bold mb-0">${stats.totalRecruiters}</h3>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-success-subtle text-success">
                    <i class="fa-solid fa-briefcase"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Active Placement Openings</div>
                    <h3 class="fw-bold mb-0">${stats.activeJobs} / ${stats.totalJobs}</h3>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-sm-6">
            <div class="metric-stat-card shadow-sm">
                <div class="metric-icon-box bg-warning-subtle text-warning">
                    <i class="fa-solid fa-paper-plane"></i>
                </div>
                <div>
                    <div class="text-secondary small fw-semibold">Applications Processed</div>
                    <h3 class="fw-bold mb-0">${stats.totalApplications}</h3>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <!-- Interactive Chart: In-Demand Tech Skills -->
        <div class="col-lg-7">
            <div class="card-custom p-4 h-100 bg-white">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0"><i class="fa-solid fa-chart-column text-primary me-2"></i>Most Demanded Skills by Recruiters</h5>
                    <span class="badge bg-light text-muted border">Live Database Aggregate</span>
                </div>
                <div style="height: 280px;">
                    <canvas id="skillsChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Recent Registered Users -->
        <div class="col-lg-5">
            <div class="card-custom p-4 h-100 bg-white">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0"><i class="fa-solid fa-users text-primary me-2"></i>Recent Users</h5>
                    <a href="${pageContext.request.contextPath}/admin/users" class="small text-primary text-decoration-none fw-bold">View All</a>
                </div>

                <div class="d-flex flex-column gap-2">
                    <c:forEach var="u" items="${recentUsers}">
                        <div class="p-2 border rounded-3 bg-light d-flex justify-content-between align-items-center">
                            <div>
                                <div class="fw-bold small text-dark">${u.fullName}</div>
                                <div class="small text-muted">${u.email}</div>
                            </div>
                            <div class="text-end">
                                <span class="badge bg-${u.role == 'STUDENT' ? 'primary' : (u.role == 'RECRUITER' ? 'info' : 'dark')} small">${u.role}</span>
                                <span class="badge ${u.active ? 'bg-success' : 'bg-danger'} ms-1 small">${u.active ? 'Active' : 'Disabled'}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Job Postings Overview -->
    <div class="card-custom p-4 bg-white border">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="fw-bold mb-0"><i class="fa-solid fa-list-check text-primary me-2"></i>Recent Postings Oversight</h5>
            <a href="${pageContext.request.contextPath}/admin/jobs" class="small text-primary text-decoration-none fw-bold">Moderate All Openings</a>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Title</th>
                        <th>Company</th>
                        <th>Type</th>
                        <th>Min CGPA</th>
                        <th>Status</th>
                        <th>Applicants</th>
                        <th class="text-end">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="j" items="${recentJobs}">
                        <tr>
                            <td class="fw-bold text-dark">${j.title}</td>
                            <td>${j.companyName}</td>
                            <td><span class="badge bg-light text-dark border">${j.jobType}</span></td>
                            <td>${j.minCgpa}</td>
                            <td><span class="badge ${j.status == 'ACTIVE' ? 'bg-success' : 'bg-secondary'}">${j.status}</span></td>
                            <td>${j.applicantCount} candidates</td>
                            <td class="text-end">
                                <a href="${pageContext.request.contextPath}/admin/jobs" class="btn btn-sm btn-outline-custom">Review</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const ctx = document.getElementById('skillsChart').getContext('2d');
    const skillLabels = [];
    const skillCounts = [];

    <c:forEach var="entry" items="${stats.topSkills}">
        skillLabels.push('${entry.key}');
        skillCounts.push(${entry.value});
    </c:forEach>

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: skillLabels.length > 0 ? skillLabels : ['Java', 'Spring Boot', 'MySQL', 'React', 'Docker', 'Python', 'AWS'],
            datasets: [{
                label: 'Required across Active Postings',
                data: skillCounts.length > 0 ? skillCounts : [5, 4, 4, 3, 3, 2, 2],
                backgroundColor: 'rgba(79, 70, 229, 0.85)',
                borderColor: '#4f46e5',
                borderRadius: 6,
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { precision: 0 }
                }
            },
            plugins: {
                legend: { display: false }
            }
        }
    });
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
