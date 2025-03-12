<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, entity.Combo" %>
<%
    List<Combo> list = (List)request.getAttribute("list");
    Combo combo = list.get(0);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Combo</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2>Update Combo</h2>
            <form action="combo" method="POST">
                <input type="hidden" name="service" value="updateCombo">
                <input type="hidden" name="submit" value="true">
                
                <div class="mb-3">
                    <label class="form-label">ComboID:</label>
                    <input type="number" class="form-control" name="ComboID" value="<%= combo.getComboID() %>" readonly>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Combo Item:</label>
                    <input type="text" class="form-control" name="ComboItem" value="<%= combo.getComboItem() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Description:</label>
                    <textarea class="form-control" name="Description" required><%= combo.getDescription() %></textarea>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Price:</label>
                    <input type="number" step="1000" min="0" class="form-control" name="Price" value="<%= combo.getPrice() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Quantity:</label>
                    <input type="number" min="0" class="form-control" name="Quantity" value="<%= combo.getQuantity() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Status:</label>
                    <select class="form-control" name="Status" required>
                        <option value="true" <%= combo.isStatus() ? "selected" : "" %>>Active</option>
                        <option value="false" <%= !combo.isStatus() ? "selected" : "" %>>Inactive</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-primary">Update Combo</button>
                <a href="combo?service=listAll" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
        
        <jsp:include page="includes/footer.jsp" />
    </body>
</html>
