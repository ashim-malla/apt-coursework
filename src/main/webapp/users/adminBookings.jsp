<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Bookings - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <jsp:include page="/utilities/navbar.jsp" />

    <div class="admin-content">
        <h2 class="admin-title">Manage Bookings</h2>

        <c:if test="${not empty sessionScope.message}">
            <div class="success-message">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>

        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Customer</th>
                    <th>Bike</th>
                    <th>Dates</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty bookings}">
                        <tr>
                            <td colspan="7" style="text-align:center; color:#888;">No bookings found</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="booking" items="${bookings}">
                            <tr>
                                <td>${booking.bookingId}</td>
                                <td>
                                    <strong>${booking.customerName}</strong>
                                    <span class="table-subtext">${booking.customerEmail}</span>
                                </td>
                                <td>
                                    <strong>${booking.bikeName}</strong>
                                    <span class="table-subtext">${booking.bikeBrand} - ${booking.registrationNumber}</span>
                                </td>
                                <td>${booking.startDate} to ${booking.endDate}</td>
                                <td>Rs. ${booking.totalAmount}</td>
                                <td>
                                    <span class="badge badge-${booking.bookingStatus}">
                                        ${booking.bookingStatus}
                                    </span>
                                </td>
                                <td>
                                    <form class="booking-status-form" action="${pageContext.request.requestURI}" method="post">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <select name="bookingStatus" class="role-select">
                                            <option value="pending" ${booking.bookingStatus == 'pending' ? 'selected' : ''}>Pending</option>
                                            <option value="approved" ${booking.bookingStatus == 'approved' ? 'selected' : ''}>Approved</option>
                                            <option value="rejected" ${booking.bookingStatus == 'rejected' ? 'selected' : ''}>Rejected</option>
                                            <option value="completed" ${booking.bookingStatus == 'completed' ? 'selected' : ''}>Completed</option>
                                            <option value="cancelled" ${booking.bookingStatus == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                        </select>
                                        <button type="submit" class="btn-update">Update</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
