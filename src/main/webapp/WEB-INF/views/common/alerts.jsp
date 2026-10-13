<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid px-lg-4 mt-3">
    <%-- Flash Success Message --%>
    <c:if test="${not empty sessionScope.flashSuccess}">
        <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm d-flex align-items-center rounded-3 mb-3" role="alert">
            <i class="fa-solid fa-circle-check fs-5 me-2 text-success"></i>
            <div>${sessionScope.flashSuccess}</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="flashSuccess" scope="session" />
    </c:if>

    <%-- Flash Error Message --%>
    <c:if test="${not empty sessionScope.flashError}">
        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm d-flex align-items-center rounded-3 mb-3" role="alert">
            <i class="fa-solid fa-triangle-exclamation fs-5 me-2 text-danger"></i>
            <div>${sessionScope.flashError}</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="flashError" scope="session" />
    </c:if>

    <%-- Request-level Error --%>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm d-flex align-items-center rounded-3 mb-3" role="alert">
            <i class="fa-solid fa-circle-xmark fs-5 me-2 text-danger"></i>
            <div>${errorMessage}</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <%-- URL Parameter Message --%>
    <c:if test="${not empty param.msg}">
        <div class="alert alert-info alert-dismissible fade show border-0 shadow-sm d-flex align-items-center rounded-3 mb-3" role="alert">
            <i class="fa-solid fa-circle-info fs-5 me-2 text-info"></i>
            <div>${param.msg}</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
</div>
