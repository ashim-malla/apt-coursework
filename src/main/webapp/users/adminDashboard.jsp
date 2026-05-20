<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <jsp:include page="/utilities/admin-navbar.jsp" />

    <!-- NAVBAR -->
    <nav class="navbar">
        <div class="nav-brand">🏍️ Pokhara Wheels</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users">Users</a>
            <a href="${pageContext.request.contextPath}/admin/bikes">Bikes</a>
            <a href="${pageContext.request.contextPath}/admin/bookings">Bookings</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-nav-login">Logout</a>
        </div>
    </nav>

    <div class="admin-content">

        <!-- WELCOME -->
        <div class="admin-welcome">
            <div>
                <h2>Welcome back, ${sessionScope.user.name} 👋</h2>
                <p>Here's what's happening at Pokhara Wheels today.</p>
            </div>
            <div class="admin-date" id="currentDate"></div>
        </div>

        <!-- STATS CARDS -->
        <div class="stats-grid">

            <div class="stat-card">
                <div class="stat-icon" style="background:#fff0f0; color:#cc0000;">👥</div>
                <div class="stat-info">
                    <p class="stat-label">Total Customers</p>
                    <p class="stat-value">${totalUsers}</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon" style="background:#fff8e1; color:#f57c00;">🏍️</div>
                <div class="stat-info">
                    <p class="stat-label">Total Bikes</p>
                    <p class="stat-value">${totalBikes}</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon" style="background:#f0fff4; color:#2e7d32;">📋</div>
                <div class="stat-info">
                    <p class="stat-label">Available Bikes</p>
                    <p class="stat-value">${availableBikes}</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon" style="background:#f0f4ff; color:#1a237e;">💰</div>
                <div class="stat-info">
                    <p class="stat-label">Total Revenue</p>
                    <p class="stat-value">Rs. 0</p>
                </div>
            </div>

        </div>

        <!-- QUICK ACTIONS -->
        <h3 class="section-heading">Quick Actions</h3>
        <div class="quick-actions">

            <a href="${pageContext.request.contextPath}/admin/users"
               class="action-card">
                <div class="action-icon">Users</div>
                <div class="action-info">
                    <h4>Manage Users</h4>
                    <p>View, edit, or change user roles</p>
                </div>
                <div class="action-arrow">→</div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/bikes"
               class="action-card">
                <div class="action-icon">🏍️</div>
                <div class="action-info">
                    <h4>Manage Bikes</h4>
                    <p>Add, edit or remove bikes</p>
                </div>
                <div class="action-arrow">→</div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/bookings"
               class="action-card">
                <div class="action-icon">📋</div>
                <div class="action-info">
                    <h4>Manage Bookings</h4>
                    <p>View and manage all bookings</p>
                </div>
                <div class="action-arrow">→</div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/users"
               class="action-card">
                <div class="action-icon">🔐</div>
                <div class="action-info">
                    <h4>Promote to Admin</h4>
                    <p>Change user roles and permissions</p>
                </div>
                <div class="action-arrow">→</div>
            </a>

        </div>

        <!-- RECENT USERS -->
        <h3 class="section-heading">Recent Users</h3>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Role</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty recentUsers}">
                        <tr>
                            <td colspan="6" style="text-align:center; color:#888;">
                                No users found
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="u" items="${recentUsers}">
                            <tr>
                                <td>${u.userId}</td>
                                <td>${u.name}</td>
                                <td>${u.email}</td>
                                <td>${u.phone}</td>
                                <td>
                                    <span class="badge badge-${u.role}">
                                        ${u.role}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-${u.accountStatus}">
                                        ${u.accountStatus}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

    </div>

    <script>
        // Show current date
        const date = new Date();
        document.getElementById('currentDate').textContent =
            date.toLocaleDateString('en-US', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
    </script>

</body>
</html>
