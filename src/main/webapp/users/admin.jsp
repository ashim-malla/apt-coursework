<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Users - Pokhara Wheels</title>
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
            <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/bikes">Manage Bikes</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-nav-login">Logout</a>
        </div>
    </nav>

    <div class="admin-content">
        <h2 class="admin-title">Manage Users</h2>

        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty users}">
                        <tr>
                            <td colspan="7" style="text-align:center; color:#888;">
                                No users found
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="u" items="${users}">
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
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/users"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${u.userId}">
                                        <select name="role" class="role-select">
                                            <option value="customer"
                                                ${u.role == 'customer' ? 'selected' : ''}>
                                                Customer
                                            </option>
                                            <option value="staff"
                                                ${u.role == 'staff' ? 'selected' : ''}>
                                                Staff
                                            </option>
                                            <option value="admin"
                                                ${u.role == 'admin' ? 'selected' : ''}>
                                                Admin
                                            </option>
                                        </select>
                                        <select name="accountStatus" class="role-select">
                                            <option value="pending"
                                                ${u.accountStatus == 'pending' ? 'selected' : ''}>
                                                Pending
                                            </option>
                                            <option value="active"
                                                ${u.accountStatus == 'active' ? 'selected' : ''}>
                                                Active
                                            </option>
                                            <option value="suspended"
                                                ${u.accountStatus == 'suspended' ? 'selected' : ''}>
                                                Suspended
                                            </option>
                                        </select>
                                        <button type="submit" class="btn-update">Update</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

</body>
</html>
