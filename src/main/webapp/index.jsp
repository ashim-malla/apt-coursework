<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<%
    if (request.getAttribute("featuredBikes") == null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Pokhara Wheels - Ride the City</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
</head>
<body>
	<jsp:include page="/utilities/navbar.jsp" />
    <!-- HERO SECTION -->
	<section class="hero">
	
	    <img src="${pageContext.request.contextPath}/resources/image2.jpg"
	         alt="Pokhara Bikes"
	         class="hero-img">
	
	    <div class="hero-overlay">
	
	        <h1>Explore Pokhara on Two Wheels</h1>
	
	        <p>Rent premium bikes at the best price</p>
	
	        <a href="${pageContext.request.contextPath}/bikes"
	           class="hero-btn">
	            Book Now
	        </a>
	
	    </div>
	
	</section>
    <!-- FEATURES SECTION -->
    <section class="features" id="features">
        <div class="section-title">
            <h2>Why Choose Us?</h2>
            <p>Everything you need for the perfect ride</p>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">🏍️</div>
                <h3>Premium Bikes</h3>
                <p>Choose from our wide range of top-tier superbikes and cruisers.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">⚡</div>
                <h3>Instant Booking</h3>
                <p>Book your ride in minutes. No paperwork, no hassle.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🛡️</div>
                <h3>Fully Insured</h3>
                <p>All our bikes come with full insurance coverage for your safety.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📍</div>
                <h3>Pokhara Based</h3>
                <p>Conveniently located in the heart of Pokhara city.</p>
            </div>
        </div>
    </section>

    <!-- BIKES SECTION -->
    <section class="bikes" id="featured-bikes">
        <div class="section-title">
            <h2>Our Fleet</h2>
            <p>Pick your perfect ride</p>
        </div>
        <div class="bikes-grid">
            <c:choose>
                <c:when test="${empty featuredBikes}">
                    <div class="bike-empty">No bikes are available right now.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="bike" items="${featuredBikes}" varStatus="status">
                        <c:if test="${status.index < 4}">
                            <div class="bike-card">
                                <c:choose>
                                    <c:when test="${not empty bike.imagePath}">
                                        <img class="bike-img bike-photo" src="${pageContext.request.contextPath}/${bike.imagePath}" alt="${bike.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="bike-img">🏍️</div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="bike-info">
                                    <h3>${bike.name}</h3>
                                    <p>${bike.brand} • ${bike.type}</p>
                                    <div class="bike-price">Rs. ${bike.pricePerDay}<span>/day</span></div>
                                    <c:choose>
                                        <c:when test="${bike.status != 'available'}">
                                            <span class="btn-book-disabled">Unavailable</span>
                                        </c:when>
                                        <c:when test="${not empty sessionScope.user && sessionScope.role == 'customer'}">
                                            <a href="${pageContext.request.contextPath}/customer/book?bikeId=${bike.bikeId}" class="btn-book">Book Now</a>
                                        </c:when>
                                        <c:when test="${not empty sessionScope.user && sessionScope.role != 'customer'}">
                                            <span class="btn-book-disabled">Customers Only</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/login" class="btn-book">Book Now</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- ABOUT SECTION -->
    <section class="about" id="about">
        <div class="about-content">
            <div class="about-text">
                <h2>About Pokhara Wheels</h2>
                <p>We are Pokhara's premier bike rental service, offering a wide range of motorcycles for every type of rider. Whether you're exploring the lakeside or heading to the mountains, we have the perfect bike for your journey.</p>
                <p>Founded with a passion for riding, we ensure every customer gets a safe, reliable, and thrilling experience on the roads of Pokhara.</p>
                <a href="${pageContext.request.contextPath}/register" class="btn-primary">Join Us Today</a>
            </div>
            <div class="about-icon">🏔️🏍️</div>
        </div>
    </section>
    <jsp:include page="/utilities/footer.jsp" />

</body>
</html>
