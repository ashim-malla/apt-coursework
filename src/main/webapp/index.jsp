<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Pokhara Wheels - Ride the City</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
</head>
<body>

    <!-- NAVBAR -->
    <nav class="navbar">
        <div class="nav-brand">
            🏍️ Pokhara Wheels
        </div>
        <div class="nav-links">
            <a href="#features">Features</a>
            <a href="#bikes">Our Bikes</a>
            <a href="#about">About</a>
            <a href="${pageContext.request.contextPath}/login" class="btn-nav-login">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-nav-register">Register</a>
        </div>
    </nav>

    <!-- HERO SECTION -->
    <section class="hero">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <h1>Ride the Streets of <span>Pokhara</span></h1>
            <p>Experience the thrill of premium superbikes. Rent by the hour, day, or week.</p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/register" class="btn-primary">Get Started</a>
                <a href="#bikes" class="btn-secondary">View Bikes</a>
            </div>
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
    <section class="bikes" id="bikes">
        <div class="section-title">
            <h2>Our Fleet</h2>
            <p>Pick your perfect ride</p>
        </div>
        <div class="bikes-grid">
            <div class="bike-card">
                <div class="bike-img">🏍️</div>
                <div class="bike-info">
                    <h3>Kawasaki Ninja</h3>
                    <p>Sport • 650cc</p>
                    <div class="bike-price">Rs. 2500<span>/day</span></div>
                    <a href="${pageContext.request.contextPath}/register" class="btn-book">Book Now</a>
                </div>
            </div>
            <div class="bike-card">
                <div class="bike-img">🏍️</div>
                <div class="bike-info">
                    <h3>Yamaha R15</h3>
                    <p>Sport • 155cc</p>
                    <div class="bike-price">Rs. 1500<span>/day</span></div>
                    <a href="${pageContext.request.contextPath}/register" class="btn-book">Book Now</a>
                </div>
            </div>
            <div class="bike-card">
                <div class="bike-img">🏍️</div>
                <div class="bike-info">
                    <h3>Royal Enfield</h3>
                    <p>Cruiser • 350cc</p>
                    <div class="bike-price">Rs. 2000<span>/day</span></div>
                    <a href="${pageContext.request.contextPath}/register" class="btn-book">Book Now</a>
                </div>
            </div>
            <div class="bike-card">
                <div class="bike-img">🏍️</div>
                <div class="bike-info">
                    <h3>KTM Duke</h3>
                    <p>Naked • 390cc</p>
                    <div class="bike-price">Rs. 2200<span>/day</span></div>
                    <a href="${pageContext.request.contextPath}/register" class="btn-book">Book Now</a>
                </div>
            </div>
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

    <!-- FOOTER -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-brand">
                🏍️ Pokhara Wheels
                <p>Ride the Streets of Pokhara</p>
            </div>
            <div class="footer-links">
                <a href="${pageContext.request.contextPath}/login">Login</a>
                <a href="${pageContext.request.contextPath}/register">Register</a>
                <a href="#about">About</a>
                <a href="#bikes">Bikes</a>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2024 Pokhara Wheels. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>