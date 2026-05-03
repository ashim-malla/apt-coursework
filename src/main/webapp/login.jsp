<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>

    <div class="auth-container">

        <div class="auth-header">
            <div class="bike-icon">🏍️</div>
            <h2>Welcome Back</h2>
            <p>Login to your Pokhara Wheels account</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="form-group">
                <label>Email or User ID</label>
                <input type="text" name="identifier" placeholder="Enter your email or user ID" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit" class="btn-auth">Login</button>

        </form>

        <hr class="divider">

        <div class="auth-link">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register">Register here</a>
        </div>

    </div>

</body>
</html>