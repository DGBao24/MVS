<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Showtime, entity.Seat, entity.Combo" %>
<html>
    <head>
        <title>Chọn Vé</title>
        <script>
            function autoSubmit() {
                document.getElementById('bookingForm').submit();
            }
        </script>
    </head>
    <body>
        <h2>Chọn vé xem phim</h2>

        <form id="bookingForm" action="book" method="post">
            <input type="hidden" name="movieID" value="<%= request.getParameter("movieID") != null ? request.getParameter("movieID") : "" %>">

            <!-- Chọn Rạp -->
            <label>Chọn Rạp:</label>
            <select name="CinemaID" onchange="autoSubmit()">
                <option value="">-- Chọn --</option>
                <% 
                    List<Showtime> cinemas = (List<Showtime>) request.getAttribute("cinemaList");
                    String cinemaIDParam = request.getParameter("CinemaID");
                    if (cinemas != null) {
                        for (Showtime c : cinemas) { 
                            String selected = (cinemaIDParam != null && cinemaIDParam.equals(String.valueOf(c.getCinemaID()))) ? "selected" : ""; 
                %>
                            <option value="<%= c.getCinemaID() %>" <%= selected %>><%= c.getCinemaID() %></option>
                <%      }
                    } %>
            </select>

            <!-- Chọn Giờ Chiếu -->
            <label>Chọn Giờ:</label>
            <select name="StartTime" onchange="autoSubmit()">
                <option value="">-- Chọn --</option>
                <% 
                    List<Showtime> showtimes = (List<Showtime>) request.getAttribute("showtimes");
                    String startTimeParam = request.getParameter("StartTime");
                    if (showtimes != null) {
                        for (Showtime s : showtimes) { 
                            String selected = (startTimeParam != null && startTimeParam.equals(String.valueOf(s.getStartTime()))) ? "selected" : ""; 
                %>
                            <option value="<%= s.getStartTime() %>" <%= selected %>><%= s.getStartTime() %></option>
                <%      }
                    } %>
            </select>

            <!-- Chọn Phòng -->
            <label>Chọn Phòng:</label>
            <select name="RoomID" onchange="autoSubmit()">
                <option value="">-- Chọn --</option>
                <% 
                    List<Showtime> rooms = (List<Showtime>) request.getAttribute("rooms");
                    String roomIDParam = request.getParameter("RoomID");
                    if (rooms != null) {
                        for (Showtime r : rooms) { 
                            String selected = (roomIDParam != null && roomIDParam.equals(String.valueOf(r.getRoomID()))) ? "selected" : ""; 
                %>
                            <option value="<%= r.getRoomID() %>" <%= selected %>><%= r.getRoomID() %></option>
                <%      }
                    } %>
            </select>

            <!-- Chọn Ghế -->
            <label>Chọn Ghế:</label>
            <select name="SeatID" onchange="autoSubmit()">
                <option value="">-- Chọn --</option>
                <% 
                    List<Seat> seats = (List<Seat>) request.getAttribute("seats");
                    String seatIDParam = request.getParameter("SeatID");
                    if (seats != null) {
                        for (Seat seat : seats) { 
                            String selected = (seatIDParam != null && seatIDParam.equals(String.valueOf(seat.getSeatID()))) ? "selected" : ""; 
                %>
                            <option value="<%= seat.getSeatID() %>" <%= selected %>><%= seat.getSeatNumber() %></option>
                <%      }
                    } %>
            </select>

            <!-- Chọn Combo -->
            <label>Chọn Combo:</label>
            <select name="ComboID">
                <option value="">Không chọn</option>
                <% 
                    List<Combo> combos = (List<Combo>) request.getAttribute("comboList");
                    if (combos != null) {
                        for (Combo c : combos) { 
                            String selected = (request.getParameter("ComboID") != null && request.getParameter("ComboID").equals(String.valueOf(c.getComboID()))) ? "selected" : ""; 
                %>
                            <option value="<%= c.getComboID() %>" <%= selected %>><%= c.getComboID() %> - <%= c.getPrice() %> VND</option>
                <%      }
                    } %>
            </select>

            <br><br>
            <input type="submit" name="buy" value="Xác nhận đặt vé">
        </form>

        <!-- Hiển thị thông báo lỗi -->
        <% if (request.getAttribute("mess") != null) { %>
            <p style="color:red;"><%= request.getAttribute("mess") %></p>
        <% } %>
    </body>  
</html>  
