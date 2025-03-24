<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="entity.Cinema, entity.Account, entity.Image"%>

<%
    Object accObj = session.getAttribute("account");
    Account account = null;
    if (accObj instanceof Account) {
        account = (Account) accObj;
    }

    boolean isLoggedIn = (account != null);
    boolean isAdmin = isLoggedIn && "admin".equalsIgnoreCase(account.getRole());
        boolean isManager = isLoggedIn && "Manager".equalsIgnoreCase(account.getRole());

    Integer customerID = (Integer) session.getAttribute("CustomerID");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CINEMATIC - Cinemas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="frontend/css/styles.css">
        <style>
            .avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                margin-left: 8px;
            }
            
            .cinema-card {
                transition: transform 0.3s ease;
                border: none;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }
            
            .cinema-card:hover {
                transform: translateY(-5px);
            }
        </style>
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
                            <li class="nav-item"><a class="nav-link" href="MovieController?service=list">MOVIES</a></li>
                            <li class="nav-item"><a class="nav-link active" href="CimemaController">CINEMAS</a></li>
                            <li class="nav-item"><a class="nav-link" href="PromotionController?action=publicList">PROMOTIONS</a></li>
                        </ul>
                        <div class="navbar-nav">
                            <% if (isLoggedIn) { %>
                            <%    Image avatar = account.getAvatar();%>
                            <div class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    Welcome, <%= account.getName() %>!<img class="avatar" src="<%= avatar.getImagePath()%>" alt="Avatar">
                                </a>
                                <ul class="dropdown-menu dropdown-menu-dark">
                                    <li><a class="dropdown-item" href="Profile.jsp">Profile</a></li>
                                    <li><a class="dropdown-item" href="MyBookings">My Bookings</a></li>
                                        <% if (isAdmin || isManager) { %>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="admin">Admin Dashboard</a></li>
                                        <% } %>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="logout">Logout</a></li>
                                </ul>
                            </div>
                            <% } else { %>
                            <a class="nav-link" href="login.jsp">Login</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </nav>
        </header>

        <main class="container py-5 mt-5">
            <h2 class="text-center mb-4">Our Cinemas</h2>
            <div class="row g-4">
                <% List<Cinema> cinemas = (List<Cinema>) request.getAttribute("CINEMA_LIST");
                if (cinemas != null) {
                    for (Cinema cinema : cinemas) { %>
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 cinema-card">
                        <div class="card-body text-center">
                            <img src="https://c8.alamy.com/comp/2KE1GD2/cinema-building-vector-illustration-isolated-on-white-background-movie-theater-and-houses-exterior-view-in-flat-style-2KE1GD2.jpg" alt="<%= cinema.getCinemaName() %>" class="mb-3" style="width: 80px;">
                            <h5 class="card-title"><%= cinema.getCinemaName() %></h5>
                            <p class="card-text"><%= cinema.getAddress() %></p>
                        </div>
                    </div>
                </div>
                <% }
                } %>
            </div>
        </main>

        <footer class="bg-dark text-white py-4 mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-12 text-center">
                        <div class="social-links mb-3">
                            <a href="#" class="text-white me-3"><i class="fab fa-facebook"></i></a>
                            <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                        </div>
                        <p class="mb-0">&copy; 2024 CINEMATIC. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    </body>
</html>
