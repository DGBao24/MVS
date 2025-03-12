<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.Cinema" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Update Cinema</title>
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body>

<div class="container">
    <h2>Update Cinema</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <% 
        Cinema cinema = (Cinema) request.getAttribute("cinema"); 
        if (cinema != null) {
    %>
    <form action="CinemaManageController" method="POST">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="cinemaID" value="<%= cinema.getCinemaID() %>">

        <div class="mb-3">
            <label for="cinemaName" class="form-label">Cinema Name:</label>
            <input type="text" class="form-control" name="cinemaName" value="<%= cinema.getCinemaName() %>" required>
        </div>

        <div class="mb-3">
            <label for="address" class="form-label">Address:</label>
            <input type="text" class="form-control" name="address" value="<%= cinema.getAddress() %>" required>
        </div>

        <button type="submit" class="btn btn-primary">Update</button>
        <a href="CinemaManageController?action=list" class="btn btn-secondary">Cancel</a>
    </form>
    <% } else { %>
        <div class="alert alert-danger">Cinema not found!</div>
    <% } %>
</div>

</body>
</html>
