<%@ page contentType="text/html;charset=UTF-8" language="java" %>
</main>

<footer>
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <i class="fa-solid fa-graduation-cap fs-4 text-primary"></i>
                    <span class="fs-5 fw-bold text-white">Campus<span class="text-primary">Hire</span> AI</span>
                </div>
                <p class="small text-secondary mb-3">
                    A Java EE web platform connecting students with relevant career opportunities
                    through explainable, transparent 5-pillar skill matching algorithms.
                </p>
                <div class="d-flex gap-2">
                    <span class="badge bg-dark border border-secondary text-secondary">Java 17</span>
                    <span class="badge bg-dark border border-secondary text-secondary">Tomcat 9</span>
                    <span class="badge bg-dark border border-secondary text-secondary">MySQL 8</span>
                    <span class="badge bg-dark border border-secondary text-secondary">MVC + JDBC</span>
                </div>
            </div>

            <div class="col-lg-2 col-md-6">
                <h6 class="text-white fw-bold mb-3">For Students</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2 mb-0">
                    <li><a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/student/jobs">Job Match Engine</a></li>
                    <li><a href="${pageContext.request.contextPath}/student/applications">Application Status</a></li>
                    <li><a href="${pageContext.request.contextPath}/student/skill-gap">Skill Gap Roadmap</a></li>
                </ul>
            </div>

            <div class="col-lg-2 col-md-6">
                <h6 class="text-white fw-bold mb-3">For Recruiters</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2 mb-0">
                    <li><a href="${pageContext.request.contextPath}/recruiter/dashboard">Recruiter Portal</a></li>
                    <li><a href="${pageContext.request.contextPath}/recruiter/post-job">Post Opening</a></li>
                    <li><a href="${pageContext.request.contextPath}/recruiter/jobs">Manage Listings</a></li>
                    <li><a href="${pageContext.request.contextPath}/recruiter/applicants">Review Candidates</a></li>
                </ul>
            </div>

            <div class="col-lg-4 col-md-6">
                <h6 class="text-white fw-bold mb-3">5-Pillar Matching Formula</h6>
                <div class="small text-secondary mb-2">
                    Weighted Explainable Evaluation Criteria:
                </div>
                <div class="d-flex flex-wrap gap-2 small">
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle">Required Skills: 50%</span>
                    <span class="badge bg-info-subtle text-info border border-info-subtle">CGPA / Eligibility: 20%</span>
                    <span class="badge bg-warning-subtle text-warning border border-warning-subtle">Branch: 15%</span>
                    <span class="badge bg-success-subtle text-success border border-success-subtle">Certifications: 10%</span>
                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle">Projects: 5%</span>
                </div>
            </div>
        </div>

        <div class="border-top border-secondary border-opacity-25 mt-4 pt-3 d-flex flex-column flex-md-row justify-content-between align-items-center small text-secondary">
            
            <div class="mt-2 mt-md-0">
                Built with precision by <strong>Team:- CODE AVENGERS</strong> [Riddhi Sharma, Saloni Kumari, Sai Prasad Neelmani, Shubham Purohit, Toyeshh Somvansi].
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap 5.3 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- Chart.js for visualizations -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
