<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="entity.Blog,entity.Account,entity.Image,model.DAOImage"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    Object accObj = session.getAttribute("account");
    Account account = null;
    if (accObj instanceof Account) {
        account = (Account) accObj;
    }

    boolean isLoggedIn = (account != null);
    boolean isAdmin = isLoggedIn && "admin".equalsIgnoreCase(account.getRole());
    boolean isManager = isLoggedIn && "Manager".equalsIgnoreCase(account.getRole());
    
    Blog blog = (Blog) request.getAttribute("blog");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    DAOImage daoImage = new DAOImage();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CINEMATIC - Blog Detail</title>
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

            .blog-content {
                background-color: #fff;
                border-radius: 15px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                padding: 2rem;
                margin-top: 2rem;
            }

            .blog-image {
                width: 100%;
                max-height: 400px;
                object-fit: cover;
                border-radius: 15px;
                margin-bottom: 2rem;
            }

            .blog-title {
                font-size: 2.5rem;
                font-weight: bold;
                margin-bottom: 1rem;
                color: #333;
            }

            .blog-meta {
                color: #6c757d;
                font-size: 1rem;
                margin-bottom: 2rem;
                padding-bottom: 1rem;
                border-bottom: 1px solid #dee2e6;
            }

            .blog-description {
                font-size: 1.1rem;
                line-height: 1.8;
                color: #444;
                white-space: pre-line;
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
                            <li class="nav-item"><a class="nav-link" href="CimemaController">CINEMAS</a></li>
                            <li class="nav-item"><a class="nav-link active" href="BlogController?action=list">BLOGS</a></li>
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
            <% if (blog != null) { %>
            <div class="blog-content">
                <% if (blog.getBlogPoster() > 0) { 
                    String imagePath = daoImage.getImagePathById(blog.getBlogPoster());
                    if (imagePath != null) {
                %>
                    <img src="${pageContext.request.contextPath}/images/<%= imagePath %>" alt="<%= blog.getTitle() %>" class="blog-image">
                <% } else { %>
                    <div class="blog-image d-flex align-items-center justify-content-center bg-light">
                        <span class="text-muted">Image not found</span>
                    </div>
                <% }
                } else { %>
                    <div class="blog-image d-flex align-items-center justify-content-center bg-light">
                        <span class="text-muted">No image</span>
                    </div>
                <% } %>
                <h1 class="blog-title"><%= blog.getTitle() %></h1>
                <div class="blog-meta">
                    <i class="fas fa-calendar"></i> <%= sdf.format(blog.getReleaseDate()) %>
                </div>
                <div class="blog-description">
                    <%= blog.getDescription() %>
                </div>
            </div>
            <div class="text-center mt-4">
                <a href="BlogController?action=list" class="btn btn-primary">
                    <i class="fas fa-arrow-left"></i> Back to Blog List
                </a>
            </div>
            <% } else { %>
            <div class="alert alert-danger" role="alert">
                Blog not found!
            </div>
            <div class="text-center">
                <a href="BlogController?action=list" class="btn btn-primary">Back to Blog List</a>
            </div>
            <% } %>
        </main>

        <footer class="bg-dark text-white py-4 mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h5>About CINEMATIC</h5>
                        <p>Your premier destination for movies and entertainment.</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <h5>Contact Us</h5>
                        <p>Email: info@cinematic.com<br>Phone: (123) 456-7890</p>
                    </div>
                </div>
                <div class="text-center mt-3">
                    <p>&copy; 2025 CINEMATIC. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
