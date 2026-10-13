<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="${job.title} — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-4">
    <div class="row g-4">
        <!-- Main Job Description -->
        <div class="col-lg-7">
            <div class="card-custom p-4 mb-4">
                <div class="d-flex align-items-center gap-2 mb-2">
                    <span class="badge bg-light text-dark border">${job.companyName}</span>
                    <span class="badge bg-primary-subtle text-primary">${job.jobType}</span>
                    <span class="badge bg-secondary-subtle text-secondary">${job.department}</span>
                </div>
                <h3 class="fw-bold text-dark mb-2">${job.title}</h3>
                <div class="d-flex flex-wrap gap-3 text-secondary small mb-4">
                    <span><i class="fa-solid fa-location-dot text-primary me-1"></i> ${job.location}</span>
                    <span><i class="fa-solid fa-money-bill-wave text-success me-1"></i> ${job.packageLpa}</span>
                    <span><i class="fa-regular fa-calendar-check text-warning me-1"></i> Deadline: <fmt:formatDate value="${job.deadline}" pattern="MMM dd, yyyy"/></span>
                </div>

                <hr class="my-4">

                <h5 class="fw-bold mb-3"><i class="fa-solid fa-file-lines text-primary me-2"></i>Job Description & Responsibilities</h5>
                <div class="text-secondary mb-4 lh-base" style="white-space: pre-line;">
                    ${job.description}
                </div>

                <h5 class="fw-bold mb-3"><i class="fa-solid fa-sliders text-info me-2"></i>Eligibility Requirements</h5>
                <div class="row g-2 mb-4">
                    <div class="col-sm-6">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="small text-muted">Minimum CGPA Cutoff</div>
                            <div class="fw-bold text-dark">${job.minCgpa} / 10.0</div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="small text-muted">Eligible Disciplines / Branches</div>
                            <div class="fw-bold text-dark">${job.eligibleBranches}</div>
                        </div>
                    </div>
                </div>

                <h5 class="fw-bold mb-3"><i class="fa-solid fa-tags text-primary me-2"></i>Required & Preferred Tech Skills</h5>
                <div class="d-flex flex-wrap gap-2 mb-4">
                    <c:forEach var="js" items="${job.requiredSkills}">
                        <span class="badge p-2 ${js.mandatory ? 'bg-primary-subtle text-primary border border-primary-subtle' : 'bg-light text-dark border'}">
                            <i class="fa-solid ${js.mandatory ? 'fa-asterisk' : 'fa-circle-check'} me-1"></i>
                            ${js.skillName} (${js.mandatory ? 'Mandatory' : 'Preferred'})
                        </span>
                    </c:forEach>
                </div>

                <!-- Application Submission Form Section -->
                <div id="applySection" class="border-top pt-4">
                    <c:choose>
                        <c:when test="${hasApplied}">
                            <div class="alert alert-success d-flex align-items-center mb-0 rounded-3">
                                <i class="fa-solid fa-circle-check fs-4 me-3"></i>
                                <div>
                                    <h6 class="fw-bold mb-0">Application Already Submitted</h6>
                                    <div class="small">You have applied for this position. Track the recruitment status in <a href="${pageContext.request.contextPath}/student/applications" class="fw-bold text-success text-decoration-underline">My Applications</a>.</div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h5 class="fw-bold mb-3"><i class="fa-solid fa-paper-plane text-primary me-2"></i>Submit Your Application</h5>
                            <form action="${pageContext.request.contextPath}/student/apply" method="post">
                                <input type="hidden" name="jobId" value="${job.id}">
                                <div class="mb-3">
                                    <label class="form-label small fw-semibold">Cover Note / Expression of Interest</label>
                                    <textarea class="form-control" name="coverLetter" rows="4" placeholder="Highlight why your skills and portfolio projects make you a strong fit for this opening..."></textarea>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="small text-muted">Your calculated score (<strong><fmt:formatNumber value="${matchResult.overallScore}" maxFractionDigits="1"/>%</strong>) will be forwarded with your profile.</span>
                                    <button type="submit" class="btn btn-primary-custom px-4">
                                        <i class="fa-solid fa-check me-2"></i> Submit Application
                                    </button>
                                </div>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Right Column: Transparent Explainable Match Breakdown -->
        <div class="col-lg-5">
            <div class="card-custom p-4 mb-4 border-top border-4 border-${matchResult.badgeColor}">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div>
                        <span class="badge bg-secondary-subtle text-secondary px-2 py-1 rounded-pill small mb-1">Explainable AI</span>
                        <h5 class="fw-bold mb-0">Match Score Breakdown</h5>
                    </div>
                    <div class="text-end">
                        <span class="match-score-badge match-${matchResult.badgeColor} fs-5">
                            <fmt:formatNumber value="${matchResult.overallScore}" maxFractionDigits="1"/>%
                        </span>
                        <div class="small fw-bold text-${matchResult.badgeColor} mt-1">${matchResult.matchCategory}</div>
                    </div>
                </div>

                <!-- Eligibility Verdict -->
                <div class="p-3 bg-light rounded-3 mb-4 border">
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <i class="fa-solid ${matchResult.eligible ? 'fa-circle-check text-success' : 'fa-circle-xmark text-danger'}"></i>
                        <span class="fw-bold small ${matchResult.eligible ? 'text-success' : 'text-danger'}">
                            ${matchResult.eligible ? 'Fully Eligible' : 'Eligibility Notice'}
                        </span>
                    </div>
                    <div class="small text-secondary">${matchResult.eligibilityReason}</div>
                </div>

                <!-- 5 Criteria Progress Bars -->
                <div class="mb-4 d-flex flex-column gap-3">
                    <!-- 1. Skills -->
                    <div>
                        <div class="d-flex justify-content-between small fw-bold mb-1">
                            <span><i class="fa-solid fa-code text-primary me-1"></i> Required Skills (50% max)</span>
                            <span class="text-primary"><fmt:formatNumber value="${matchResult.skillScore}" maxFractionDigits="1"/> / 50.0</span>
                        </div>
                        <div class="score-progress-bar">
                            <div class="score-progress-fill bg-primary" style="width: ${matchResult.skillPercentage}%;"></div>
                        </div>
                    </div>

                    <!-- 2. CGPA -->
                    <div>
                        <div class="d-flex justify-content-between small fw-bold mb-1">
                            <span><i class="fa-solid fa-graduation-cap text-info me-1"></i> CGPA Eligibility (20% max)</span>
                            <span class="text-info"><fmt:formatNumber value="${matchResult.cgpaScore}" maxFractionDigits="1"/> / 20.0</span>
                        </div>
                        <div class="score-progress-bar">
                            <div class="score-progress-fill bg-info" style="width: ${matchResult.cgpaPercentage}%;"></div>
                        </div>
                    </div>

                    <!-- 3. Branch -->
                    <div>
                        <div class="d-flex justify-content-between small fw-bold mb-1">
                            <span><i class="fa-solid fa-sitemap text-warning me-1"></i> Branch Alignment (15% max)</span>
                            <span class="text-warning"><fmt:formatNumber value="${matchResult.branchScore}" maxFractionDigits="1"/> / 15.0</span>
                        </div>
                        <div class="score-progress-bar">
                            <div class="score-progress-fill bg-warning" style="width: ${matchResult.branchPercentage}%;"></div>
                        </div>
                    </div>

                    <!-- 4. Certifications -->
                    <div>
                        <div class="d-flex justify-content-between small fw-bold mb-1">
                            <span><i class="fa-solid fa-certificate text-success me-1"></i> Certifications (10% max)</span>
                            <span class="text-success"><fmt:formatNumber value="${matchResult.certScore}" maxFractionDigits="1"/> / 10.0</span>
                        </div>
                        <div class="score-progress-bar">
                            <div class="score-progress-fill bg-success" style="width: ${matchResult.certPercentage}%;"></div>
                        </div>
                    </div>

                    <!-- 5. Projects -->
                    <div>
                        <div class="d-flex justify-content-between small fw-bold mb-1">
                            <span><i class="fa-solid fa-folder-open text-danger me-1"></i> Projects Relevance (5% max)</span>
                            <span class="text-danger"><fmt:formatNumber value="${matchResult.projectScore}" maxFractionDigits="1"/> / 5.0</span>
                        </div>
                        <div class="score-progress-bar">
                            <div class="score-progress-fill bg-danger" style="width: ${matchResult.projectPercentage}%;"></div>
                        </div>
                    </div>
                </div>

                <!-- Matched Skills Checklist -->
                <div class="mb-3">
                    <div class="small fw-bold text-success mb-2"><i class="fa-solid fa-circle-check me-1"></i> Verified Matching Skills (${matchResult.matchedSkills.size()}):</div>
                    <div class="d-flex flex-wrap gap-1">
                        <c:forEach var="m" items="${matchResult.matchedSkills}">
                            <span class="skill-pill skill-pill-matched">${m}</span>
                        </c:forEach>
                        <c:if test="${empty matchResult.matchedSkills}">
                            <span class="small text-muted fst-italic">No overlapping skills registered</span>
                        </c:if>
                    </div>
                </div>

                <!-- Missing Skills Alert -->
                <c:if test="${not empty matchResult.missingSkills}">
                    <div class="mb-4">
                        <div class="small fw-bold text-danger mb-2"><i class="fa-solid fa-circle-exclamation me-1"></i> Missing / Recommended Skills (${matchResult.missingSkills.size()}):</div>
                        <div class="d-flex flex-wrap gap-1">
                            <c:forEach var="mis" items="${matchResult.missingSkills}">
                                <span class="skill-pill skill-pill-missing">${mis}</span>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <!-- Actionable Guidance Box -->
                <div class="p-3 bg-primary-subtle text-primary border border-primary-subtle rounded-3 small">
                    <div class="fw-bold mb-1"><i class="fa-solid fa-lightbulb me-1"></i> Recommendation:</div>
                    <div>${matchResult.advice}</div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
