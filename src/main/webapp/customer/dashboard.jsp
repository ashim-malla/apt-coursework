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
            <a class="hero-action" href="${pageContext.request.contextPath}/bikes">Browse Bikes</a>
        </section>

        <section class="customer-stats">
            <div class="customer-stat-card">
                <span>Available Bikes</span>
                <strong>${fn:length(availableBikes)}</strong>
            </div>
            <div class="customer-stat-card">
                <span>Active Bookings</span>
                <strong>${activeBookings}</strong>
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
                                <p class="bike-brand">${bike.brand} - ${bike.registrationNumber}</p>
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
                                    <span class="bike-status status-${booking.bookingStatus}">${booking.bookingStatus}</span>
                                </article>
                            </c:forEach>
                        </div>
                        <a class="text-link" href="${pageContext.request.contextPath}/customer/bookings">View all bookings</a>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="customer-panel" id="profile">
                <h2>Profile</h2>
                <div class="profile-list">
                    <p><span>Name</span><strong>${sessionScope.user.name}</strong></p>
                    <p><span>Email</span><strong>${sessionScope.user.email}</strong></p>
                    <p><span>Phone</span><strong>${sessionScope.user.phone}</strong></p>
                    <p><span>License</span><strong>${sessionScope.user.licenseNumber}</strong></p>
                </div>
            </div>
        </section>
    </main>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
