<%-- 
    Document   : payment
    Created on : Mar 23, 2025, 1:47:53 PM
    Author     : pdatt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Account, entity.Movie, entity.Combo, java.sql.Timestamp, java.text.NumberFormat, java.util.Locale, java.text.SimpleDateFormat, java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .payment-container {
                max-width: 800px;
                margin: 2rem auto;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                background-color: #fff;
            }
            .detail-section {
                margin-bottom: 1.5rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid #eee;
            }
            .section-title {
                color: #1a237e;
                margin-bottom: 1rem;
                font-weight: 600;
            }
            .detail-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 0.5rem;
            }
            .detail-label {
                font-weight: 500;
                color: #555;
            }
            .detail-value {
                font-weight: 400;
            }
            .price-value {
                font-weight: 700;
                color: #1a237e;
                font-size: 1.2rem;
            }
            .header {
                background: #1a237e;
                color: white;
                padding: 1.5rem;
                border-radius: 8px;
                margin-bottom: 2rem;
            }
        </style>
    </head>
    <body class="bg-light">
        <%
            // Get user information from session
            Account account = (Account) session.getAttribute("account");
            Movie movie = (Movie) session.getAttribute("movie");
            String[] selectedSeats = (String[]) session.getAttribute("selectedSeats");
            
            // Handle different types of selectedCombos attribute
            Object combosAttribute = session.getAttribute("selectedCombos");
            String[] comboArray = null;
            List<Combo> comboList = null;
            
            if (combosAttribute instanceof String[]) {
                comboArray = (String[]) combosAttribute;
            } else if (combosAttribute instanceof List<?>) {
                comboList = (List<Combo>) combosAttribute;
            }
            
            String showtimeStr = (String) session.getAttribute("selectedShowtime");
            Timestamp showtime = null;
            if (showtimeStr != null) {
                showtime = Timestamp.valueOf(showtimeStr.split("\\.")[0]);
            }
            
            // Handle finalPrice from session to include both base price, combos, and promotions
            Double finalPrice = (Double) session.getAttribute("finalPrice");
 
            // Format currency
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            // Format date
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");

            // Format seats as comma-separated string
            String seatsStr = "";
            if (selectedSeats != null && selectedSeats.length > 0) {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < selectedSeats.length; i++) {
                    sb.append(selectedSeats[i]);
                    if (i < selectedSeats.length - 1) {
                        sb.append(", ");
                    }
                }
                seatsStr = sb.toString();
            }
             String comboStr = "";
            if (comboArray != null && comboArray.length > 0) {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < comboArray.length; i++) {
                    sb.append(comboArray[i]);
                    if (i < comboArray.length - 1) {
                        sb.append(", ");
                    }
                }
                comboStr = sb.toString();
            } else if (comboList != null && !comboList.isEmpty()) {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < comboList.size(); i++) {
                    sb.append(comboList.get(i).getComboItem());
                    if (i < comboList.size() - 1) {
                        sb.append(", ");
                    }
                }
                comboStr = sb.toString();
            }
        %>

        <div class="payment-container">
            <div class="header text-center">
                <h2>Payment Details</h2>
            </div>

            <!-- Account Information -->
            <div class="detail-section">
                <h4 class="section-title">Account Information</h4>
                <div class="detail-row">
                    <span class="detail-label">Account Name:</span>
                    <span class="detail-value"><%= account != null ? account.getName() : "N/A"%></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Email:</span>
                    <span class="detail-value"><%= account != null ? account.getEmail() : "N/A"%></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Phone Number:</span>
                    <span class="detail-value"><%= account != null ? account.getPhoneNum() : "N/A"%></span>
                </div>
            </div>

            <!-- Movie Information -->
            <div class="detail-section">
                <h4 class="section-title">Movie Information</h4>
                <div class="detail-row">
                    <span class="detail-label">Movie Name:</span>
                    <span class="detail-value"><%= movie != null ? movie.getMovieName() : "N/A"%></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Selected Seats:</span>
                    <span class="detail-value"><%= seatsStr.isEmpty() ? "N/A" : seatsStr%></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Showtime:</span>
                    <span class="detail-value"><%= showtime != null ? dateFormat.format(showtime) : "N/A"%></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Selected Combo:</span>
                    <span class="detail-value"><%= comboStr.isEmpty() ? "N/A" : comboStr%></span>
                </div>
            </div>

            <!-- Payment Information -->
            <div class="detail-section">
                <h4 class="section-title">Payment Information</h4>
                <div class="detail-row">
                    <span class="detail-label">Final Price:</span>
                    <span class="price-value"><%= finalPrice != null ? currencyFormat.format(finalPrice) : "N/A"%></span>
                </div>
            </div>

            <form action="payment" method="post">
                <input type="hidden" name="finalPrice" value="<%= finalPrice %>">
                <button type="submit" name="submit" class="btn btn-primary btn-lg mt-3">Đặt Mua</button>
            </form>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
