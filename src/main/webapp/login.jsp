<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>

    <h2>Login</h2>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <label>Email or User ID:</label><br>
        <input type="text" name="identifier" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <button type="submit">Login</button>
    </form>

    <br>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register</a></p>

</body>
</html>