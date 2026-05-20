<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Server Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    
    <jsp:include page="/utilities/navbar.jsp" />
<div class="admin-content">
        <h2 class="admin-title">Server Error</h2>
        <p>Something went wrong. Please try again later.</p>
        <p><a class="btn-secondary" href="${pageContext.request.contextPath}/home">Go Home</a></p>
    </div>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
