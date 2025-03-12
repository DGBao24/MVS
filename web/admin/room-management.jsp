<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List, entity.Room, entity.Cinema, entity.Account" %>
<%
     Account user = (Account) session.getAttribute("account");
    if (user == null){
        response.sendRedirect("login.jsp");
        return;
    }if( !"Admin".equals(user.getRole()) && !"Manager".equals(user.getRole())) {
        response.sendRedirect("error.jsp");
        return;
    }
    List<Room> rooms = (List<Room>)request.getAttribute("Room");
    List<Cinema> cinemas = (List<Cinema>)request.getAttribute("Cinemas");
    String selectedCinemaId = request.getParameter("cinemaId");
%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Movie Ticket - Room Management</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="css/sb-admin-2.min.css" rel="stylesheet">
    </head>
    <body id="page-top">
        <!-- Page Wrapper -->
        <div id="wrapper">
            <!-- Include Sidebar -->
            <jsp:include page="sidebar.jsp"></jsp:include>

                <!-- Content Wrapper -->
                <div id="content-wrapper" class="d-flex flex-column">
                    <!-- Main Content -->
                    <div id="content">
                        <!-- Include Topbar -->
                        <jsp:include page="topbar.jsp"></jsp:include>

                        <div class="container-fluid">
                            <h1 class="h3 mb-4 text-gray-800">Room Management</h1>

                            <!-- Add New Room -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Add New Room</h6>
                                </div>
                                <div class="card-body">
                                    <form action="room" method="POST">
                                        <input type="hidden" name="service" value="insertRoom">
                                        <div class="form-group">
                                            <label>Cinema:</label>
                                            <select class="form-control" name="CinemaID" required>
                                                <option value="">Select Cinema</option>
                                                <% if(cinemas != null) { 
                                                    for(Cinema cinema : cinemas) { %>
                                                    <option value="<%= cinema.getCinemaID() %>">
                                                        <%= cinema.getCinemaName() %>
                                                    </option>
                                                <% } 
                                                } %>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Room Name:</label>
                                            <input type="text" class="form-control" name="RoomName" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Room Type:</label>
                                            <input type="text" class="form-control" name="RoomType" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Status:</label>
                                            <select class="form-control" name="Status" required>
                                                <option value="true">Active</option>
                                                <option value="false">Inactive</option>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Create Room</button>
                                    </form>
                                </div>
                            </div>

                            <!-- Room List -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Room List</h6>
                                </div>
                                <div class="card-body">
                                    <!-- Cinema Selection for List -->
                                    <form action="room" method="GET" id="cinemaForm" class="mb-4">
                                        <input type="hidden" name="service" value="listAll">
                                        <div class="form-group">
                                            <label>Filter by Cinema:</label>
                                            <select class="form-control" name="cinemaId" onchange="this.form.submit()">
                                                <option value="">All Cinemas</option>
                                                <% if(cinemas != null) { 
                                                    for(Cinema cinema : cinemas) { %>
                                                    <option value="<%= cinema.getCinemaID() %>" <%= (selectedCinemaId != null && selectedCinemaId.equals(String.valueOf(cinema.getCinemaID()))) ? "selected" : "" %>>
                                                        <%= cinema.getCinemaName() %>
                                                    </option>
                                                <% } 
                                                } %>
                                            </select>
                                        </div>
                                    </form>

                                    <% if(request.getAttribute("error") != null) { %>
                                    <div class="alert alert-danger">
                                        <%= request.getAttribute("error") %>
                                    </div>
                                    <% } %>
                                    <% if(request.getAttribute("success") != null) { %>
                                    <div class="alert alert-success">
                                        <%= request.getAttribute("success") %>
                                    </div>
                                    <% } %>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Room Name</th>
                                                <th>Room Type</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% if(rooms != null) { 
                                                for(Room room : rooms) { %>
                                                <tr>
                                                    <td><%= room.getRoomID() %></td>
                                                    <td><%= room.getRoomName() %></td>
                                                    <td><%= room.getRoomType() %></td>
                                                    <td><%= room.isStatus() ? "Active" : "Inactive" %></td>
                                                    <td>
                                                        <a href="room?service=updateRoom&rid=<%= room.getRoomID() %>" class="btn btn-primary btn-sm">Update</a>
                                                        <a href="room?service=DisableStatus&rid=<%= room.getRoomID() %>&cinemaId=<%= selectedCinemaId != null ? selectedCinemaId : "" %>" class="btn btn-warning btn-sm">
                                                            <%= room.isStatus() ? "Deactivate" : "Activate" %>
                                                        </a>
                                                        <a href="seat?service=ListAll&RoomID=<%=room.getRoomID()%>">View</a>
                                                    </td>
                                                </tr>
                                            <% }
                                            } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap core JavaScript-->
            <script src="vendor/jquery/jquery.min.js"></script>
            <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

            <!-- Core plugin JavaScript-->
            <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

            <!-- Custom scripts for all pages-->
            <script src="js/sb-admin-2.min.js"></script>
    </body>
</html>
