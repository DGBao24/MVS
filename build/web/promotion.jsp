<%@ page import="entity.Account,entity.Promotion" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    Object accObj = session.getAttribute("account");
    Account account = null;
    if (accObj instanceof Account) {
        account = (Account) accObj;
    }
    boolean isLoggedIn = (account != null);
    boolean isAdmin = isLoggedIn && "admin".equalsIgnoreCase(account.getRole());
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CINEMATIC - Promotions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="frontend/css/styles.css">
    <style>
        .promotion-card {
            transition: transform 0.3s ease;
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .promotion-card:hover {
            transform: translateY(-5px);
        }
        
        .promotion-header {
            background: linear-gradient(45deg, #7952b3, #614092);
            color: white;
            padding: 20px;
        }
        
        .promotion-code {
            background: rgba(255,255,255,0.1);
            padding: 8px 15px;
            border-radius: 20px;
            font-family: monospace;
            font-size: 1.1em;
        }
        
        .discount-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: #dc3545;
            color: white;
            padding: 10px 15px;
            border-radius: 20px;
            font-weight: bold;
        }
        
        .promotion-dates {
            font-size: 0.9em;
            color: #6c757d;
        }
        
        .redemption-count {
            color: #28a745;
            font-weight: bold;
        }
        
        .expired-badge {
            background: #6c757d;
            color: white;
            padding: 5px 10px;
            border-radius: 10px;
            font-size: 0.8em;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
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
                        <li class="nav-item"><a class="nav-link" href="CimemaController">CINEMAS</a></li>
                        <li class="nav-item"><a class="nav-link active" href="PromotionController">PROMOTIONS</a></li>
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
                                <% if (isAdmin) { %>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="admin.jsp">Admin Dashboard</a></li>
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

    <!-- Promotions Header -->
    <div class="container mt-5 pt-4">
        <div class="text-center mb-5">
            <h1 class="display-4">Current Promotions</h1>
            <p class="lead text-muted">Discover our latest offers and save on your next movie experience!</p>
        </div>

        <!-- Promotions Grid -->
        <div class="row g-4">
            <% List<Promotion> promotions = (List<Promotion>) request.getAttribute("promotionList");
            if (promotions != null && !promotions.isEmpty()) {
                for (Promotion promo : promotions) { %>
                <div class="col-md-6 col-lg-4">
                    <div class="card promotion-card">
                        <div class="promotion-header">
                            <span class="promotion-code"><%= promo.getPromoCode() %></span>
                            <span class="discount-badge"><%= promo.getDiscountPercent() %>% OFF</span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title"><%= promo.getDescription() %></h5>
                            <div class="promotion-dates mb-3">
                                <small>Valid from <%= dateFormat.format(promo.getStartDate()) %> to <%= dateFormat.format(promo.getEndDate()) %></small>
                            </div>
                            <% if (promo.isStatus()) { %>
                                <p class="mb-2">Remaining uses: <span class="redemption-count"><%= promo.getRemainRedemption() %></span></p>
                                <button class="btn btn-primary w-100" onclick="copyPromoCode('<%= promo.getPromoCode() %>')">Copy Code</button>
                            <% } else { %>
                                <span class="expired-badge">Expired</span>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% }
            } else { %>
                <div class="col-12">
                    <div class="alert alert-info text-center" role="alert">
                        <i class="fas fa-info-circle me-2"></i>
                        No promotions are currently available. Check back soon for new offers!
                    </div>
                </div>
            <% } %>
        </div>
    </div>

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
                        <li><a href="MovieController?action=list" class="text-white">Movies</a></li>
                        <li><a href="CimemaController" class="text-white">Cinemas</a></li>
                        <li><a href="PromotionController" class="text-white">Promotions</a></li>
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
    <script>
        function copyPromoCode(code) {
            navigator.clipboard.writeText(code).then(() => {
                // You could add a toast notification here
                alert('Promo code copied to clipboard!');
            });
        }
    </script>
</body>
</html>
