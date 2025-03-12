<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="entity.Cinema, entity.Account"%>

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
        <title>CINEMATIC</title>
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
                            <li class="nav-item"><a class="nav-link" href="MovieController?service=list">MOVIES</a></li>
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
        <script src="https://kit.fontawesome.com/your-font-awesome-kit.js"></script>
    </body>
</html>
