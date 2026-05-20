<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="uri" value="${pageContext.request.requestURI}" />

<nav class="dashboard-navbar">
    <a class="dashboard-brand" href="${pageContext.request.contextPath}/customer/dashboard">
        <span class="brand-mark">PW</span>
        <span>Pokhara Wheels</span>
    </a>

    <div class="dashboard-nav-links">
        <a class="${fn:contains(uri, '/customer/dashboard') ? 'nav-link-active' : ''}"
           href="${pageContext.request.contextPath}/customer/dashboard">Dashboard</a>
        <a class="${fn:contains(uri, '/bikes') ? 'nav-link-active' : ''}"
           href="${pageContext.request.contextPath}/bikes">Bikes</a>
        <a class="${fn:contains(uri, '/customer/bookings') ? 'nav-link-active' : ''}"
           href="${pageContext.request.contextPath}/customer/bookings">My Bookings</a>
        <a href="${pageContext.request.contextPath}/customer/dashboard#profile">Profile</a>
    </div>

    <div class="dashboard-nav-user">
        <span>${sessionScope.user.name}</span>
        <a href="${pageContext.request.contextPath}/logout" class="btn-nav-login">Logout</a>
    </div>
</nav>
