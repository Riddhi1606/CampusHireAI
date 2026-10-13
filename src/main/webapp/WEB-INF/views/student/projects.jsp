<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="My Projects Portfolio — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="card-custom p-4 mb-4">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2 mb-4 border-bottom pb-3">
                    <div>
                        <h4 class="fw-bold mb-1"><i class="fa-solid fa-laptop-code text-primary me-2"></i>Projects Portfolio</h4>
                        <div class="small text-secondary">Demonstrate practical software engineering skills to campus recruiters (5% weight)</div>
                    </div>
                    <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#addProjectModal">
                        <i class="fa-solid fa-plus me-1"></i> Add Project
                    </button>
                </div>

                <div class="row g-3">
                    <c:forEach var="proj" items="${projects}">
                        <div class="col-md-6">
                            <div class="card-custom h-100 p-4 border bg-white d-flex flex-column justify-content-between">
                                <div>
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h5 class="fw-bold text-dark mb-0">${proj.title}</h5>
                                        <form action="${pageContext.request.contextPath}/student/projects" method="post" onsubmit="return confirm('Delete project?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="projectId" value="${proj.id}">
                                            <button type="submit" class="btn btn-sm text-danger border-0 p-0">
                                                <i class="fa-regular fa-trash-can"></i>
                                            </button>
                                        </form>
                                    </div>
                                    <p class="small text-secondary mb-3">${proj.description}</p>
                                    <div class="mb-3">
                                        <span class="small fw-semibold text-muted d-block mb-1">Tech Stack:</span>
                                        <span class="badge bg-light text-dark border">${proj.techStack}</span>
                                    </div>
                                </div>

                                <div class="d-flex gap-2 border-top pt-3">
                                    <c:if test="${not empty proj.projectUrl}">
                                        <a href="${proj.projectUrl}" target="_blank" class="btn btn-sm btn-outline-primary">
                                            <i class="fa-solid fa-arrow-up-right-from-square me-1"></i> Live Demo
                                        </a>
                                    </c:if>
                                    <c:if test="${not empty proj.githubUrl}">
                                        <a href="${proj.githubUrl}" target="_blank" class="btn btn-sm btn-outline-dark">
                                            <i class="fa-brands fa-github me-1"></i> Repository
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty projects}">
                        <div class="col-12 text-center py-5 text-muted">
                            <i class="fa-solid fa-folder-open fs-1 mb-2 text-primary opacity-50 d-block"></i>
                            <h5>No projects added yet</h5>
                            <p class="small mb-3">Add web applications, mobile apps, or system utilities you have built.</p>
                            <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#addProjectModal">
                                <i class="fa-solid fa-plus me-1"></i> Add Your First Project
                            </button>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Project Modal -->
<div class="modal fade" id="addProjectModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content card-custom">
            <div class="modal-header border-bottom">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-laptop-code text-primary me-2"></i>Add Project to Portfolio</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/student/projects" method="post">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Project Title *</label>
                        <input type="text" class="form-control" name="title" placeholder="e.g. Distributed Task Queue / Campus Placement Portal" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Technology Stack *</label>
                        <input type="text" class="form-control" name="techStack" placeholder="e.g. Java 17, Spring Boot, MySQL, Docker, React" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Project Description</label>
                        <textarea class="form-control" name="description" rows="3" placeholder="Explain the problem solved, architectural approach, and key achievements"></textarea>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Live Project / Demo URL</label>
                            <input type="url" class="form-control" name="projectUrl" placeholder="https://myapp.vercel.app">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">GitHub Repository URL</label>
                            <input type="url" class="form-control" name="githubUrl" placeholder="https://github.com/username/repo">
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-top">
                    <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary-custom">Save Project</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
