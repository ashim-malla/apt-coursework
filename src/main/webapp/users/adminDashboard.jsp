<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <jsp:include page="/utilities/navbar.jsp" />

    <div class="admin-content">
        <c:if test="${not empty sessionScope.message}">
            <div class="success-message">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>

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
                    <p class="stat-label">Total Bookings</p>
                    <p class="stat-value">${totalBookings}</p>
                </div>
            </div>

        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon" style="background:#fff8e1; color:#f57c00;">P</div>
                <div class="stat-info">
                    <p class="stat-label">Pending Bookings</p>
                    <p class="stat-value">${pendingBookings}</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon" style="background:#f0fff4; color:#2e7d32;">Rs</div>
                <div class="stat-info">
                    <p class="stat-label">Revenue</p>
                    <p class="stat-value">Rs. ${totalRevenue}</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon" style="background:#f0fff4; color:#2e7d32;">Paid</div>
                <div class="stat-info">
                    <p class="stat-label">Paid Payments</p>
                    <p class="stat-value">${paidPayments}</p>
                </div>
            </div>
        </div>

        <!-- QUICK ACTIONS -->
        <h3 class="section-heading">Quick Actions</h3>
        <div class="quick-actions">

            <a href="${pageContext.request.contextPath}/admin/users"
               class="action-card">
                <div class="action-icon">U</div>
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
            <a href="${pageContext.request.contextPath}/admin/bookings?history=true"
               class="action-card">
                <div class="action-icon">H</div>
                <div class="action-info">
                    <h4>Bike Rent History</h4>
                    <p>Open the full rental history page.</p>
                </div>
                <div class="action-arrow">â†’</div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/dashboard#recent-payments"
               class="action-card">
                <div class="action-icon">Rs</div>
                <div class="action-info">
                    <h4>Payment History</h4>
                    <p>View payment amount, status, and paid date/time.</p>
                </div>
                <div class="action-arrow">â†’</div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/dashboard?showProfile=true&currentShowProfile=${showProfile}&toggleProfile=true#profile"
               class="${showProfile ? 'action-card action-card-active' : 'action-card'}">
                <div class="action-icon">Info</div>
                <div class="action-info">
                    <h4><c:choose><c:when test="${showProfile}">Hide Personal Info</c:when><c:otherwise>Personal Info</c:otherwise></c:choose></h4>
                    <p>View and edit your profile details.</p>
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

        <h3 class="section-heading" id="recent-payments" style="margin-top:26px;">Recent Payments</h3>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Booking</th>
                    <th>Customer</th>
                    <th>Bike</th>
                    <th>Amount</th>
                    <th>Method</th>
                    <th>Status</th>
                    <th>Paid Date/Time</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty recentPayments}">
                        <tr>
                            <td colspan="7" style="text-align:center; color:#888;">No payment records found</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="p" items="${recentPayments}">
                            <tr>
                                <td>#${p.bookingId}</td>
                                <td>
                                    <strong>${p.customerName}</strong>
                                    <span class="table-subtext">${p.customerEmail}</span>
                                </td>
                                <td>
                                    <strong>${p.bikeName}</strong>
                                    <span class="table-subtext">${p.registrationNumber}</span>
                                </td>
                                <td>Rs. ${p.paymentAmount}</td>
                                <td>${p.paymentMethod}</td>
                                <td><span class="badge badge-${p.paymentStatus}">${p.paymentStatus}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.paidAt}">${p.paidAt}</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <c:if test="${showProfile}">
        <section class="customer-panel profile-panel" id="profile" style="margin-top:24px;">
            <h3 class="section-heading">Profile</h3>
            <c:choose>
                <c:when test="${editProfile}">
                    <form class="admin-form" action="${pageContext.request.contextPath}/account/profile" method="post">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" name="name" value="${sessionScope.user.name}" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" value="${sessionScope.user.email}" required>
                            </div>
                            <div class="form-group">
                                <label>Phone</label>
                                <input type="text" name="phone" value="${sessionScope.user.phone}" required>
                            </div>
                            <div class="form-group">
                                <label>License Number</label>
                                <input type="text" name="licenseNumber" value="${sessionScope.user.licenseNumber}" required>
                            </div>
                            <div class="form-group">
                                <label>New Password (optional)</label>
                                <input type="password" name="newPassword" placeholder="Leave blank to keep current password">
                            </div>
                            <div class="form-group">
                                <label>Confirm New Password</label>
                                <input type="password" name="confirmPassword" placeholder="Retype new password">
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn-update">Save Changes</button>
                            <a class="btn-secondary" href="${pageContext.request.contextPath}/admin/dashboard?showProfile=true#profile">Cancel</a>
                        </div>
                    </form>
                </c:when>
                <c:otherwise>
                    <div class="profile-list">
                        <p><span>Name</span><strong>${sessionScope.user.name}</strong></p>
                        <p><span>Email</span><strong>${sessionScope.user.email}</strong></p>
                        <p><span>Phone</span><strong>${sessionScope.user.phone}</strong></p>
                        <p><span>License</span><strong>${sessionScope.user.licenseNumber}</strong></p>
                    </div>
                    <div class="form-actions">
                        <a class="btn-update" href="${pageContext.request.contextPath}/admin/dashboard?showProfile=true&editProfile=true#profile">Edit Info</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
        </c:if>

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

    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
