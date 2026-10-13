<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="500 Internal Server Error — CampusHire AI" scope="request" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-5 my-auto text-center">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="display-1 fw-extrabold text-warning mb-3">500</div>
            <h3 class="fw-bold text-dark mb-2">Unexpected Server Error</h3>
            <p class="text-secondary mb-4">
                The platform encountered an unexpected condition while processing your request. Please check database connectivity or contact the administrator.
            </p>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary-custom px-4">
                <i class="fa-solid fa-house me-2"></i> Return to Homepage
            </a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
