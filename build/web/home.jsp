<%@ page import="entity.Account,entity.Movie,entity.Image" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
        <title>CINEMATIC - Home</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="frontend/css/styles.css">
        <style>
            .movie-status-badge {
                position: absolute;
                top: 10px;
                right: 10px;
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 500;
                z-index: 1;
            }
            
            .status-showing {
                background-color: #28a745;
                color: white;
            }
            
            .status-upcoming {
                background-color: #dc3545;
                color: white;
            }
            
            .movie-card {
                transition: transform 0.3s ease;
                border: none;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }
            
            .movie-card:hover {
                transform: translateY(-5px);
            }
            
            .movie-card .card-img-top {
                height: 400px;
                object-fit: cover;
            }
            
            .avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                margin-left: 8px;
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
                            <li class="nav-item"><a class="nav-link active" href="home">HOME</a></li>
                            <li class="nav-item"><a class="nav-link" href="MovieController?service=list">MOVIES</a></li>
                            <li class="nav-item"><a class="nav-link" href="CimemaController">CINEMAS</a></li>
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
                                    <li><a class="dropdown-item" href="mybookings">My Bookings</a></li>
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

        <!-- Hero Section -->
        <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="images/banner1.png" class="d-block w-100" alt="Movie Banner 1">
                    <div class="carousel-caption">
                        <h2>Welcome to CINEMATIC</h2>
                        <p>Experience movies like never before</p>
                        <a href="MovieController?service=list" class="btn btn-primary">Browse Movies</a>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="images/banner2.png" class="d-block w-100" alt="Movie Banner 2">
                    <div class="carousel-caption">
                        <h2>Latest Releases</h2>
                        <p>Watch the newest blockbusters in premium quality</p>
                        <a href="MovieController?service=list" class="btn btn-primary">View Showtimes</a>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="images/banner3.jpg" class="d-block w-100" alt="Movie Banner 3">
                    <div class="carousel-caption">
                        <h2>Premium Experience</h2>
                        <p>Enjoy movies in state-of-the-art theaters</p>
                        <a href="CimemaController" class="btn btn-primary">Our Cinemas</a>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>

        <!-- Now Showing Section -->
        <section class="container py-5">
            <h2 class="text-center mb-4">Now Showing</h2>
            <div class="row g-4">
                <% List<Movie> listShowing = (List<Movie>) request.getAttribute("listShowing");
                if (listShowing != null && !listShowing.isEmpty()) {
                    for (Movie movie : listShowing) { %>
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 movie-card">
                        <span class="movie-status-badge status-showing">Now Showing</span>
                        <img src="images/<%= movie.getMoviePoster() %>" class="card-img-top" alt="<%= movie.getMovieName() %> ">
                        <div class="card-body">
                            <h5 class="card-title"><%= movie.getMovieName() %></h5>
                            <p class="card-text">
                                <small class="text-muted">
                                    <%= movie.getDuration() %> mins | <%= movie.getGenre() %>
                                </small>
                            </p>
                            <div class="d-flex justify-content-between align-items-center">
                                <a href="MovieController?service=detail&id=<%= movie.getMovieID() %>" class="btn btn-primary">
                                    <i class="fas fa-info-circle"></i> Details
                                </a>
                                <a href="book?movieID=<%= movie.getMovieID() %>" class="btn btn-danger">
                                    <i class="fas fa-ticket-alt"></i> Book Now
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <% }
            } else { %>
                <div class="col-12">
                    <div class="alert alert-info text-center" role="alert">
                        No movies are currently showing.
                    </div>
                </div>
                <% } %>
            </div>
        </section>

        <!-- Upcoming Movies Section -->
        <section class="container py-5">
            <h2 class="text-center mb-4">Coming Soon</h2>
            <div class="row g-4">
                <% List<Movie> upcomingMovies = (List<Movie>) request.getAttribute("listUpcoming");
                if (upcomingMovies != null && !upcomingMovies.isEmpty()) {
                    for (Movie movie : upcomingMovies) { %>
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 movie-card">
                        <span class="movie-status-badge status-upcoming">Coming Soon</span>
                        <img src="images/<%= movie.getMoviePoster() %>" class="card-img-top" alt="<%= movie.getMovieName() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= movie.getMovieName() %></h5>
                            <p class="card-text">
                                <small class="text-muted">
                                    <%= movie.getDuration() %> mins | <%= movie.getGenre() %><br>
                                    Release Date: <%= movie.getReleaseDate() %>
                                </small>
                            </p>
                            <a href="MovieController?service=detail&id=<%= movie.getMovieID() %>" class="btn btn-primary w-100">
                                <i class="fas fa-info-circle"></i> View Details
                            </a>
                        </div>
                    </div>
                </div>
                <% }
            } else { %>
                <div class="col-12">
                    <div class="alert alert-info text-center" role="alert">
                        No upcoming movies at the moment.
                    </div>
                </div>
                <% } %>
            </div>
        </section>

        <!-- Footer -->
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
                            <li><a href="MovieController?service=list" class="text-white">Movies</a></li>
                            <li><a href="CimemaController" class="text-white">Cinemas</a></li>
                            <li><a href="PromotionController?action=publicList" class="text-white">Promotions</a></li>
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
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    </body>
</html>