<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List, entity.Seat, entity.Room, entity.Account" %>
<%
     Account user = (Account) session.getAttribute("account");
    if (user == null){
        response.sendRedirect("login.jsp");
        return;
    }if( !"Admin".equals(user.getRole()) && !"Manager".equals(user.getRole())) {
        response.sendRedirect("error.jsp");
        return;
    }
    List<Seat> seats = (List)request.getAttribute("Seats");
    List<Room> rooms = (List)request.getAttribute("Rooms");
    String selectedRoomId = request.getParameter("RoomID");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Movie Ticket - Seat Management</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="css/sb-admin-2.min.css" rel="stylesheet">
    </head>
    <body id="page-top">
        <div id="wrapper">
            <jsp:include page="sidebar.jsp"></jsp:include>
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <jsp:include page="topbar.jsp"></jsp:include>
                    <div class="container-fluid">
                        <h1 class="h3 mb-4 text-gray-800">Seat Management</h1>

                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Add New Seat</h6>
                            </div>
                            <div class="card-body">
                                <form action="seat" method="POST">
                                    <input type="hidden" name="service" value="insertSeat">
                                    <div class="form-group">
                                        <label>Room:</label>
                                        <select class="form-control" name="RoomID" required>
                                            <option value="">Select Room</option>
                                            <% if(rooms != null) { 
                                                for(Room room : rooms) { %>
                                                <option value="<%= room.getRoomID() %>">
                                                    <%= room.getRoomName() %>
                                                </option>
                                            <% } 
                                            } %>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Seat Row:</label>
                                        <input type="text" class="form-control" name="SeatRow" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Seat Number:</label>
                                        <input type="number" class="form-control" name="SeatNumber" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Seat Type:</label>
                                        <select class="form-control" name="SeatType" required>
                                            <option value="VIP">VIP</option>
                                            <option value="Standard">Standard</option>
                                           
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Status:</label>
                                        <select class="form-control" name="Status" required>
                                            <option value="Available">Available</option>
                                            <option value="Reserved">Reserved</option>
                                            <option value="Sold">Sold</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Create Seat</button>
                                </form>
                            </div>
                        </div>

                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Seat List</h6>
                            </div>
                            <div class="card-body">
                                <form action="seat" method="GET" id="roomForm" class="mb-4">
                                    <input type="hidden" name="service" value="listAll">
                                    <div class="form-group">
                                        <label>Filter by Room:</label>
                                        <select class="form-control" name="RoomID" onchange="this.form.submit()">
                                            <option value="">All Rooms</option>
                                            <% if(rooms != null) { 
                                                for(Room room : rooms) { %>
                                                <option value="<%= room.getRoomID( ) %>" <%= (selectedRoomId != null && selectedRoomId.equals(String.valueOf(room.getRoomID()))) ? "selected" : "" %>>
                                                    <%= room.getRoomName() %>
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
                                            <th>Seat Row</th>
                                            <th>Seat Number</th>
                                            <th>Seat Type</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if(seats != null) { 
                                            for(Seat seat : seats) { %>
                                            <tr>
                                                <td><%= seat.getSeatID() %></td>
                                                <td><%= seat.getSeatRow() %></td>
                                                <td><%= seat.getSeatNumber() %></td>
                                                <td><%= seat.getSeatType() %></td>
                                                <td><%= seat.getStatus() %></td>
                                                <td>
                                                    <a href="seat?service=updateSeat&sid=<%= seat.getSeatID() %>" class="btn btn-primary btn-sm">Update</a>
                                                    
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
            <script src="vendor/jquery/jquery.min.js"></script>
            <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
            <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
            <script src="js/sb-admin-2.min.js"></script>
    </body>
</html>
