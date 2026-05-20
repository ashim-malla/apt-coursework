<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Bikes - Pokhara Wheels</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <jsp:include page="/utilities/navbar.jsp" />

    <div class="admin-content">
        <h2 class="admin-title">Manage Bikes</h2>

        <c:if test="${not empty sessionScope.message}">
            <div class="success-message">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form class="admin-form" action="${pageContext.request.contextPath}/admin/bikes" method="post">
            <input type="hidden" name="action" value="${empty editBike ? 'add' : 'update'}">
            <input type="hidden" name="bikeId" value="${editBike.bikeId}">

            <div class="form-grid">
                <div class="form-group">
                    <label>Bike Name</label>
                    <input type="text" name="name" value="${editBike.name}" placeholder="Yamaha R15" required>
                </div>
                <div class="form-group">
                    <label>Brand</label>
                    <input type="text" name="brand" value="${editBike.brand}" placeholder="Yamaha" required>
                </div>
                <div class="form-group">
                    <label>Type</label>
                    <select name="type" required>
                        <option value="">Select type</option>
                        <option value="sport" ${editBike.type == 'sport' ? 'selected' : ''}>Sport</option>
                        <option value="cruiser" ${editBike.type == 'cruiser' ? 'selected' : ''}>Cruiser</option>
                        <option value="scooter" ${editBike.type == 'scooter' ? 'selected' : ''}>Scooter</option>
                        <option value="commuter" ${editBike.type == 'commuter' ? 'selected' : ''}>Commuter</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Registration Number</label>
                    <input type="text" name="registrationNumber" value="${editBike.registrationNumber}" placeholder="GAA-1234" required>
                </div>
                <div class="form-group">
                    <label>Price Per Day</label>
                    <input type="number" name="pricePerDay" value="${editBike.pricePerDay}" min="1" step="0.01" placeholder="1500" required>
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select name="status" required>
                        <option value="available" ${editBike.status == 'available' ? 'selected' : ''}>Available</option>
                        <option value="rented" ${editBike.status == 'rented' ? 'selected' : ''}>Rented</option>
                        <option value="maintenance" ${editBike.status == 'maintenance' ? 'selected' : ''}>Maintenance</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description" rows="3" placeholder="Short bike details">${editBike.description}</textarea>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-update">${empty editBike ? 'Add Bike' : 'Update Bike'}</button>
                <c:if test="${not empty editBike}">
                    <a class="btn-secondary" href="${pageContext.request.contextPath}/admin/bikes">Cancel Edit</a>
                </c:if>
            </div>
        </form>

        <h3 class="section-heading">Bike List</h3>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Brand</th>
                    <th>Type</th>
                    <th>Reg No.</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty bikes}">
                        <tr>
                            <td colspan="8" style="text-align:center; color:#888;">No bikes found</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="bike" items="${bikes}">
                            <tr>
                                <td>${bike.bikeId}</td>
                                <td>${bike.name}</td>
                                <td>${bike.brand}</td>
                                <td>${bike.type}</td>
                                <td>${bike.registrationNumber}</td>
                                <td>Rs. ${bike.pricePerDay}</td>
                                <td><span class="badge badge-${bike.status}">${bike.status}</span></td>
                                <td class="table-actions">
                                    <a class="btn-secondary" href="${pageContext.request.contextPath}/admin/bikes?editId=${bike.bikeId}">Edit</a>
                                    <form action="${pageContext.request.contextPath}/admin/bikes" method="post">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="bikeId" value="${bike.bikeId}">
                                        <button class="btn-delete" type="submit">Delete</button>
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
