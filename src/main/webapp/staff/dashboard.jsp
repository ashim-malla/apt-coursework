<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    
    <jsp:include page="/utilities/navbar.jsp" />

    <div class="admin-content">
        <div class="admin-welcome">
            <div>
                <h2>Staff Dashboard</h2>
                <p>Track fleet availability and prepare rentals for customers.</p>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">B</div>
                <div class="stat-info">
                    <p class="stat-label">Total Bikes</p>
                    <p class="stat-value">${totalBikes}</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">A</div>
                <div class="stat-info">
                    <p class="stat-label">Available Bikes</p>
                    <p class="stat-value">${availableBikes}</p>
                </div>
            </div>
        </div>

        <h3 class="section-heading">Staff Tasks To Build Next</h3>
        <div class="quick-actions">
            <a class="action-card" href="${pageContext.request.contextPath}/staff/bookings">
                <div class="action-icon">1</div>
                <div class="action-info">
                    <h4>Manage Bookings</h4>
                    <p>Approve, reject, complete, or cancel customer booking requests.</p>
                </div>
            </a>
            <div class="action-card">
                <div class="action-icon">2</div>
                <div class="action-info">
                    <h4>Manage Bikes</h4>
                    <p>Edit bike details, availability, and uploaded bike photos.</p>
                </div>
                <a class="text-link" href="${pageContext.request.contextPath}/staff/bikes">Open bikes</a>
            </div>
        </div>
    </div>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
