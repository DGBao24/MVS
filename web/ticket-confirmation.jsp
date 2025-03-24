<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List, java.util.HashMap, java.util.Map"%>
<%@page import="java.text.NumberFormat, java.util.Locale"%>
<%@page import="entity.Combo, entity.Order"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Xác nhận vé</title>
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
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
            }
            
            h2, h3 {
                color: var(--primary-color);
                margin-bottom: 20px;
                text-align: center;
            }
            
            .card {
                background-color: var(--card-color);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 20px;
                margin-bottom: 20px;
            }
            
            .info-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                padding-bottom: 10px;
                border-bottom: 1px solid #eee;
            }
            
            .info-item:last-child {
                border-bottom: none;
            }
            
            .info-label {
                font-weight: bold;
            }
            
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }
            
            th {
                background-color: var(--primary-color);
                color: white;
            }
            
            .quantity-controls {
                display: flex;
                align-items: center;
            }
            
            .quantity-btn {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                border: none;
                background-color: var(--primary-color);
                color: white;
                cursor: pointer;
                font-size: 16px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 8px;
            }
            
            .quantity-btn:hover {
                background-color: #303f9f;
            }
            
            .quantity-input {
                width: 50px;
                text-align: center;
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 5px;
            }
            
            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
                transition: all 0.3s;
                text-align: center;
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                color: white;
            }
            
            .btn-primary:hover {
                background-color: #303f9f;
            }
            
            .btn-secondary {
                background-color: var(--secondary-color);
                color: white;
            }
            
            .btn-secondary:hover {
                background-color: #f50057;
            }
            
            .btn-outline {
                background-color: transparent;
                border: 1px solid var(--primary-color);
                color: var(--primary-color);
            }
            
            .btn-outline:hover {
                background-color: var(--primary-color);
                color: white;
            }
            
            .form-group {
                margin-bottom: 15px;
            }
            
            .input-group {
                display: flex;
            }
            
            .form-control {
                flex: 1;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px 0 0 4px;
                font-size: 16px;
            }
            
            .input-group .btn {
                border-radius: 0 4px 4px 0;
            }
            
            .alert {
                padding: 10px;
                border-radius: var(--border-radius);
                margin-bottom: 15px;
            }
            
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            
            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            
            .badge {
                display: inline-block;
                padding: 4px 8px;
                background-color: var(--primary-color);
                color: white;
                border-radius: 20px;
                font-size: 14px;
                margin-left: 10px;
            }
            
            .footer {
                margin-top: 20px;
                text-align: center;
            }
            
            .footer a {
                color: var(--primary-color);
                text-decoration: none;
            }
            
            .footer a:hover {
                text-decoration: underline;
            }
            
            @media (max-width: 768px) {
                .container {
                    padding: 10px;
                }
                
                th, td {
                    padding: 8px;
                }
            }

            #finalPriceDisplay {
                font-size: 1.2rem;
                font-weight: bold;
                color: var(--secondary-color);
            }

            .total-section {
                font-size: 1.2rem;
                padding: 15px;
                background-color: #f9f9f9;
                border-radius: var(--border-radius);
                margin-top: 20px;
            }
        </style>
    </head>
    <body>

        <%
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

            Double finalPrice = (Double) session.getAttribute("finalPrice");
            Double basePrice = (Double) session.getAttribute("basePrice");
            Order lastOrder = (Order) session.getAttribute("Order");
            ResultSet rsCombo = (ResultSet) request.getAttribute("combo");
            String message = (String) request.getAttribute("mess");
            Map<Integer, Integer> comboQuantities = (Map<Integer, Integer>) session.getAttribute("comboQuantities");
            String appliedPromo = (String) session.getAttribute("appliedPromo");

            if (comboQuantities == null) comboQuantities = new HashMap<>();
        %>


        <div class="container">
            <h2>Xác nhận vé</h2>

            <% if (message != null) { %>
                <div class="alert alert-<%= message.contains("lỗi") || message.contains("Lỗi") ? "danger" : "success" %>">
                    <%= message %>
                </div>
            <% } %>

            <div class="card">
                <h3>Thông tin đơn hàng</h3>
                <div class="info-item">
                    <span class="info-label">Mã đơn hàng:</span>
                    <span><%= (lastOrder != null) ? lastOrder.getOrderID() : "Không có" %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Giá vé ban đầu:</span>
                    <span><%= (basePrice != null) ? currencyFormat.format(basePrice) : "Không có" %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Giá cuối cùng:</span>
                    <span id="finalPriceDisplay"><%= (finalPrice != null) ? currencyFormat.format(finalPrice) : "Không có" %></span>
                </div>
            </div>

            <div class="card">
                <h3>Chọn Combo</h3>
                <form id="comboForm" action="combo-promotion" method="post">
                    <input type="hidden" name="calculatedFinalPrice" id="comboFormFinalPrice" value="<%= finalPrice != null ? finalPrice.doubleValue() : 0.0 %>">
                    <table>
                        <tr>
                            <th>Tên Combo</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                        </tr>
                        <% 
                        if (rsCombo != null && rsCombo.isBeforeFirst()) { 
                            rsCombo.beforeFirst(); // Reset the cursor
                            while (rsCombo.next()) { 
                                int comboID = rsCombo.getInt("ComboID");
                                String comboName = rsCombo.getString("ComboItem");
                                double price = rsCombo.getDouble("Price");
                                int quantity = comboQuantities.getOrDefault(comboID, 0);
                        %>
                        <tr class="combo-row" data-id="<%= comboID %>" data-price="<%= price %>">
                            <td><%= comboName %></td>
                            <td class="combo-price"><%= currencyFormat.format(price) %></td>
                            <td>
                                <div class="quantity-controls">
                                    <button type="button" class="quantity-btn quantity-decrease"><i class="fas fa-minus"></i></button>
                                    <input type="number" class="quantity-input" name="ComboQuantity_<%= comboID %>" value="<%= quantity %>" min="0" data-id="<%= comboID %>">
                                    <button type="button" class="quantity-btn quantity-increase"><i class="fas fa-plus"></i></button>
                                </div>
                            </td>
                        </tr>
                        <% 
                            } 
                        } else { 
                        %>
                        <tr>
                            <td colspan="3">Hiện không có combo nào.</td>
                        </tr>
                        <% } %>
                    </table>

                    <div class="total-section">
                        <div class="info-item">
                            <span class="info-label">Tổng cộng combo:</span>
                            <span id="comboTotalDisplay">0 ₫</span>
                        </div>
                    </div>

                    <button type="submit" name="confirmCombo" class="btn btn-primary">Xác nhận Combo</button>
                </form>
            </div>

            <div class="card">
                <h3>Mã giảm giá</h3>
                <!-- This form only applies the promotion when the submit button is clicked, not when entering text -->
                <form id="promoForm" action="combo-promotion" method="post">
                    <input type="hidden" name="calculatedFinalPrice" id="promoFormFinalPrice" value="<%= finalPrice != null ? finalPrice.doubleValue() : 0.0 %>">
                    <div class="input-group">
                        <input type="text" id="promoCodeInput" class="form-control" name="PromoCode" placeholder="Nhập mã giảm giá (nếu có)" value="<%= appliedPromo != null ? appliedPromo : "" %>">
                        <button type="submit" name="applyPromo" class="btn btn-primary">Áp dụng</button>
                    </div>
                </form>

                <% if (appliedPromo != null) { %>
                    <div class="alert alert-success" style="margin-top: 10px;">
                        Mã giảm giá đã áp dụng: <strong><%= appliedPromo %></strong>
                    </div>
                <% } %>
            </div>

            <div class="footer">
                <form action="combo-promotion" method="post" id="paymentForm">
                    <input type="hidden" name="calculatedFinalPrice" id="paymentFormFinalPrice" value="<%= finalPrice != null ? finalPrice.doubleValue() : 0.0 %>">
                    <button type="submit" name="pay" class="btn btn-secondary">Tiến hành thanh toán</button>
                </form>
                <p style="margin-top: 20px;">
                    <a href="home" class="btn btn-outline">
                        <i class="fas fa-home"></i> Quay lại trang chủ
                    </a>
                </p>
            </div>
        </div>

        <!-- Add hidden fields for passing server-side values to JavaScript -->
        <input type="hidden" id="basePriceField" value="<%= basePrice != null ? basePrice.doubleValue() : 0.0 %>">
        <input type="hidden" id="currentFinalPriceField" value="<%= finalPrice != null ? finalPrice.doubleValue() : 0.0 %>">
        <input type="hidden" id="appliedPromoField" value="<%= appliedPromo != null ? appliedPromo : "" %>">
        <input type="hidden" id="seatCountField" value="<%= session.getAttribute("selectedSeats") != null ? ((String[])session.getAttribute("selectedSeats")).length : 0 %>">
        <input type="hidden" id="roomFactorField" value="<%= session.getAttribute("roomFactor") != null ? session.getAttribute("roomFactor") : 1.0 %>">
        <input type="hidden" id="seatFactorField" value="<%= session.getAttribute("seatFactor") != null ? session.getAttribute("seatFactor") : 1.0 %>">

        <script type="text/javascript">
            /* Store initial values */
            var basePrice = parseFloat(document.getElementById('basePriceField').value);
            var currentFinalPrice = parseFloat(document.getElementById('currentFinalPriceField').value);
            var appliedPromo = document.getElementById('appliedPromoField').value;
            var seatCount = parseInt(document.getElementById('seatCountField').value);
            var roomFactor = parseFloat(document.getElementById('roomFactorField').value) || 1.0;
            var seatFactor = parseFloat(document.getElementById('seatFactorField').value) || 1.0;
            
            /* Format currency function */
            function formatCurrency(amount) {
                return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
            }
            
            /* Calculate total function */
            function calculateTotal() {
                var comboTotal = 0;
                var comboRows = document.querySelectorAll('.combo-row');
                
                for (var i = 0; i < comboRows.length; i++) {
                    var row = comboRows[i];
                    var id = row.getAttribute('data-id');
                    var price = parseFloat(row.getAttribute('data-price'));
                    var quantityInput = document.querySelector('input[name="ComboQuantity_' + id + '"]');
                    var quantity = parseInt(quantityInput ? quantityInput.value : 0) || 0;
                    comboTotal += price * quantity;
                }
                
                var comboTotalDisplay = document.getElementById('comboTotalDisplay');
                if (comboTotalDisplay) {
                    comboTotalDisplay.textContent = formatCurrency(comboTotal);
                }
                return comboTotal;
            }
            
            /* Update display price - considers base price, seat count, combos, and promo discount */
            function updateDisplayPrice() {
                // Apply room and seat factors to the base price
                var adjustedBasePrice = basePrice * roomFactor * seatFactor;
                
                // Calculate the seat price total (adjustedBasePrice * number of seats)
                var seatTotal = adjustedBasePrice * seatCount;
                
                // Get combo total
                var comboTotal = calculateTotal();
                
                // Calculate total price before discount
                var subtotal = seatTotal + comboTotal;
                
                // If there's a promotion code that was already applied from the server side,
                // we respect that discount (don't apply client-side discount for promo code input field)
                var discountedTotal = subtotal;
                
                if (appliedPromo.length > 0) {
                    // Simulated 10% discount - in a real app, you'd get the actual discount rate
                    discountedTotal = subtotal * 0.9;
                }
                
                // Update the display
                currentFinalPrice = discountedTotal;
                var priceDisplay = document.getElementById('finalPriceDisplay');
                if (priceDisplay) {
                    priceDisplay.textContent = formatCurrency(currentFinalPrice);
                }
                
                // Update the final price in all forms
                var finalPriceFields = document.querySelectorAll('input[name="calculatedFinalPrice"]');
                for (var i = 0; i < finalPriceFields.length; i++) {
                    finalPriceFields[i].value = currentFinalPrice;
                }
            }
            
            /* Initialize event listeners when DOM is loaded */
            document.addEventListener('DOMContentLoaded', function() {
                // Add a hidden field for the final price
                var comboForm = document.getElementById('comboForm');
                if (comboForm) {
                    var hiddenField = document.createElement('input');
                    hiddenField.type = 'hidden';
                    hiddenField.name = 'calculatedFinalPrice';
                    hiddenField.id = 'finalPriceField';
                    hiddenField.value = currentFinalPrice;
                    comboForm.appendChild(hiddenField);
                }
                
                // Setup quantity increase buttons
                var increaseButtons = document.querySelectorAll('.quantity-increase');
                for (var i = 0; i < increaseButtons.length; i++) {
                    increaseButtons[i].addEventListener('click', function() {
                        var parent = this.closest('.combo-row');
                        var id = parent.getAttribute('data-id');
                        var input = document.querySelector('input[name="ComboQuantity_' + id + '"]');
                        input.value = parseInt(input.value || 0) + 1;
                        updateDisplayPrice();
                    });
                }
                
                // Setup quantity decrease buttons
                var decreaseButtons = document.querySelectorAll('.quantity-decrease');
                for (var i = 0; i < decreaseButtons.length; i++) {
                    decreaseButtons[i].addEventListener('click', function() {
                        var parent = this.closest('.combo-row');
                        var id = parent.getAttribute('data-id');
                        var input = document.querySelector('input[name="ComboQuantity_' + id + '"]');
                        var currentValue = parseInt(input.value || 0);
                        input.value = Math.max(0, currentValue - 1);
                        updateDisplayPrice();
                    });
                }
                
                // Setup quantity input changes
                var quantityInputs = document.querySelectorAll('.quantity-input');
                for (var i = 0; i < quantityInputs.length; i++) {
                    quantityInputs[i].addEventListener('change', function() {
                        if (parseInt(this.value) < 0) this.value = 0;
                        updateDisplayPrice();
                    });
                    
                    quantityInputs[i].addEventListener('input', function() {
                        updateDisplayPrice();
                    });
                }
                
                // Setup promo code input - Remove the input event listener since we want the price to update only when submitting
                var promoInput = document.getElementById('promoCodeInput');
                if (promoInput) {
                    // No input listener - price only updates when user clicks submit
                }
                
                // Add seat count display
                var orderInfoCard = document.querySelector('.card:first-of-type');
                if (orderInfoCard) {
                    var seatsInfo = document.createElement('div');
                    seatsInfo.className = 'info-item';
                    seatsInfo.innerHTML = '<span class="info-label">Số lượng ghế:</span><span>' + seatCount + '</span>';
                    orderInfoCard.querySelector('h3').insertAdjacentElement('afterend', seatsInfo);
                }
                
                // Initialize calculation
                calculateTotal();
                updateDisplayPrice();
            });
        </script>

    </body>
</html>
