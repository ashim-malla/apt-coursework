<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">Pokhara Wheels</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-nav-login">Logout</a>
        </div>
    </nav>

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
            <div class="action-card">
                <div class="action-icon">1</div>
                <div class="action-info">
                    <h4>Confirm Handover</h4>
                    <p>Mark approved bookings as handed over to customers.</p>
                </div>
            </div>
            <div class="action-card">
                <div class="action-icon">2</div>
                <div class="action-info">
                    <h4>Confirm Return</h4>
                    <p>Update bike condition and availability after return.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
