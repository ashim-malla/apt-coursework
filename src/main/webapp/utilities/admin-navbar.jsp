<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="uri" value="${pageContext.request.requestURI}" />

<nav class="dashboard-navbar">
    <a class="dashboard-brand" href="${pageContext.request.contextPath}/admin/dashboard">
        <span class="brand-mark">PW</span>
        <span>Pokhara Wheels</span>
    </a>

    <div class="dashboard-nav-links">
        <a class="${fn:contains(uri, '/admin/dashboard') ? 'nav-link-active' : ''}"
           href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a class="${fn:contains(uri, '/admin/users') ? 'nav-link-active' : ''}"
           href="${pageContext.request.contextPath}/admin/users">Users</a>
        <a class="${fn:contains(uri, '/admin/bikes') ? 'nav-link-active' : ''}"
           href="${pageContext.request.contextPath}/admin/bikes">Bikes</a>
    </div>

    <div class="dashboard-nav-user">
        <span>${sessionScope.user.name}</span>
        <a href="${pageContext.request.contextPath}/logout" class="btn-nav-login">Logout</a>
    </div>
</nav>
