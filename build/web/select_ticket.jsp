<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,java.sql.ResultSet" %>
<%@ page import="entity.Showtime, entity.Seat, entity.Combo,entity.Movie" %>
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
        <%
        ResultSet rsCom = (ResultSet) request.getAttribute("com");
        ResultSet rsCin = (ResultSet) request.getAttribute("cin");
        ResultSet rsRoo = (ResultSet) request.getAttribute("roo");
        ResultSet rsSea = (ResultSet) request.getAttribute("sea");
        Movie movie = (Movie) request.getAttribute("movie");
        %>
        <h2><%= movie.getMovieName() %></h2>

        <form id="bookingForm" action="book" method="post">
            <input type="hidden" name="movieID" value="<%= request.getParameter("movieID") != null ? request.getParameter("movieID") : "" %>">

            <!-- Chọn Rạp -->
            <label>Chọn Rạp:</label>
            <select name="CinemaID" onchange="autoSubmit()">
                <option value="">-- Chọn --</option>
                <%
                String cinemaIDParam = request.getParameter("CinemaID");

                if (rsCin != null) {
                    while (rsCin.next()) { 
                        String selected = (cinemaIDParam != null && cinemaIDParam.equals(String.valueOf(rsCin.getInt(1)))) ? "selected" : "";
                %>
                <option value="<%= rsCin.getInt(1) %>" <%= selected %>><%= rsCin.getString(2) %></option>
                <%
                    }
                }
                %>
            </select>

            <!-- Chọn Giờ Chiếu (GIỮ NGUYÊN) -->
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
                String roomIDParam = request.getParameter("RoomID");

                if (rsRoo != null) {
                    while (rsRoo.next()) { 
                        String selected = (roomIDParam != null && roomIDParam.equals(String.valueOf(rsRoo.getInt(1)))) ? "selected" : "";
                %>
                <option value="<%= rsRoo.getInt(1) %>" <%= selected %>><%= rsRoo.getString(2) %>--<%= rsRoo.getString(3) %></option>
                <%
                    }
                }
                %>
            </select>

            <!-- Chọn Ghế (cho phép nhiều lựa chọn) -->
            <label>Chọn Ghế:</label>
            <div>
                <%
                if (rsSea != null) {
                    while (rsSea.next()) { 
                        String seatID = String.valueOf(rsSea.getInt(1));
                        String seatLabel = rsSea.getString(3) + rsSea.getInt(4) + " | " + rsSea.getString(2);
                %>
                <input type="checkbox" name="SeatID" value="<%= seatID %>"> <%= seatLabel %><br>
                <%
                    }
                }
                %>
            </div>

            <!-- Chọn Combo -->
            <label>Chọn Combo:</label>
            <select name="ComboID">
                <option value="">Không chọn</option>
                <%
                String comboIDParam = request.getParameter("ComboID");

                if (rsCom != null) {
                    while (rsCom.next()) { 
                        String selected = (comboIDParam != null && comboIDParam.equals(String.valueOf(rsCom.getInt(1)))) ? "selected" : "";
                %>
                <option value="<%= rsCom.getInt(1) %>" <%= selected %>><%= rsCom.getString(2) %> - <%= rsCom.getFloat(3) %> VND</option>
                <%
                    }
                }
                %>
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
