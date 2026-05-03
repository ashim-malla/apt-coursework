<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>

    <div class="auth-container">

        <div class="auth-header">
            <div class="bike-icon">🏍️</div>
            <h2>Create Account</h2>
            <p>Join us and start riding today</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="Enter your name" required>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone" placeholder="Enter your phone" required>
            </div>

            <div class="form-group">
                <label>License Number</label>
                <input type="text" name="license_number" placeholder="Enter license number (optional)">
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password"
                       placeholder="Min 6 chars, 1 uppercase, 1 number, 1 symbol" required>
            </div>

            <button type="submit" class="btn-auth">Register</button>

        </form>

        <hr class="divider">

        <div class="auth-link">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Login here</a>
        </div>

    </div>

</body>
</html>