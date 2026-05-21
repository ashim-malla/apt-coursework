<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Bike Rent History - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <jsp:include page="/utilities/navbar.jsp" />

    <div class="page-shell">
    <div class="admin-content">
        <h2 class="admin-title">Bike Rent History</h2>

        <c:if test="${not empty sessionScope.message}">
            <div class="success-message">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>

        <table class="admin-table">
            <thead>
                <tr>
                    <th>Booking</th>
                    <th>Customer</th>
                    <th>Bike</th>
                    <th>Dates</th>
                    <th>Total</th>
                    <th>Booking Status</th>
                    <th>Payment Status</th>
                    <th>Paid Date/Time</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty rentals}">
                        <tr>
                            <td colspan="8" style="text-align:center; color:#888;">No rental history found</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="r" items="${rentals}">
                            <tr>
                                <td>#${r.bookingId}</td>
                                <td>
                                    <strong>${r.customerName}</strong>
                                    <span class="table-subtext">${r.customerEmail}</span>
                                </td>
                                <td>
                                    <strong>${r.bikeName}</strong>
                                    <span class="table-subtext">${r.bikeBrand} - ${r.registrationNumber}</span>
                                </td>
                                <td>${r.startDate} to ${r.endDate}</td>
                                <td>Rs. ${r.totalAmount}</td>
                                <td><span class="badge badge-${r.bookingStatus}">${r.bookingStatus}</span></td>
                                <td><span class="badge badge-${r.paymentStatus}">${r.paymentStatus}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty r.paidAt}">${r.paidAt}</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    </div>

    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
