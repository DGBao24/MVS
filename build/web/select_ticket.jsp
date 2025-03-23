<%@page import="entity.Movie, entity.Account,entity.Showtime,java.sql.ResultSet,java.util.List"%>

<%
Object accObj = session.getAttribute("account");
Account account = null;
if (accObj instanceof Account) {
    account = (Account) accObj;
}

    
if (account == null) {
    response.sendRedirect("login.jsp");
    return; 
}

Integer customerID = (Integer) session.getAttribute("CustomerID");
ResultSet rsCom = (ResultSet) session.getAttribute("com");
    ResultSet rsCin = (ResultSet) session.getAttribute("cin");
    ResultSet rsRoo = (ResultSet) session.getAttribute("roo");
    ResultSet rsSea = (ResultSet) session.getAttribute("sea");
    Movie movie = (Movie) request.getAttribute("movie");
    String message = (String) request.getAttribute("mess");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book Ticket - <%= ((Movie) request.getAttribute("movie")).getMovieName() %></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function autoSubmit() {
                document.getElementById('bookingForm').submit();
            }
        </script>
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
        <div class="booking-container">
            <div class="movie-header">
                <h1 class="display-6 mb-0"><i class="fas fa-film me-2"></i><%= movie.getMovieName() %></h1>
            </div>

            <form id="bookingForm" action="book" method="post">
                <input type="hidden" name="movieID" value="<%= request.getParameter("movieID") != null ? request.getParameter("movieID") : "" %>">

                <!-- Ch?n R?p -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-building me-2"></i>Cinema</h5>
                    <select class="form-select" name="CinemaID" onchange="autoSubmit()">
                        <option value="">-- Cinema --</option>
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

                <!-- Ch?n Gi? Chi?u -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-clock me-2"></i>Show Time</h5>
                    <select class="form-select" name="StartTime" onchange="autoSubmit()">
                        <option value="">-- Show Time --</option>
                        <% 
                        ResultSet rsSho = (ResultSet) session.getAttribute("sho");
                        String startTimeParam = request.getParameter("StartTime");
                        if (rsSho != null) {
                            while (rsSho.next()) { 
                                String selected = (startTimeParam != null && startTimeParam.equals(String.valueOf(rsSho.getTimestamp(1)))) ? "selected" : ""; 
                        %>
                        <option value="<%= rsSho.getTimestamp(1) %>" <%= selected %>><%= rsSho.getTimestamp(1) %>--<%=rsSho.getTimestamp(2)%></option>
                        <% } } %>
                    </select>
                </div>

                <!-- Ch?n Phòng -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-door-open me-2"></i>Room</h5>
                    <select class="form-select" name="RoomID" onchange="autoSubmit()">
                        <option value="">-- Room --</option>
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

                <!-- Ch?n Gh? -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-couch me-2"></i>Seat</h5>
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



                <button type="submit" name="confirm" class="btn btn-primary mt-3">Confirm</button>
            </form>
                    <% if (message != null) { %>
            <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i><%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>
        </div>
    </body>
</html>
