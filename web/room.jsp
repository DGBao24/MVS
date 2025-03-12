<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="entity.CinemaRoom, entity.Account"%>
<%
    Object accObj = session.getAttribute("account");
    Account account = null;
    if (accObj instanceof Account) {
        account = (Account) accObj;
    }

    boolean isLoggedIn = (account != null);
    Integer customerID = (Integer) session.getAttribute("CustomerID");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CINEMATIC - Cinema Rooms</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="frontend/css/styles.css">
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
                <div class="container">
                    <a class="navbar-brand" href="home">CINEMATIC</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item"><a class="nav-link" href="home">HOME</a></li>
                            <li class="nav-item"><a class="nav-link" href="MovieController?action=list">MOVIES</a></li>
                            <li class="nav-item"><a class="nav-link active" href="CimemaController">CINEMAS</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">MEMBERS</a></li>
                        </ul>
                        <div class="navbar-nav">
                            <% if (isLoggedIn) { %>
                            <span class="nav-item nav-link">Welcome, <%= account.getName() %>!</span>
                            <a class="nav-link" href="logout">Logout</a>
                            <% } else { %>
                            <a class="nav-link" href="login.jsp">Login</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </nav>
        </header>

        <main class="container py-5 mt-5">
            <div class="row mb-4">
                <div class="col text-center">
                    <h2 class="theater-name">Cinema Room Layout</h2>
                    <div class="divider mb-4"></div>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body">
                            <div class="screen-indicator text-center mb-4">
                                <div class="bg-secondary py-2 text-white">SCREEN</div>
                            </div>
                            
                            <div class="seat-container">
                                <% List<CinemaRoom> rooms = (List<CinemaRoom>) request.getAttribute("ROOM_LIST");
                                if (rooms != null && !rooms.isEmpty()) {
                                    for (CinemaRoom room : rooms) { %>
                                        <div class="seat-item">
                                            <div class="card mb-3">
                                                <div class="card-body text-center">
                                                    <h5 class="card-title">Room <%= room.getRoomID() %></h5>
                                                    <p class="card-text">
                                                        Capacity: <%= room.getCapacity() %> seats<br>
                                                        Type: <%= room.getRoomType() %>
                                                    </p>
                                                    <a href="RoomController?action=detail&id=<%= room.getRoomID() %>" 
                                                       class="btn btn-primary">
                                                        <i class="fas fa-info-circle"></i> View Details
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    <% }
                                } else { %>
                                    <div class="col-12">
                                        <div class="alert alert-info text-center" role="alert">
                                            No cinema rooms available.
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <footer class="bg-dark text-white py-4 mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <h5>About CINEMATIC</h5>
                        <p>Experience the magic of cinema in our state-of-the-art theaters. Premium comfort, superior sound, and crystal-clear projection.</p>
                    </div>
                    <div class="col-md-4">
                        <h5>Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="MovieController?action=list" class="text-white">Movies</a></li>
                            <li><a href="CimemaController" class="text-white">Cinemas</a></li>
                            <li><a href="#" class="text-white">Promotions</a></li>
                            <li><a href="#" class="text-white">Contact Us</a></li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h5>Connect With Us</h5>
                        <div class="social-links">
                            <a href="#" class="text-white me-3"><i class="fab fa-facebook"></i></a>
                            <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                        </div>
                    </div>
                </div>
                <hr class="mt-4">
                <div class="text-center">
                    <p class="mb-0">&copy; 2024 CINEMATIC. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/your-font-awesome-kit.js"></script>
    </body>
</html>
