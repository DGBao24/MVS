<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>Chọn Vé</title>
    <script>
        function autoSubmit(form) {
            form.submit();
        }
    </script>
</head>
<body>
    <h2>Chọn vé xem phim</h2>
    
    <form action="book" method="post">
        <%-- Lấy movieID từ request (ẩn để giữ giá trị) --%>
        <input type="hidden" name="movieID" value="<%= request.getParameter("movieID") %>">
        
        <%-- Chọn Cinema --%>
        <label>Chọn Rạp:</label>
        <select name="CinemaID" onchange="autoSubmit(this.form)">
            <option value="">-- Chọn --</option>
            <%
                ResultSet rsCinema = (ResultSet) request.getAttribute("cinemaList");
                if (rsCinema != null) {
                    while (rsCinema.next()) {
            %>
                <option value="<%= rsCinema.getInt("CinemaID") %>">
                    <%= rsCinema.getString("CinemaName") %>
                </option>
            <%
                    }
                    rsCinema.close();
                }
            %>
        </select>

        <%-- Chọn Suất Chiếu --%>
        <label>Chọn Giờ:</label>
        <select name="StartTime" onchange="autoSubmit(this.form)">
            <option value="">-- Chọn --</option>
            <%
                ResultSet rsShowtime = (ResultSet) request.getAttribute("showtimeList");
                if (rsShowtime != null) {
                    while (rsShowtime.next()) {
            %>
                <option value="<%= rsShowtime.getTimestamp("StartTime") %>">
                    <%= rsShowtime.getTimestamp("StartTime") %>
                </option>
            <%
                    }
                    rsShowtime.close();
                }
            %>
        </select>

        <%-- Chọn Phòng --%>
        <label>Chọn Phòng:</label>
        <select name="RoomID" onchange="autoSubmit(this.form)">
            <option value="">-- Chọn --</option>
            <%
                ResultSet rsRoom = (ResultSet) request.getAttribute("roomList");
                if (rsRoom != null) {
                    while (rsRoom.next()) {
            %>
                <option value="<%= rsRoom.getInt("RoomID") %>">
                    <%= rsRoom.getString("RoomName") %>
                </option>
            <%
                    }
                    rsRoom.close();
                }
            %>
        </select>

        <%-- Chọn Ghế --%>
        <label>Chọn Ghế:</label>
        <select name="SeatID" onchange="autoSubmit(this.form)">
            <option value="">-- Chọn --</option>
            <%
                ResultSet rsSeat = (ResultSet) request.getAttribute("seatList");
                if (rsSeat != null) {
                    while (rsSeat.next()) {
            %>
                <option value="<%= rsSeat.getInt("SeatID") %>">
                    <%= rsSeat.getString("SeatNumber") %>
                </option>
            <%
                    }
                    rsSeat.close();
                }
            %>
        </select>

        <%-- Chọn Combo (nếu có) --%>
        <label>Chọn Combo:</label>
        <select name="ComboID">
            <option value="">Không chọn</option>
            <%
                ResultSet rsCombo = (ResultSet) request.getAttribute("comboList");
                if (rsCombo != null) {
                    while (rsCombo.next()) {
            %>
                <option value="<%= rsCombo.getInt("ComboID") %>">
                    <%= rsCombo.getString("ComboName") %> - <%= rsCombo.getDouble("Price") %> VND
                </option>
            <%
                    }
                    rsCombo.close();
                }
            %>
        </select>

        <br><br>
        <input type="submit" name="submit" value="Xác nhận đặt vé">
    </form>

    <%-- Hiển thị thông báo lỗi nếu có --%>
    <% if (request.getAttribute("mess") != null) { %>
        <p style="color:red;"><%= request.getAttribute("mess") %></p>
    <% } %>
</body> 
</html>
