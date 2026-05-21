<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
    <div class="page-shell">
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
                    <th>Payment</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty bookings}">
                        <tr>
                            <td colspan="8" style="text-align:center; color:#888;">No bookings found</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:set var="visibleBookingCount" value="0" />
                        <c:forEach var="booking" items="${bookings}">
                            <c:set var="visibleBookingCount" value="${visibleBookingCount + 1}" />
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
                                    <span class="badge badge-${booking.paymentStatus}">
                                        ${booking.paymentStatus}
                                    </span>
                                    <span class="table-subtext">Rs. ${booking.totalAmount}</span>
                                    <c:if test="${booking.paymentStatus == 'paid' && not empty booking.paidAt}">
                                        <span class="table-subtext">${booking.paidAt}</span>
                                    </c:if>
                                </td>
                                <td>
                                    <form class="booking-status-form" action="${bookingActionPath}" method="post">
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
                                    <c:if test="${booking.paymentStatus != 'paid'}">
                                        <form class="booking-status-form" action="${bookingActionPath}" method="post">
                                            <input type="hidden" name="action" value="markPaid">
                                            <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                            <button type="submit" class="btn-secondary">Mark Paid</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${visibleBookingCount == 0}">
                            <tr>
                                <td colspan="8" style="text-align:center; color:#888;">No active bookings found</td>
                            </tr>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    </div>
    <jsp:include page="/utilities/footer.jsp" />
</body>
</html>
