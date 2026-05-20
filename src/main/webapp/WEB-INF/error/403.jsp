<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    
    <jsp:include page="/utilities/navbar.jsp" />
<div class="admin-content">
        <h2 class="admin-title">Access Denied</h2>
        <p>You do not have permission to open this page.</p>
        <p><a class="btn-secondary" href="${pageContext.request.contextPath}/home">Go Home</a></p>
    </div>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
