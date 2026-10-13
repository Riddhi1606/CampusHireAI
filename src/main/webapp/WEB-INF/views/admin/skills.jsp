<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Skills Catalog Taxonomy — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-4">
    <div class="row g-4">
        <!-- Add Skill Form -->
        <div class="col-lg-4">
            <div class="card-custom p-4 bg-white border">
                <h5 class="fw-bold mb-3"><i class="fa-solid fa-plus-circle text-primary me-2"></i>Add Skill to Taxonomy</h5>
                <form action="${pageContext.request.contextPath}/admin/skills" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Skill / Technology Name *</label>
                        <input type="text" class="form-control" name="name" placeholder="e.g. GraphQL, Kotlin, Terraform" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Domain Category</label>
                        <select class="form-select" name="category">
                            <option value="Programming">Programming</option>
                            <option value="Framework">Framework</option>
                            <option value="Database">Database</option>
                            <option value="DevOps & Cloud">DevOps & Cloud</option>
                            <option value="Web Development">Web Development</option>
                            <option value="Data Science & AI">Data Science & AI</option>
                            <option value="Tools">Tools</option>
                            <option value="Architecture">Architecture</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary-custom w-100">
                        <i class="fa-solid fa-check me-1"></i> Register Master Skill
                    </button>
                </form>
            </div>
        </div>

        <!-- Master Skills Catalog Table -->
        <div class="col-lg-8">
            <div class="card-custom p-4 bg-white border">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0"><i class="fa-solid fa-tags text-primary me-2"></i>Master Skills Catalog (${skills.size()})</h5>
                    <span class="badge bg-light text-muted border">Global Matching Dictionary</span>
                </div>

                <div class="table-responsive" style="max-height: 540px;">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light sticky-top">
                            <tr>
                                <th class="ps-3">Skill ID</th>
                                <th>Skill Name</th>
                                <th>Category</th>
                                <th class="text-end pe-3">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="sk" items="${skills}">
                                <tr>
                                    <td class="ps-3 text-muted small">#${sk.id}</td>
                                    <td class="fw-bold text-dark">${sk.name}</td>
                                    <td><span class="badge bg-secondary-subtle text-secondary">${sk.category}</span></td>
                                    <td class="text-end pe-3">
                                        <form action="${pageContext.request.contextPath}/admin/skills" method="post" class="d-inline" onsubmit="return confirm('Delete skill ${sk.name}?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="skillId" value="${sk.id}">
                                            <button type="submit" class="btn btn-sm text-danger border-0">
                                                <i class="fa-regular fa-trash-can"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
