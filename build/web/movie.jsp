<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="entity.Movie,entity.Account"%>
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
        <title>CINEMATIC - Movies</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="frontend/css/styles.css">
        <style>
            .nav-tabs .nav-link {
                color: #495057;
                border: none;
                border-bottom: 2px solid transparent;
                padding: 1rem 2rem;
                font-weight: 500;
            }
            
            .nav-tabs .nav-link.active {
                color: #7952b3;
                background: none;
                border-bottom: 2px solid #7952b3;
            }
            
            .nav-tabs .nav-link:hover {
                border-color: transparent;
                color: #7952b3;
            }
            
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
                            <li class="nav-item"><a class="nav-link active" href="MovieController?service=list">MOVIES</a></li>
                            <li class="nav-item"><a class="nav-link" href="CimemaController">CINEMAS</a></li>
                            <li class="nav-item"><a class="nav-link" href="PromotionController?action=publicList">PROMOTIONS</a></li>
                        </ul>
                        <div class="navbar-nav">
                            <% if (isLoggedIn) { %>
                            <div class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    Welcome, <%= account.getName() %>!
                                </a>
                                <ul class="dropdown-menu dropdown-menu-dark">
                                    <li><a class="dropdown-item" href="Profile.jsp">Profile</a></li>
                                    <li><a class="dropdown-item" href="MyBookings">My Bookings</a></li>
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
            <!-- Movie Navigation Tabs -->
            <ul class="nav nav-tabs mb-4 justify-content-center" id="movieTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="now-showing-tab" data-bs-toggle="tab" data-bs-target="#now-showing" type="button" role="tab">
                        Now Showing
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="upcoming-tab" data-bs-toggle="tab" data-bs-target="#upcoming" type="button" role="tab">
                        Coming Soon
                    </button>
                </li>
            </ul>

            <!-- Tab Content -->
            <div class="tab-content" id="movieTabContent">
                <!-- Now Showing Tab -->
                <div class="tab-pane fade show active" id="now-showing" role="tabpanel">
                    <div class="row g-4">
                        <% List<Movie> showingMovies = (List<Movie>) request.getAttribute("listShowing");
                        if (showingMovies != null && !showingMovies.isEmpty()) {
                            for (Movie movie : showingMovies) { %>
                            <div class="col-md-6 col-lg-3">
                                <div class="card h-100 movie-card">
                                    <span class="movie-status-badge status-showing">Now Showing</span>
                                    <img src="images/<%= movie.getMoviePoster() %>" class="card-img-top" alt="<%= movie.getMovieName() %>">
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
                                            <a href="ShowtimeController?movieID=<%= movie.getMovieID() %>" class="btn btn-danger">
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
                </div>

                <!-- Upcoming Movies Tab -->
                <div class="tab-pane fade" id="upcoming" role="tabpanel">
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
        <script src="https://kit.fontawesome.com/your-font-awesome-kit.js"></script>
    </body>
</html>
