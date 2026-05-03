<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>

<body>

    <h2>Register</h2>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <label>Name:</label><br>
        <input type="text" name="name" required><br><br>

        <label>Email:</label><br>
        <input type="email" name="email" required><br><br>

        <label>Phone:</label><br>
        <input type="text" name="phone" required><br><br>

        <label>License:</label><br>
        <input type="text" name="license_number"><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <button type="submit">Register</button>

    </form>

    <br>

    <c:if test="${not empty error}">
        <p style="color:red;">
            ${error}
        </p>
    </c:if>

</body>
</html>