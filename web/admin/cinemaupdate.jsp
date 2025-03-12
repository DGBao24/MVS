<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.Cinema" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Account" %>
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
    Cinema cinema = (Cinema) request.getAttribute("cinema");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Cinema</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2>Update Cinema</h2>
            
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${sessionScope.errorMessage}
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>
            
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success" role="alert">
                    ${sessionScope.successMessage}
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>
            
            <% if (cinema != null) { %>
            <form action="${pageContext.request.contextPath}/CinemaManageController" method="POST">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="cinemaID" value="<%= cinema.getCinemaID() %>">
                
                <div class="mb-3">
                    <label class="form-label">Cinema ID:</label>
                    <input type="number" class="form-control" value="<%= cinema.getCinemaID() %>" readonly>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Cinema Name:</label>
                    <input type="text" class="form-control" name="cinemaName" value="<%= cinema.getCinemaName() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Address:</label>
                    <input type="text" class="form-control" name="address" value="<%= cinema.getAddress() %>" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Update Cinema</button>
                <a href="${pageContext.request.contextPath}/CinemaManageController?action=list" class="btn btn-secondary">Cancel</a>
            </form>
            <% } else { %>
                <div class="alert alert-danger">Cinema not found!</div>
                <a href="${pageContext.request.contextPath}/CinemaManageController?action=list" class="btn btn-secondary">Back to List</a>
            <% } %>
        </div>
        
        <jsp:include page="includes/footer.jsp" />
    </body>
</html>
