<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="User Governance — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-lg-4 py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-users-gear text-primary me-2"></i>User Accounts Governance</h3>
            <p class="text-secondary small mb-0">Oversee active students, campus recruiters, and security permissions.</p>
        </div>
        <span class="badge bg-primary fs-6 px-3 py-2 rounded-pill">${users.size()} Total Registered Users</span>
    </div>

    <div class="card-custom bg-white border overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-4">User ID & Name</th>
                        <th>Email Address</th>
                        <th>Platform Role</th>
                        <th>Status</th>
                        <th>Registered Date</th>
                        <th class="text-end pe-4">Account Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td class="ps-4">
                                <div class="fw-bold text-dark">${u.fullName}</div>
                                <div class="small text-muted">ID: #${u.id}</div>
                            </td>
                            <td>${u.email}</td>
                            <td>
                                <span class="badge bg-${u.role == 'STUDENT' ? 'primary' : (u.role == 'RECRUITER' ? 'info' : 'dark')} px-3 py-1 rounded-pill">
                                    ${u.role}
                                </span>
                            </td>
                            <td>
                                <span class="badge ${u.active ? 'bg-success' : 'bg-danger'} px-3 py-1 rounded-pill">
                                    ${u.active ? 'Active' : 'Deactivated'}
                                </span>
                            </td>
                            <td class="small text-secondary">
                                <fmt:formatDate value="${u.createdAt}" pattern="MMM dd, yyyy"/>
                            </td>
                            <td class="text-end pe-4">
                                <c:if test="${u.role != 'ADMIN'}">
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline">
                                        <input type="hidden" name="userId" value="${u.id}">
                                        <c:choose>
                                            <c:when test="${u.active}">
                                                <input type="hidden" name="action" value="deactivate">
                                                <button type="submit" class="btn btn-sm btn-outline-warning" title="Suspend User">
                                                    <i class="fa-solid fa-user-slash me-1"></i> Disable
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="action" value="activate">
                                                <button type="submit" class="btn btn-sm btn-outline-success" title="Enable User">
                                                    <i class="fa-solid fa-user-check me-1"></i> Enable
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>

                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline ms-1" onsubmit="return confirm('Permanently remove user #${u.id}?');">
                                        <input type="hidden" name="userId" value="${u.id}">
                                        <input type="hidden" name="action" value="delete">
                                        <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete User">
                                            <i class="fa-regular fa-trash-can"></i>
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${u.role == 'ADMIN'}">
                                    <span class="small text-muted fst-italic">Protected Root</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
