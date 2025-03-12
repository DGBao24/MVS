<%@page import="entity.Movie, entity.Account"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
    <title>Movie Details - CINEMATIC</title>
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
                        <li class="nav-item"><a class="nav-link active" href="MovieController?action=list">MOVIES</a></li>
                        <li class="nav-item"><a class="nav-link" href="CimemaController">CINEMAS</a></li>
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
        <div class="movie-detail">
            <% Movie movie = (Movie) request.getAttribute("moviedetail");
            if (movie != null) { %>
            <div class="row">
                <div class="col-md-4">
                    <img src="images/<%= movie.getMoviePoster() %>" alt="<%= movie.getMovieName() %>" class="img-fluid rounded">
                </div>
                <div class="col-md-8">
                    <h2 class="mb-4"><%= movie.getMovieName() %></h2>
                    <div class="mb-3">
                        <strong>Director:</strong> <%= movie.getDirector() %>
                    </div>
                    <div class="mb-3">
                        <strong>Genre:</strong> <%= movie.getGenre() %>
                    </div>
                    <div class="mb-3">
                        <strong>Duration:</strong> <%= movie.getDuration() %> minutes
                    </div>

                    <div class="mb-4">
                        <strong>Release Date:</strong> <%= movie.getReleaseDate() %>
                    </div>
                     <div class="mb-3">
                        <strong>Price:</strong> <%= movie.getBasePrice() %> VND
                    </div>
                    <div class="d-flex gap-3">
                        <a href="<%= movie.getTrailerURL() %>" target="_blank" class="btn btn-primary">
                            <i class="fas fa-play me-2"></i>Watch Trailer
                        </a>
                        <a href="ShowtimeController?movieID=<%= movie.getMovieID() %>" class="btn btn-danger">
                            <i class="fas fa-ticket-alt me-2"></i>Buy Tickets
                        </a>
                    </div>
                </div>
            </div>
            <div class="mt-4">
                <h3>Description:</h3>
                <p class="lead"><%= movie.getDescription() %></p>
            </div>
            <% } else { %>
            <div class="alert alert-warning" role="alert">
                Movie details not found.
            </div>
            <% } %>
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