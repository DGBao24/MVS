<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List, java.util.HashMap, java.util.Map"%>
<%@page import="entity.Order"%>
<%@page import="java.text.NumberFormat, java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lịch sử đặt vé</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            :root {
                --primary-color: #3f51b5;
                --secondary-color: #ff4081;
                --background-color: #f5f5f5;
                --card-color: #ffffff;
                --text-color: #333333;
                --border-radius: 8px;
                --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            body {
                background-color: var(--background-color);
                color: var(--text-color);
                line-height: 1.6;
                padding: 20px;
            }
            
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            
            h2, h3, h4 {
                color: var(--primary-color);
                margin-bottom: 20px;
            }
            
            .page-title {
                text-align: center;
                margin-bottom: 30px;
            }
            
            .card {
                background-color: var(--card-color);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 20px;
                margin-bottom: 20px;
                transition: transform 0.3s ease;
            }
            
            .card:hover {
                transform: translateY(-5px);
            }
            
            .order-card {
                cursor: pointer;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .order-card.selected {
                border: 2px solid var(--primary-color);
            }
            
            .order-info {
                flex: 1;
            }
            
            .order-date {
                color: #666;
                font-size: 0.9em;
            }
            
            .order-price {
                font-weight: bold;
                color: var(--secondary-color);
            }
            
            .order-status {
                padding: 5px 10px;
                border-radius: 20px;
                background-color: #4CAF50;
                color: white;
                font-size: 0.8em;
            }
            
            .order-details {
                margin-top: 20px;
            }
            
            .ticket-card {
                display: flex;
                margin-bottom: 15px;
                border-bottom: 1px solid #eee;
                padding-bottom: 15px;
            }
            
            .ticket-image {
                width: 120px;
                height: 180px;
                object-fit: cover;
                border-radius: var(--border-radius);
                margin-right: 15px;
            }
            
            .ticket-details {
                flex: 1;
            }
            
            .movie-title {
                font-size: 1.2em;
                font-weight: bold;
                margin-bottom: 10px;
            }
            
            .ticket-info-list {
                list-style: none;
            }
            
            .ticket-info-list li {
                margin-bottom: 5px;
            }
            
            .fa-icon {
                width: 20px;
                margin-right: 5px;
                color: var(--primary-color);
            }
            
            .combo-section {
                margin-top: 20px;
            }
            
            .combo-item {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                border-bottom: 1px solid #eee;
            }
            
            .combo-name {
                flex: 1;
            }
            
            .combo-quantity {
                width: 50px;
                text-align: center;
            }
            
            .combo-price {
                width: 100px;
                text-align: right;
                font-weight: bold;
            }
            
            .total-section {
                display: flex;
                justify-content: space-between;
                font-weight: bold;
                padding-top: 15px;
            }
            
            .no-orders {
                text-align: center;
                padding: 50px;
                color: #999;
            }
            
            .back-btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: var(--primary-color);
                color: white;
                text-decoration: none;
                border-radius: var(--border-radius);
                margin-top: 20px;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }
            
            .back-btn:hover {
                background-color: #303f9f;
            }
            
            .info-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 8px;
            }
            
            .info-label {
                font-weight: bold;
            }
            
            .seat-badge {
                display: inline-block;
                background-color: #f0f0f0;
                padding: 3px 8px;
                border-radius: 4px;
                margin-right: 5px;
                margin-bottom: 5px;
                font-size: 0.9em;
            }
            
            .vip-seat {
                background-color: #ffeeba;
                color: #856404;
            }
            
            @media (max-width: 768px) {
                .order-card {
                    flex-direction: column;
                    align-items: flex-start;
                }
                
                .order-status {
                    margin-top: 10px;
                }
                
                .ticket-card {
                    flex-direction: column;
                }
                
                .ticket-image {
                    width: 100%;
                    height: auto;
                    margin-bottom: 15px;
                    margin-right: 0;
                }
            }
        </style>
    </head>
    <body>
        <%
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            List<Order> orderList = (List<Order>) request.getAttribute("orderList");
            ResultSet ticketDetails = (ResultSet) request.getAttribute("ticketDetails");
            ResultSet comboDetails = (ResultSet) request.getAttribute("comboDetails");
            Integer selectedOrderId = (Integer) request.getAttribute("selectedOrderId");
            String error = (String) request.getAttribute("error");
        %>
        
        <div class="container">
            <h2 class="page-title">Lịch sử đặt vé</h2>
            
            <% if (error != null) { %>
                <div class="card" style="background-color: #f8d7da; color: #721c24;">
                    <%= error %>
                </div>
            <% } %>
            
            <% if (orderList == null || orderList.isEmpty()) { %>
                <div class="no-orders">
                    <i class="fas fa-ticket-alt" style="font-size: 3em; margin-bottom: 20px;"></i>
                    <h3>Bạn chưa có lịch sử đặt vé nào</h3>
                    <p>Hãy đặt vé để xem phim yêu thích của bạn!</p>
                    <a href="home" class="back-btn">Đặt vé ngay</a>
                </div>
            <% } else { %>
                <div class="order-list">
                    <h3>Danh sách đơn hàng</h3>
                    
                    <% for (Order order : orderList) { %>
                        <div class="card order-card <%= (selectedOrderId != null && selectedOrderId == order.getOrderID()) ? "selected" : "" %>" 
                             onclick="window.location.href='mybookings?orderId=<%= order.getOrderID() %>'">
                            <div class="order-info">
                                <div class="info-item">
                                    <span class="info-label">Mã đơn hàng:</span>
                                    <span>#<%= order.getOrderID() %></span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Ngày đặt:</span>
                                    <span class="order-date"><%= dateFormat.format(order.getOrderDate()) %></span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Số lượng vé:</span>
                                    <span><%= order.getSeatQuantity() %></span>
                                </div>
                                <% if (order.getComboQuantity() > 0) { %>
                                <div class="info-item">
                                    <span class="info-label">Số lượng combo:</span>
                                    <span><%= order.getComboQuantity() %></span>
                                </div>
                                <% } %>
                            </div>
                            <div>
                                <div class="order-price"><%= currencyFormat.format(order.getTotalAmount()) %></div>
                                <div class="order-status">Hoàn thành</div>
                            </div>
                        </div>
                    <% } %>
                </div>
                
                <% if (ticketDetails != null && ticketDetails.isBeforeFirst()) { %>
                    <div class="order-details">
                        <h3>Chi tiết đơn hàng #<%= selectedOrderId %></h3>
                        
                        <%
                            // Group tickets by movie
                            Map<Integer, ResultSet> ticketsByMovie = new HashMap<>();
                            
                            try {
                                // Store current position
                                ticketDetails.beforeFirst();
                                
                                // Process results
                                while (ticketDetails.next()) {
                                    int movieId = ticketDetails.getInt("MovieID");
                                    String movieName = ticketDetails.getString("MovieName");
                                    String imageURL = ticketDetails.getString("ImageURL");
                                    String cinemaName = ticketDetails.getString("CinemaName");
                                    String roomName = ticketDetails.getString("RoomName");
                                    String roomType = ticketDetails.getString("RoomType");
                                    java.sql.Timestamp startTime = ticketDetails.getTimestamp("StartTime");
                                    
                                    // If we haven't seen this movie yet, create a ticket card for it
                                    if (!ticketsByMovie.containsKey(movieId)) {
                        %>
                        <div class="card ticket-card">
                            <img src="<%= imageURL != null ? imageURL : "images/default-movie.jpg" %>" alt="<%= movieName %>" class="ticket-image">
                            <div class="ticket-details">
                                <div class="movie-title"><%= movieName %></div>
                                <ul class="ticket-info-list">
                                    <li><i class="fas fa-map-marker-alt fa-icon"></i> <%= cinemaName %> | <%= roomName %> (<%= roomType %>)</li>
                                    <li><i class="fas fa-calendar-alt fa-icon"></i> <%= dateFormat.format(startTime) %></li>
                                    <li><i class="fas fa-ticket-alt fa-icon"></i> Ghế: 
                                        <%
                                            // Reset to beginning to count and display seats
                                            ticketDetails.beforeFirst();
                                            while (ticketDetails.next()) {
                                                int currentMovieId = ticketDetails.getInt("MovieID");
                                                if (currentMovieId == movieId) {
                                                    String seatRow = ticketDetails.getString("SeatRow");
                                                    int seatNumber = ticketDetails.getInt("SeatNumber");
                                                    String seatType = ticketDetails.getString("SeatType");
                                                    String seatDisplay = seatRow + seatNumber;
                                        %>
                                        <span class="seat-badge <%= "VIP".equals(seatType) ? "vip-seat" : "" %>">
                                            <%= seatDisplay %>
                                        </span>
                                        <%
                                                }
                                            }
                                        %>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <%
                                        ticketsByMovie.put(movieId, null); // Mark as processed
                                    }
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                        
                        <% if (comboDetails != null && comboDetails.isBeforeFirst()) { %>
                            <div class="card combo-section">
                                <h4>Combo đã đặt</h4>
                                <%
                                    float comboTotal = 0;
                                    comboDetails.beforeFirst();
                                    while (comboDetails.next()) {
                                        String comboName = comboDetails.getString("ComboItem");
                                        int quantity = comboDetails.getInt("Quantity");
                                        float price = comboDetails.getFloat("Price");
                                        comboTotal += price;
                                %>
                                <div class="combo-item">
                                    <div class="combo-name"><%= comboName %></div>
                                    <div class="combo-quantity">x<%= quantity %></div>
                                    <div class="combo-price"><%= currencyFormat.format(price) %></div>
                                </div>
                                <% } %>
                                
                                <div class="total-section">
                                    <div>Tổng cộng:</div>
                                    <div><%= currencyFormat.format(comboTotal) %></div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } %>
                
                <a href="home" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Quay lại trang chủ
                </a>
            <% } %>
        </div>
    </body>
</html> 