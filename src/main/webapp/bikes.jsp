<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Bikes - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
</head>
<body>
    <jsp:include page="/utilities/navbar.jsp" />

    <main class="customer-shell">
        <section class="customer-page-heading">
            <div>
                <p class="eyebrow">Our Fleet</p>
                <h1>All Bikes</h1>
                <p>Browse every bike registered in Pokhara Wheels, including available, rented, and maintenance bikes.</p>
            </div>
            <div class="customer-stat-card compact">
                <span>Total Bikes</span>
                <strong>${fn:length(bikes)}</strong>
            </div>
        </section>

        <section class="customer-panel">
            <div class="panel-heading">
                <div>
                    <h2>Bike Collection</h2>
                    <p>Check the bike type, brand, price, and current status before booking.</p>
                </div>
                <div class="search-box">
                    <input type="text" placeholder="Search by bike, brand, or type">
                    <button type="button">Search</button>
                </div>
            </div>

            <div class="customer-bike-grid">
                <c:choose>
                    <c:when test="${empty bikes}">
                        <div class="customer-empty">No bikes have been added yet.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="bike" items="${bikes}">
                            <article class="customer-bike-card">
                                <div class="bike-card-top">
                                    <span class="bike-type">${bike.type}</span>
                                    <span class="bike-status status-${bike.status}">${bike.status}</span>
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
                                        <c:when test="${bike.status == 'available'}">
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.user && sessionScope.role == 'customer'}">
                                                    <a class="book-link" href="${pageContext.request.contextPath}/customer/book?bikeId=${bike.bikeId}">Book</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a class="book-link" href="${pageContext.request.contextPath}/login">Book</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn-disabled" disabled>Unavailable</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </article>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>
</body>
</html>
