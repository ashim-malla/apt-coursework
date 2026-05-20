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
        <c:if test="${not empty sessionScope.message}">
            <div class="success-message">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>

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
            <a class="${showProfile ? 'action-card action-card-active' : 'action-card'}" href="${pageContext.request.contextPath}/staff/dashboard?showProfile=true&currentShowProfile=${showProfile}&toggleProfile=true#profile">
                <div class="action-icon">3</div>
                <div class="action-info">
                    <h4><c:choose><c:when test="${showProfile}">Hide Personal Info</c:when><c:otherwise>Personal Info</c:otherwise></c:choose></h4>
                    <p>View and edit your profile details.</p>
                </div>
            </a>
        </div>

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
                            <a class="btn-secondary" href="${pageContext.request.contextPath}/staff/dashboard?showProfile=true#profile">Cancel</a>
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
                        <a class="btn-update" href="${pageContext.request.contextPath}/staff/dashboard?showProfile=true&editProfile=true#profile">Edit Info</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
        </c:if>
    </div>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
