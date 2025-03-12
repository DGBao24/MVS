<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Seat,entity.Account" %>
<%
    Account user = (Account) session.getAttribute("account");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (!"Admin".equals(user.getRole()) && !"Manager".equals(user.getRole())) {
        response.sendRedirect("error.jsp");
        return;
    }
    Seat seat = (Seat) request.getAttribute("seat");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Seat</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2>Update Seat</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                    ${success}
                </div>
            </c:if>

            <form action="seat" method="POST">
                <input type="hidden" name="service" value="updateSeat">
                <input type="hidden" name="submit" value="true">
                <input type="hidden" name="sid" value="<%= seat.getSeatID() %>">

                <div class="mb-3">
                    <label class="form-label">Seat ID:</label>
                    <input type="number" class="form-control" value="<%= seat.getSeatID() %>" readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Seat Type:</label>
                    
                    <select class="form-control" name="SeatType" required>
                        <option value="VIP" <%= "VIP".equals(seat.getSeatType()) ? "selected" : "" %>>VIP</option>
                        <option value="Standard" <%= "Standard".equals(seat.getSeatType()) ? "selected" : "" %>>Standard</option>
                        
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Status:</label>
                    <select class="form-control" name="Status" required>
                        <option value="Available" <%= "Available".equals(seat.getStatus()) ? "selected" : "" %>>Available</option>
                        <option value="Reserved" <%= "Reserved".equals(seat.getStatus()) ? "selected" : "" %>>Reserved</option>
                        <option value="Sold" <%= "Sold".equals(seat.getStatus()) ? "selected" : "" %>>Sold</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Update Seat</button>
                <a href="seat?service=listAll" class="btn btn-secondary">Cancel</a>
            </form>
        </div>

        <jsp:include page="includes/footer.jsp" />
    </body>
</html>
