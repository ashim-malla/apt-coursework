<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Available Bikes - Pokhara Wheels</title>
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
                <p class="eyebrow">Bike Fleet</p>
                <h1>Available Bikes</h1>
                <p>All bikes shown here are currently available for customer rental.</p>
            </div>
            <div class="customer-stat-card compact">
                <span>Total Available</span>
                <strong>${fn:length(availableBikes)}</strong>
            </div>
        </section>

        <section class="customer-panel">
            <div class="panel-heading">
                <div>
                    <h2>Choose Your Bike</h2>
                    <p>Compare brand, type, registration number, and daily rental price.</p>
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
    </main>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
