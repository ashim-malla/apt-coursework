<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Features - Pokhara Wheels</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/features.css">
</head>

<body>

<!-- NAVBAR -->
<jsp:include page="/utilities/navbar.jsp" />

<!-- FEATURES SECTION -->
<section class="features">

    <!-- TITLE -->
    <div class="section-title">
        <h2>Why Choose Us?</h2>
        <p>Everything you need for the perfect ride</p>
    </div>

    <!-- INTRO TEXT -->
    <div class="features-intro">

        <p>
            We make bike rental in Pokhara simple, fast, and reliable. From instant booking to flexible rental plans,
            everything is designed to give you a smooth experience. Ride premium bikes, explore freely, and enjoy
            every moment of your journey with complete peace of mind.
        </p>

        <p>
            Every ride is backed by well-maintained motorcycles that ensure safety, comfort, and performance on every road.
            Whether you’re exploring lakeside routes, city streets, or nearby hills, our bikes are ready for your adventure.
        </p>

        <p>
            With Pokhara Wheels, you don’t just rent a bike — you get freedom, convenience, and a better way to explore the city.
        </p>

    </div>

    <!-- FEATURE CARDS -->
    <div class="features-grid">

        <div class="feature-card">
            <img src="${pageContext.request.contextPath}/resources/premiumbike.jpg" class="feature-img" alt="Premium Bikes">
            <div class="feature-icon">🏍️</div>
            <h3>Premium Bikes</h3>
            <p>Our premium bikes are carefully maintained to deliver the perfect combination of performance, comfort,
            and style. Whether you're riding through the streets of Pokhara or exploring nearby hills, 
            every bike is designed to give you a smooth, safe, and unforgettable riding experience.</p>
        </div>

        <div class="feature-card">
            <img src="${pageContext.request.contextPath}/resources/bikebooking.jpg" class="feature-img" alt="Instant Booking">
            <div class="feature-icon">⚡</div>
            <h3>Instant Booking</h3>
            <p>Our instant booking system makes renting a bike quick and hassle-free. Choose your preferred bike, confirm your 
            booking in minutes, and get ready to ride without complicated paperwork or long waiting times.</p>
        </div>

        <div class="feature-card">
            <img src="${pageContext.request.contextPath}/resources/bikepricing.jpg" class="feature-img" alt="Affordable Pricing">
            <div class="feature-icon">💰</div>
            <h3>Affordable Pricing</h3>
            <p>We offer affordable and transparent pricing with no hidden charges. Enjoy premium bikes at competitive 
            rental rates, giving you the best value for your adventure in Pokhara.
			</p>
        </div>

        <div class="feature-card">
            <img src="${pageContext.request.contextPath}/resources/insurance.jpg" class="feature-img" alt="Safe & Secure">
            <div class="feature-icon">🛡️</div>
            <h3>Safe & Secure</h3>
            <p>All our bikes are regularly inspected, fully insured, and maintained to the highest safety standards. Ride with confidence
             knowing your journey is protected, secure, and designed for complete peace of mind.</p>
        </div>

    </div>

</section>

</body>
</html>