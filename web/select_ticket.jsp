<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,java.sql.ResultSet" %>
<%@ page import="entity.Showtime, entity.Seat, entity.Combo,entity.Movie" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt Vé - <%= ((Movie)request.getAttribute("movie")).getMovieName() %></title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            :root {
                --primary-color: #1a237e;
                --secondary-color: #ff4081;
                --background-color: #f5f5f5;
            }
            
            body {
                background-color: var(--background-color);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            .booking-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 2rem;
                background: white;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }
            
            .movie-header {
                background: var(--primary-color);
                color: white;
                padding: 2rem;
                border-radius: 10px;
                margin-bottom: 2rem;
                position: relative;
                overflow: hidden;
            }
            
            .movie-header::after {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 100%);
            }
            
            .form-section {
                background: white;
                padding: 1.5rem;
                border-radius: 10px;
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }
            
            .section-title {
                color: var(--primary-color);
                margin-bottom: 1rem;
                font-weight: 600;
            }
            
            .form-select, .form-control {
                border: 2px solid #e0e0e0;
                border-radius: 8px;
                padding: 0.75rem;
                transition: all 0.3s ease;
            }
            
            .form-select:focus, .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(26,35,126,0.25);
            }
            
            .seat-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
                gap: 1rem;
                margin: 1rem 0;
            }
            
            .seat-option {
                background: #f8f9fa;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                padding: 0.5rem;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            
            .seat-option:hover {
                background: #e9ecef;
            }
            
            .seat-option input[type="checkbox"] {
                margin-right: 0.5rem;
            }
            
            .seat-option.selected {
                background: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }
            
            .btn-book {
                background: var(--secondary-color);
                color: white;
                border: none;
                padding: 1rem 2rem;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s ease;
                width: 100%;
                margin-top: 1rem;
            }
            
            .btn-book:hover {
                background: #f50057;
                transform: translateY(-2px);
            }
            
            .alert {
                border-radius: 8px;
                margin-top: 1rem;
            }
            
            @media (max-width: 768px) {
                .booking-container {
                    margin: 1rem;
                    padding: 1rem;
                }
                
                .movie-header {
                    padding: 1.5rem;
                }
                
                .seat-grid {
                    grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
                }
            }
        </style>
    </head>
    <body>
        <%
        ResultSet rsCom = (ResultSet) request.getAttribute("com");
        ResultSet rsCin = (ResultSet) request.getAttribute("cin");
        ResultSet rsRoo = (ResultSet) request.getAttribute("roo");
        ResultSet rsSea = (ResultSet) request.getAttribute("sea");
        Movie movie = (Movie) request.getAttribute("movie");
        String message = (String) request.getAttribute("mess");
        %>
        
        <div class="booking-container">
            <div class="movie-header">
                <h1 class="display-6 mb-0"><i class="fas fa-film me-2"></i><%= movie.getMovieName() %></h1>
            </div>

            <form id="bookingForm" action="book" method="post">
                <input type="hidden" name="movieID" value="<%= request.getParameter("movieID") != null ? request.getParameter("movieID") : "" %>">

                <!-- Chọn Rạp -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-building me-2"></i>Chọn Rạp</h5>
                    <select class="form-select" name="CinemaID" onchange="autoSubmit()">
                        <option value="">-- Chọn rạp chiếu --</option>
                        <%
                        String cinemaIDParam = request.getParameter("CinemaID");
                        if (rsCin != null) {
                            while (rsCin.next()) { 
                                String selected = (cinemaIDParam != null && cinemaIDParam.equals(String.valueOf(rsCin.getInt(1)))) ? "selected" : "";
                        %>
                        <option value="<%= rsCin.getInt(1) %>" <%= selected %>><%= rsCin.getString(2) %></option>
                        <% } } %>
                    </select>
                </div>

                <!-- Chọn Giờ Chiếu -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-clock me-2"></i>Chọn Suất Chiếu</h5>
                    <select class="form-select" name="StartTime" onchange="autoSubmit()">
                        <option value="">-- Chọn suất chiếu --</option>
                        <% 
                        List<Showtime> showtimes = (List<Showtime>) request.getAttribute("showtimes");
                        String startTimeParam = request.getParameter("StartTime");
                        if (showtimes != null) {
                            for (Showtime s : showtimes) { 
                                String selected = (startTimeParam != null && startTimeParam.equals(String.valueOf(s.getStartTime()))) ? "selected" : ""; 
                        %>
                        <option value="<%= s.getStartTime() %>" <%= selected %>><%= s.getStartTime() %></option>
                        <% } } %>
                    </select>
                </div>

                <!-- Chọn Phòng -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-door-open me-2"></i>Chọn Phòng</h5>
                    <select class="form-select" name="RoomID" onchange="autoSubmit()">
                        <option value="">-- Chọn phòng chiếu --</option>
                        <%
                        String roomIDParam = request.getParameter("RoomID");
                        if (rsRoo != null) {
                            while (rsRoo.next()) { 
                                String selected = (roomIDParam != null && roomIDParam.equals(String.valueOf(rsRoo.getInt(1)))) ? "selected" : "";
                        %>
                        <option value="<%= rsRoo.getInt(1) %>" <%= selected %>><%= rsRoo.getString(2) %> - <%= rsRoo.getString(3) %></option>
                        <% } } %>
                    </select>
                </div>

                <!-- Chọn Ghế -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-couch me-2"></i>Chọn Ghế</h5>
                    <div class="seat-grid">
                        <%
                        if (rsSea != null) {
                            while (rsSea.next()) { 
                                String seatID = String.valueOf(rsSea.getInt(1));
                                String seatLabel = rsSea.getString(3) + rsSea.getInt(4) + " | " + rsSea.getString(2);
                        %>
                        <div class="seat-option">
                            <input type="checkbox" class="form-check-input" name="SeatID" value="<%= seatID %>" 
                                   id="seat<%= seatID %>">
                            <label class="form-check-label" for="seat<%= seatID %>"><%= seatLabel %></label>
                        </div>
                        <% } } %>
                    </div>
                </div>

                <!-- Chọn Combo -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-hamburger me-2"></i>Chọn Combo</h5>
                    <select class="form-select" name="ComboID">
                        <option value="">Không chọn combo</option>
                        <%
                        String comboIDParam = request.getParameter("ComboID");
                        if (rsCom != null) {
                            while (rsCom.next()) { 
                                String selected = (comboIDParam != null && comboIDParam.equals(String.valueOf(rsCom.getInt(1)))) ? "selected" : "";
                        %>
                        <option value="<%= rsCom.getInt(1) %>" <%= selected %>>
                            <%= rsCom.getString(2) %> - <%= String.format("%,.0f", rsCom.getFloat(3)) %> VND
                        </option>
                        <% } } %>
                    </select>
                </div>

                <button type="submit" name="buy" class="btn btn-book">
                    <i class="fas fa-ticket-alt me-2"></i>Xác nhận đặt vé
                </button>
            </form>

            <% if (message != null) { %>
            <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i><%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function autoSubmit() {
                document.getElementById('bookingForm').submit();
            }
            
            // Thêm hiệu ứng cho việc chọn ghế
            document.querySelectorAll('.seat-option').forEach(seat => {
                seat.addEventListener('click', function() {
                    const checkbox = this.querySelector('input[type="checkbox"]');
                    checkbox.checked = !checkbox.checked;
                    this.classList.toggle('selected', checkbox.checked);
                });
            });
        </script>
    </body>   
</html>
