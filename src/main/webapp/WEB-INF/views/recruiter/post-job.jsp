<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="${job != null ? 'Edit Job Opening' : 'Post New Job Opening'} — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card-custom p-4 p-md-5">
                <div class="mb-4 border-bottom pb-3">
                    <h3 class="fw-bold mb-1">
                        <i class="fa-solid fa-file-circle-plus text-primary me-2"></i>
                        ${job != null ? 'Edit Job Posting' : 'Publish New Campus Job Opening'}
                    </h3>
                    <p class="text-secondary small mb-0">Define role expectations, academic criteria, and weighted skill requirements.</p>
                </div>

                <form action="${pageContext.request.contextPath}/recruiter/post-job" method="post">
                    <c:if test="${job != null}">
                        <input type="hidden" name="jobId" value="${job.id}">
                    </c:if>

                    <!-- Role Basics -->
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-briefcase text-primary me-2"></i>Role Specification</h5>
                    <div class="row g-3 mb-3">
                        <div class="col-md-8">
                            <label class="form-label small fw-semibold">Position Title *</label>
                            <input type="text" class="form-control" name="title" value="${job.title}" placeholder="e.g. Software Development Engineer (SDE-1)" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-semibold">Department / Business Unit</label>
                            <input type="text" class="form-control" name="department" value="${job.department}" placeholder="e.g. Cloud Engineering">
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-4">
                            <label class="form-label small fw-semibold">Job Type</label>
                            <select class="form-select" name="jobType">
                                <option value="FULL_TIME" ${job.jobType == 'FULL_TIME' ? 'selected' : ''}>Full-Time Placement</option>
                                <option value="INTERNSHIP" ${job.jobType == 'INTERNSHIP' ? 'selected' : ''}>Internship</option>
                                <option value="PART_TIME" ${job.jobType == 'PART_TIME' ? 'selected' : ''}>Part-Time</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-semibold">Location</label>
                            <input type="text" class="form-control" name="location" value="${job.location != null ? job.location : 'Bengaluru / Hyderabad'}" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-semibold">Compensation Package / Stipend</label>
                            <input type="text" class="form-control" name="packageLpa" value="${job.packageLpa}" placeholder="e.g. 14.0 - 18.0 LPA or 45,000 / mo" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label small fw-semibold">Detailed Job Description & Requirements *</label>
                        <textarea class="form-control" name="description" rows="5" placeholder="Detail candidate responsibilities, day-to-day work, engineering team scope, and expectations..." required>${job.description}</textarea>
                    </div>

                    <!-- Eligibility Criteria -->
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-filter text-info me-2"></i>Academic Eligibility Cutoffs</h5>
                    <div class="row g-3 mb-4">
                        <div class="col-md-4">
                            <label class="form-label small fw-semibold">Minimum CGPA Cutoff</label>
                            <input type="number" step="0.01" min="0" max="10" class="form-control" name="minCgpa" value="${job != null ? job.minCgpa : 7.00}" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-semibold">Eligible Branches / Disciplines</label>
                            <input type="text" class="form-control" name="eligibleBranches" value="${job.eligibleBranches != null ? job.eligibleBranches : 'Computer Science and Engineering, Information Technology'}" placeholder="e.g. Computer Science, Information Technology, All">
                        </div>
                        <div class="col-md-2">
                            <label class="form-label small fw-semibold">Openings</label>
                            <input type="number" min="1" class="form-control" name="openings" value="${job != null ? job.openings : 5}" required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label small fw-semibold">Deadline</label>
                            <input type="date" class="form-control" name="deadline" value="${job.deadline}">
                        </div>
                    </div>

                    <!-- Skill Requirements -->
                    <h5 class="fw-bold text-dark mb-2"><i class="fa-solid fa-code text-primary me-2"></i>Configure Skill Match Rules</h5>
                    <p class="small text-secondary mb-3">Mandatory skills carry higher weight in the matching algorithm, while Preferred skills provide candidate bonus scores.</p>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <div class="card-custom p-3 bg-light border">
                                <h6 class="fw-bold text-primary mb-2"><i class="fa-solid fa-asterisk text-danger me-1"></i> Mandatory Skills</h6>
                                <div class="overflow-auto p-2 bg-white rounded border" style="max-height: 220px;">
                                    <c:forEach var="sk" items="${allSkills}">
                                        <div class="form-check mb-1">
                                            <input class="form-check-input" type="checkbox" name="mandatorySkills" value="${sk.id}" id="m_${sk.id}" ${mandatorySkillIds.contains(sk.id) ? 'checked' : ''}>
                                            <label class="form-check-label small" for="m_${sk.id}">
                                                ${sk.name} <span class="text-muted">(${sk.category})</span>
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="card-custom p-3 bg-light border">
                                <h6 class="fw-bold text-info mb-2"><i class="fa-solid fa-star text-warning me-1"></i> Preferred Skills</h6>
                                <div class="overflow-auto p-2 bg-white rounded border" style="max-height: 220px;">
                                    <c:forEach var="sk" items="${allSkills}">
                                        <div class="form-check mb-1">
                                            <input class="form-check-input" type="checkbox" name="preferredSkills" value="${sk.id}" id="p_${sk.id}" ${preferredSkillIds.contains(sk.id) ? 'checked' : ''}>
                                            <label class="form-check-label small" for="p_${sk.id}">
                                                ${sk.name} <span class="text-muted">(${sk.category})</span>
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 border-top pt-3">
                        <a href="${pageContext.request.contextPath}/recruiter/jobs" class="btn btn-outline-custom">Cancel</a>
                        <button type="submit" class="btn btn-primary-custom px-4">
                            <i class="fa-solid fa-check me-2"></i> ${job != null ? 'Update Posting' : 'Publish Opening'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
