<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xác Nhận Vé</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .ticket-info {
                margin: 20px;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
            }
            .info-row {
                margin: 10px 0;
                display: flex;
                justify-content: space-between;
            }
            .info-label {
                font-weight: bold;
                color: #666;
            }
            .total-price {
                font-size: 1.5em;
                font-weight: bold;
                text-align: right;
                margin: 20px;
                color: #28a745;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center my-4">Xác Nhận Đặt Vé</h2>
            
            <%
            ResultSet ticketDetails = (ResultSet)request.getAttribute("ticketDetails");
            Double totalPrice = (Double)request.getAttribute("totalPrice");
            Double basePrice = (Double)request.getAttribute("basePrice");
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            
            if (ticketDetails != null && ticketDetails.next()) {
            %>
                <div class="ticket-info">
                    <h5><i class="fas fa-film me-2"></i>Thông Tin Phim</h5>
                    <div class="info-row">
                        <span class="info-label">Tên Phim:</span>
                        <span class="info-value"><%= ticketDetails.getString("MovieName") %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Thời Lượng:</span>
                        <span class="info-value"><%= ticketDetails.getInt("Duration") %> phút</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Giá Cơ Bản:</span>
                        <span class="info-value"><%= currencyFormat.format(ticketDetails.getDouble("BasePrice")) %></span>
                    </div>
                </div>

                <div class="ticket-info">
                    <h5><i class="fas fa-ticket-alt me-2"></i>Chi Tiết Vé</h5>
                    <div class="info-row">
                        <span class="info-label">Rạp:</span>
                        <span class="info-value"><%= ticketDetails.getString("CinemaName") %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Phòng:</span>
                        <span class="info-value"><%= ticketDetails.getString("RoomName") %> (<%= ticketDetails.getString("RoomType") %>)</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Hệ Số Phòng:</span>
                        <span class="info-value">x<%= String.format("%.2f", ticketDetails.getDouble("RoomFactor")) %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Suất Chiếu:</span>
                        <span class="info-value"><%= ticketDetails.getTimestamp("StartTime") %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Ghế:</span>
                        <span class="info-value"><%= ticketDetails.getString("SeatRow") %><%= ticketDetails.getInt("SeatNumber") %> (<%= ticketDetails.getString("SeatType") %>)</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Hệ Số Ghế:</span>
                        <span class="info-value">x<%= String.format("%.2f", ticketDetails.getDouble("SeatFactor")) %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Giá Vé:</span>
                        <span class="info-value"><%= currencyFormat.format(ticketDetails.getDouble("BasePrice") * ticketDetails.getDouble("SeatFactor") * ticketDetails.getDouble("RoomFactor")) %></span>
                    </div>
                </div>

                <% if (ticketDetails.getString("ComboItem") != null) { %>
                <div class="ticket-info">
                    <h5><i class="fas fa-hamburger me-2"></i>Combo</h5>
                    <div class="info-row">
                        <span class="info-label">Combo Đã Chọn:</span>
                        <span class="info-value"><%= ticketDetails.getString("ComboItem") %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Giá Combo:</span>
                        <span class="info-value"><%= currencyFormat.format(ticketDetails.getDouble("ComboPrice")) %></span>
                    </div>
                </div>
                <% } %>

                <div class="total-price">
                    Tổng Tiền: <%= currencyFormat.format(totalPrice) %>
                </div>
            <%
                } else {
            %>
                <div class="alert alert-danger">
                    Không tìm thấy thông tin vé!
                </div>
            <%
                }
            %>
            
            <div class="text-center mb-4">
                <a href="home" class="btn btn-primary">Về Trang Chủ</a>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
