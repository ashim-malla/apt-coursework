<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="accountUrl" value="/customer/dashboard" />
<c:if test="${sessionScope.role == 'admin'}">
    <c:set var="accountUrl" value="/admin/dashboard" />
</c:if>
<c:if test="${sessionScope.role == 'staff'}">
    <c:set var="accountUrl" value="/staff/dashboard" />
</c:if>

<nav class="navbar">

    <a href="${pageContext.request.contextPath}/home" class="nav-brand-link">
        Pokhara Wheels
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/features.jsp">Features</a>

        <a href="${pageContext.request.contextPath}/bikes">Bikes</a>

        <a href="${pageContext.request.contextPath}/#about">About</a>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}${accountUrl}" class="account-chip">
                    <span class="account-icon">${fn:substring(sessionScope.user.name, 0, 1)}</span>
                    <span>${sessionScope.user.name}</span>
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="btn-nav-login">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="btn-nav-login">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="btn-nav-register">Register</a>
            </c:otherwise>
        </c:choose>
    </div>

</nav>
