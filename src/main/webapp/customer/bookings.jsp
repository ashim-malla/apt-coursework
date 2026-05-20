<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
</head>
<body>
    <jsp:include page="/utilities/navbar.jsp" />

    <main class="customer-shell">
        <section class="customer-page-heading">
            <div>
                <p class="eyebrow">Rental History</p>
                <h1>My Bookings</h1>
                <p>Track your pending, approved, completed, or cancelled bike rental requests.</p>
            </div>
            <a class="hero-action" href="${pageContext.request.contextPath}/bikes">Book Another Bike</a>
        </section>

        <c:if test="${not empty sessionScope.message}">
            <div class="success-message">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>

        <section class="customer-panel">
            <div class="booking-list">
                <c:choose>
                    <c:when test="${empty bookings}">
                        <div class="customer-empty">You have not made any bookings yet.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="booking" items="${bookings}">
                            <article class="booking-card">
                                <div>
                                    <h3>${booking.bikeName}</h3>
                                    <p>${booking.bikeBrand} - ${booking.registrationNumber}</p>
                                </div>
                                <div>
                                    <span class="price-label">Rental Dates</span>
                                    <strong>${booking.startDate} to ${booking.endDate}</strong>
                                </div>
                                <div>
                                    <span class="price-label">Total</span>
                                    <strong>Rs. ${booking.totalAmount}</strong>
                                </div>
                                <span class="bike-status status-${booking.bookingStatus}">${booking.bookingStatus}</span>
                            </article>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
