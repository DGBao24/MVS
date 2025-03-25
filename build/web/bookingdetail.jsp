<%-- 
    Document   : bookingdetail
    Created on : Mar 26, 2025, 2:32:22 AM
    Author     : pdatt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Details</title>
        <link rel="stylesheet" type="text/css" href="path/to/your/styles.css">
    </head>
    <body>
        <h1>Booking Details</h1>
        
        <h2>Tickets</h2>
        <table border="1" class="booking-table">
            <tr>
                <th>Ticket ID</th>
                <th>Seat Row</th>
                <th>Seat Number</th>
                <th>Seat Type</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Room Name</th>
                <th>Room Type</th>
                <th>Movie Name</th>
                <th>Duration</th>
            </tr>
            <%
                ResultSet ticketDetails = (ResultSet) request.getAttribute("ticketDetails");
                try {
                    if (ticketDetails != null) {
                        while (ticketDetails.next()) {
            %>
            <tr>
                <td><%= ticketDetails.getInt("TicketID") %></td>
                <td><%= ticketDetails.getString("SeatRow") %></td>
                <td><%= ticketDetails.getInt("SeatNumber") %></td>
                <td><%= ticketDetails.getString("SeatType") %></td>
                <td><%= ticketDetails.getTimestamp("StartTime") %></td>
                <td><%= ticketDetails.getTimestamp("EndTime") %></td>
                <td><%= ticketDetails.getString("RoomName") %></td>
                <td><%= ticketDetails.getString("RoomType") %></td>
                <td><%= ticketDetails.getString("MovieName") %></td>
                <td><%= ticketDetails.getInt("Duration") %></td>
            </tr>
            <%
                        }
                    } else {
                        out.println("<tr><td colspan='10'>No ticket details available.</td></tr>");
                    }
                } catch (SQLException e) {
                    out.println("Error retrieving ticket details: " + e.getMessage());
                }
            %>
        </table>

        <h2>Combos</h2>
        <table border="1" class="combo-table">
            <tr>
                <th>Combo Item</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
            <%
                ResultSet comboDetails = (ResultSet) request.getAttribute("comboDetails");
                try {
                    if (comboDetails != null) {
                        while (comboDetails.next()) {
            %>
            <tr>
                <td><%= comboDetails.getString("ComboItem") %></td>
                <td><%= comboDetails.getInt("Quantity") %></td>
                <td><%= comboDetails.getFloat("Price") %></td>
            </tr>
            <%
                        }
                    } else {
                        out.println("<tr><td colspan='3'>No combo details available.</td></tr>");
                    }
                } catch (SQLException e) {
                    out.println("Error retrieving combo details: " + e.getMessage());
                }
            %>
        </table>
    </body>
</html>
