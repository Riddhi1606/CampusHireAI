<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="My Technical Skills — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="card-custom p-4 mb-4">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2 mb-4 border-bottom pb-3">
                    <div>
                        <h4 class="fw-bold mb-1"><i class="fa-solid fa-code text-primary me-2"></i>My Technical Skills</h4>
                        <div class="small text-secondary">Skills directly drive 50% of your compatibility score for campus placement openings</div>
                    </div>
                    <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#addSkillModal">
                        <i class="fa-solid fa-plus me-1"></i> Add New Skill
                    </button>
                </div>

                <!-- Existing Skills List -->
                <div class="row g-3">
                    <c:forEach var="ss" items="${studentSkills}">
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="fw-bold mb-1 text-dark">${ss.skillName}</h6>
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="badge bg-secondary-subtle text-secondary small">${ss.skillCategory}</span>
                                        <c:choose>
                                            <c:when test="${ss.proficiency == 'ADVANCED'}">
                                                <span class="badge bg-success-subtle text-success border border-success-subtle">Advanced</span>
                                            </c:when>
                                            <c:when test="${ss.proficiency == 'INTERMEDIATE'}">
                                                <span class="badge bg-primary-subtle text-primary border border-primary-subtle">Intermediate</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning-subtle text-warning border border-warning-subtle">Beginner</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <form action="${pageContext.request.contextPath}/student/skills" method="post" onsubmit="return confirm('Remove ${ss.skillName} from your profile?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="skillId" value="${ss.skillId}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger border-0">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty studentSkills}">
                        <div class="col-12 text-center py-5 text-muted">
                            <i class="fa-solid fa-laptop-code fs-1 mb-2 text-primary opacity-50 d-block"></i>
                            <h5>No skills registered yet</h5>
                            <p class="small mb-3">Add programming languages, frameworks, databases, and cloud tools you are familiar with.</p>
                            <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#addSkillModal">
                                <i class="fa-solid fa-plus me-1"></i> Add Your First Skill
                            </button>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Skill Modal -->
<div class="modal fade" id="addSkillModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content card-custom">
            <div class="modal-header border-bottom">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-code text-primary me-2"></i>Add Skill to Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/student/skills" method="post">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Select Skill from Catalog *</label>
                        <select class="form-select" name="skillId" required>
                            <option value="">-- Choose a Skill --</option>
                            <c:forEach var="sk" items="${allSkills}">
                                <option value="${sk.id}">${sk.name} (${sk.category})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Proficiency Level</label>
                        <select class="form-select" name="proficiency">
                            <option value="INTERMEDIATE" selected>Intermediate (Working knowledge & projects)</option>
                            <option value="ADVANCED">Advanced (Production experience & deep fundamentals)</option>
                            <option value="BEGINNER">Beginner (Foundational learning / Academic coursework)</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer border-top">
                    <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary-custom">Add to Profile</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
