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
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <h2>Xác nhận vé</h2>

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

        <% if (message != null) { %>
            <p style="color: red;"><%= message %></p>
        <% } %>

        <h3>Thông tin đơn hàng</h3>
        <p>Mã đơn hàng: <%= (lastOrder != null) ? lastOrder.getOrderID() : "Không có" %></p>
        <p>Giá vé ban đầu: <%= (basePrice != null) ? currencyFormat.format(basePrice) : "Không có" %></p>
        <p>Giá cuối cùng: <%= (finalPrice != null) ? currencyFormat.format(finalPrice) : "Không có" %></p>

        <h3>Chọn Combo</h3>
        <form action="combo-promotion" method="post">
            <table border="1">
                <tr>
                    <th>Tên Combo</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                </tr>
                <% 
                if (rsCombo != null && rsCombo.isBeforeFirst()) { 
                    while (rsCombo.next()) { 
                        int comboID = rsCombo.getInt("ComboID");
                        String comboName = rsCombo.getString("ComboItem");
                        double price = rsCombo.getDouble("Price");
                        int quantity = comboQuantities.getOrDefault(comboID, 0);
                %>
                <tr>
                    <td><%= comboName %></td>
                    <td><%= currencyFormat.format(price) %></td>
                    <td>
                        <button type="button" class="quantity-decrease" data-id="<%= comboID %>">-</button>
                        <input type="number" name="ComboQuantity_<%= comboID %>" value="<%= quantity %>" min="0">
                        <button type="button" class="quantity-increase" data-id="<%= comboID %>">+</button>
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

            <button type="submit" name="confirmCombo">Xác nhận Combo</button>
        </form>

        <h3>Mã giảm giá</h3>
        <form action="combo-promotion" method="post">
            <input type="text" name="PromoCode" placeholder="Nhập mã giảm giá (nếu có)">
            <button type="submit" name="applyPromo">Áp dụng mã giảm giá</button>
        </form>

        <% if (appliedPromo != null) { %>
            <p>Mã giảm giá đã áp dụng: <strong><%= appliedPromo %></strong></p>
        <% } %>

        <br>
        <form action="combo-promotion" method="post">
            <button type="submit" name="pay">Thanh toán</button>
        </form>

        <br>
        <a href="index.jsp">Quay lại trang chủ</a>
    </body>
</html>
