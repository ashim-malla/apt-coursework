<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Users - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <jsp:include page="/utilities/navbar.jsp" />

    <div class="admin-content">
        <h2 class="admin-title">Manage Users</h2>

        <c:if test="${not empty sessionScope.message}">
            <div class="success-message">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>

        <h3 class="section-heading">Customers</h3>
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
                    <c:when test="${empty customerUsers}">
                        <tr>
                            <td colspan="7" style="text-align:center; color:#888;">
                                No customers found
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="u" items="${customerUsers}">
                            <tr>
                                <td>${u.userId}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/users?viewCustomerId=${u.userId}">
                                        ${u.name}
                                    </a>
                                </td>
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
                                    <form action="${pageContext.request.contextPath}/admin/users"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="userId" value="${u.userId}">
                                        <button type="submit" class="btn-delete">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <c:if test="${not empty selectedCustomerError}">
            <div class="error-message" style="margin-top:16px;">${selectedCustomerError}</div>
        </c:if>

        <c:if test="${not empty selectedCustomer}">
            <h3 class="section-heading">Customer Details</h3>
            <table class="admin-table">
                <tbody>
                    <tr>
                        <td><strong>ID</strong></td>
                        <td>${selectedCustomer.userId}</td>
                        <td><strong>Name</strong></td>
                        <td>${selectedCustomer.name}</td>
                    </tr>
                    <tr>
                        <td><strong>Email</strong></td>
                        <td>${selectedCustomer.email}</td>
                        <td><strong>Phone</strong></td>
                        <td>${selectedCustomer.phone}</td>
                    </tr>
                    <tr>
                        <td><strong>License No.</strong></td>
                        <td>${selectedCustomer.licenseNumber}</td>
                        <td><strong>Status</strong></td>
                        <td>
                            <span class="badge badge-${selectedCustomer.accountStatus}">
                                ${selectedCustomer.accountStatus}
                            </span>
                        </td>
                    </tr>
                </tbody>
            </table>

            <h3 class="section-heading">Booking History</h3>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Bike</th>
                        <th>Dates</th>
                        <th>Total</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty selectedCustomerBookings}">
                            <tr>
                                <td colspan="5" style="text-align:center; color:#888;">
                                    No bookings found for this customer
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${selectedCustomerBookings}">
                                <tr>
                                    <td>${b.bookingId}</td>
                                    <td>${b.bikeName} (${b.registrationNumber})</td>
                                    <td>${b.startDate} to ${b.endDate}</td>
                                    <td>Rs. ${b.totalAmount}</td>
                                    <td>
                                        <span class="badge badge-${b.bookingStatus}">
                                            ${b.bookingStatus}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </c:if>

        <h3 class="section-heading">Staffs</h3>
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
                    <c:when test="${empty staffUsers}">
                        <tr>
                            <td colspan="7" style="text-align:center; color:#888;">
                                No staffs found
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="u" items="${staffUsers}">
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
                                    <form action="${pageContext.request.contextPath}/admin/users"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="userId" value="${u.userId}">
                                        <button type="submit" class="btn-delete">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
