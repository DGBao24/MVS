<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Ticket,entity.Showtime,entity.Movie" %>

<!DOCTYPE html>
<html>
<head>
    <title>Xác Nhận Đặt Vé</title>
</head>
<body>
    <h2>Thông Tin Vé Đặt Thành Công</h2>

    <%
        Ticket ticket = (Ticket) request.getAttribute("ticket");
        Showtime show = (Showtime) request.getAttribute("showtime");
        Movie movie = (Movie) request.getAttribute("movie");
        
        if (ticket != null) {
    %>
        <p><strong>Mã Vé:</strong> <%= ticket.getTicketID() %></p>
        <p><strong>Mã Ghế:</strong> <%= ticket.getSeatID() %></p>
        <p><strong>Mã Suất Chiếu:</strong> <%= ticket.getShowTimeID() %></p>
        <p><strong>Mã Combo:</strong> <%= ticket.getComboID() == 0 ? "Không chọn" : ticket.getComboID() %></p>
        
    <%
        } else {
    %>
        <p style="color:red;">Lỗi: Không tìm thấy thông tin vé!</p>
    <%
        }
    %>

    <p><a href="index.jsp">Quay về trang chủ</a></p>
</body> 
</html>
