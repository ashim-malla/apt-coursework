<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Book Bike - Pokhara Wheels</title>
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
                <p class="eyebrow">Booking Request</p>
                <h1>Book ${bike.name}</h1>
                <p>Select your rental dates. Admin or staff can approve the request later.</p>
            </div>
        </section>

        <section class="customer-two-column">
            <article class="customer-bike-card booking-bike-summary">
                <c:if test="${not empty bike.imagePath}">
                    <img class="customer-bike-photo large" src="${pageContext.request.contextPath}/${bike.imagePath}" alt="${bike.name}">
                </c:if>
                <div class="bike-card-top">
                    <span class="bike-type">${bike.type}</span>
                    <span class="bike-status status-${bike.status}">${bike.status}</span>
                </div>
                <h3>${bike.name}</h3>
                <p class="bike-brand">${bike.brand}</p>
                <p class="bike-description">${bike.description}</p>
                <div class="bike-card-bottom">
                    <div>
                        <span class="price-label">Per day</span>
                        <strong>Rs. ${bike.pricePerDay}</strong>
                    </div>
                </div>
            </article>

            <section class="customer-panel">
                <h2>Rental Details</h2>

                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>

                <c:choose>
                    <c:when test="${canBook}">
                        <form action="${pageContext.request.contextPath}/customer/book" method="post" class="booking-form">
                            <input type="hidden" name="bikeId" value="${bike.bikeId}">

                            <div class="form-group">
                                <label>Start Date</label>
                                <input type="date" name="startDate" required>
                            </div>

                            <div class="form-group">
                                <label>End Date</label>
                                <input type="date" name="endDate" required>
                            </div>

                            <button type="submit" class="hero-action">Submit Booking Request</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="booking-empty">
                            <strong>Log in to continue</strong>
                            <p>Customers can choose dates and send a booking request from here.</p>
                        </div>
                        <div class="form-actions">
                            <a class="hero-action" href="${pageContext.request.contextPath}/login">Log In</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </section>
    </main>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
