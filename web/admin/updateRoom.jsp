<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Room" %>
<%@page import="entity.Account" %>
<%
     Account user = (Account) session.getAttribute("account");
    if (user == null){
        response.sendRedirect("login.jsp");
        return;
    }if( !"Admin".equals(user.getRole()) && !"Manager".equals(user.getRole())) {
        response.sendRedirect("error.jsp");
        return;
    }
    Room room = (Room)request.getAttribute("room");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Room</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2>Update Room</h2>
            
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
            
            <form action="room" method="POST">
                <input type="hidden" name="service" value="updateRoom">
                <input type="hidden" name="submit" value="true">
                <input type="hidden" name="rid" value="<%= room.getRoomID() %>">
                
                <div class="mb-3">
                    <label class="form-label">Room ID:</label>
                    <input type="number" class="form-control" value="<%= room.getRoomID() %>" readonly>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Room Name:</label>
                    <input type="text" class="form-control" name="RoomName" value="<%= room.getRoomName() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Room Type:</label>
                    <input type="text" class="form-control" name="RoomType" value="<%= room.getRoomType() %>" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Update Room</button>
                <a href="room?service=listAll" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
        
        <jsp:include page="includes/footer.jsp" />
    </body>
</html>
