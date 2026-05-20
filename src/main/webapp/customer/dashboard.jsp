<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
</head>
<body>
    <jsp:include page="/utilities/navbar.jsp" />

    <main class="customer-shell">
        <section class="customer-hero">
            <div>
                <p class="eyebrow">Customer Dashboard</p>
                <h1>Ready for your next ride, ${sessionScope.user.name}?</h1>
                <p>Find available bikes, review your profile, and track your rental activity from one place.</p>
            </div>
            <div class="form-actions">
                <a class="hero-action" href="${pageContext.request.contextPath}/bikes">Browse Bikes</a>
                <a class="btn-secondary profile-toggle-btn ${showProfile ? 'profile-toggle-active' : ''}" href="${pageContext.request.contextPath}/customer/dashboard?showProfile=true&currentShowProfile=${showProfile}&toggleProfile=true#profile">
                    <c:choose>
                        <c:when test="${showProfile}">Hide Personal Info</c:when>
                        <c:otherwise>Personal Info</c:otherwise>
                    </c:choose>
                </a>
            </div>
        </section>

        <section class="customer-stats">
            <div class="customer-stat-card">
                <span>Available Bikes</span>
                <strong>${fn:length(availableBikes)}</strong>
            </div>
            <div class="customer-stat-card">
                <span>Booked Bikes</span>
                <strong>${bookedBikes}</strong>
            </div>
            <div class="customer-stat-card">
                <span>Pending Requests</span>
                <strong>${pendingRequests}</strong>
            </div>
        </section>

        <c:if test="${not empty sessionScope.message}">
            <div class="success-message">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>

        <section class="customer-panel" id="booked-bikes">
            <div class="panel-heading">
                <div>
                    <h2>My Booked Bikes</h2>
                    <p>These bikes are confirmed and approved by admin or staff.</p>
                </div>
            </div>

            <div class="booked-bike-grid">
                <c:choose>
                    <c:when test="${empty bookedBikeBookings}">
                        <div class="customer-empty">No booked bikes yet. Approved bookings will appear here.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="booking" items="${bookedBikeBookings}">
                            <article class="booked-bike-card">
                                <div class="booked-bike-content">
                                    <span class="bike-status status-approved">Booked</span>
                                    <h3>${booking.bikeName}</h3>
                                    <p>${booking.bikeBrand}</p>
                                    <div class="booked-bike-meta">
                                        <span>${booking.startDate} to ${booking.endDate}</span>
                                        <strong>Rs. ${booking.totalAmount}</strong>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <section class="customer-panel" id="available-bikes">
            <div class="panel-heading">
                <div>
                    <h2>Available Bikes</h2>
                    <p>Choose a bike that matches your route and budget.</p>
                </div>
                <div class="search-box">
                    <input type="text" placeholder="Search by bike, brand, or type">
                    <button type="button">Search</button>
                </div>
            </div>

            <div class="customer-bike-grid">
                <c:choose>
                    <c:when test="${empty availableBikes}">
                        <div class="customer-empty">No bikes are available right now.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="bike" items="${availableBikes}">
                            <article class="customer-bike-card">
                                <c:if test="${not empty bike.imagePath}">
                                    <img class="customer-bike-photo" src="${pageContext.request.contextPath}/${bike.imagePath}" alt="${bike.name}">
                                </c:if>
                                <div class="bike-card-top">
                                    <span class="bike-type">${bike.type}</span>
                                    <span class="bike-status">${bike.status}</span>
                                </div>
                                <h3>${bike.name}</h3>
                                <p class="bike-brand">${bike.brand}</p>
                                <p class="bike-description">${bike.description}</p>
                                <div class="bike-card-bottom">
                                    <div>
                                        <span class="price-label">Per day</span>
                                        <strong>Rs. ${bike.pricePerDay}</strong>
                                    </div>
                                    <c:choose>
                                        <c:when test="${sessionScope.role == 'customer'}">
                                            <a class="book-link" href="${pageContext.request.contextPath}/customer/book?bikeId=${bike.bikeId}">Book</a>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn-disabled" disabled>Customers Only</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </article>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <section class="customer-two-column">
            <div class="customer-panel" id="my-bookings">
                <h2>My Bookings</h2>
                <c:choose>
                    <c:when test="${empty bookings}">
                        <div class="booking-empty">
                            <strong>No bookings yet</strong>
                            <p>Your bike rental requests will appear here after you book a bike.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="booking-list compact">
                            <c:forEach var="booking" items="${bookings}">
                                <article class="booking-card">
                                    <div>
                                        <h3>${booking.bikeName}</h3>
                                        <p>${booking.startDate} to ${booking.endDate}</p>
                                    </div>
                                    <span class="bike-status status-${booking.bookingStatus}">
                                        <c:choose>
                                            <c:when test="${booking.bookingStatus == 'approved'}">Booked</c:when>
                                            <c:when test="${booking.bookingStatus == 'pending'}">Pending</c:when>
                                            <c:when test="${booking.bookingStatus == 'rejected'}">Rejected</c:when>
                                            <c:when test="${booking.bookingStatus == 'completed'}">Completed</c:when>
                                            <c:when test="${booking.bookingStatus == 'cancelled'}">Cancelled</c:when>
                                            <c:otherwise>${booking.bookingStatus}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </article>
                            </c:forEach>
                        </div>
                        <a class="text-link" href="${pageContext.request.contextPath}/customer/bookings">View all bookings</a>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:if test="${showProfile}">
            <div class="customer-panel profile-panel" id="profile">
                <h2>Profile</h2>
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
                                <a class="btn-secondary" href="${pageContext.request.contextPath}/customer/dashboard?showProfile=true#profile">Cancel</a>
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
                            <a class="btn-update" href="${pageContext.request.contextPath}/customer/dashboard?showProfile=true&editProfile=true#profile">Edit Info</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            </c:if>
        </section>
    </main>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
