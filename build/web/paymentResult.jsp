<%-- 
    Document   : paymentResult
    Created on : Mar 23, 2025, 3:04:41 PM
    Author     : pdatt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Order, java.sql.Timestamp, java.text.NumberFormat, java.util.Locale, java.text.SimpleDateFormat, java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Result</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .result-container {
                max-width: 800px;
                margin: 2rem auto;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                background-color: #fff;
            }
            .detail-section {
                margin-bottom: 1.5rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid #eee;
            }
            .section-title {
                color: #1a237e;
                margin-bottom: 1rem;
                font-weight: 600;
            }
            .detail-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 0.5rem;
            }
            .detail-label {
                font-weight: 500;
                color: #555;
            }
            .detail-value {
                font-weight: 400;
            }
            .price-value {
                font-weight: 700;
                color: #1a237e;
                font-size: 1.2rem;
            }
            .header {
                background: #1a237e;
                color: white;
                padding: 1.5rem;
                border-radius: 8px;
                margin-bottom: 2rem;
            }
            .success-icon {
                color: #28a745;
                font-size: 4rem;
                margin-bottom: 1rem;
            }
            .failure-icon {
                color: #dc3545;
                font-size: 4rem;
                margin-bottom: 1rem;
            }
            .transaction-info {
                background-color: #f8f9fa;
                padding: 1rem;
                border-radius: 8px;
                margin-bottom: 1.5rem;
            }
            .status-badge {
                font-size: 1.2rem;
                font-weight: 600;
                padding: 0.5rem 1rem;
                border-radius: 25px;
                display: inline-block;
                margin-bottom: 1rem;
            }
            .status-completed {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .status-failed {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
        </style>
    </head>
    
    <body class="bg-light">
        <%boolean paymentSuccess = (Boolean)request.getAttribute("transResult");
        %>
        <div class="result-container">
            <div class="header text-center">
                <h2>Payment Result</h2>
            </div>
            <form action="paymentstatus" method="POST">
                 <div class="text-center mb-4">
                <% if (paymentSuccess) { %>
                    <div class="success-icon">
                        <i class="bi bi-check-circle-fill"></i>
                    </div>
                    <span class="status-badge status-completed">Payment Status: Completed</span>
                    <h3 class="text-success mb-3">Payment Successful</h3>
                    <p>Your booking has been confirmed. Thank you for your purchase!</p>
                <% } else { %>
                    <div class="failure-icon">
                        <i class="bi bi-x-circle-fill"></i>
                    </div>
                    <span class="status-badge status-failed">Payment Status: Failed</span>
                    <h3 class="text-danger mb-3">Payment Failed</h3>
                    <p>There was an issue processing your payment. Please try again or contact customer support.</p>
                <% } %>
            </div>
            
            <!-- Transaction Details Section -->
            <div class="detail-section">
                <h4 class="section-title">Transaction Details</h4>
                <div class="transaction-info">
                    <div class="detail-row">
                        <span class="detail-label">Status:</span>
                        <span class="detail-value"><strong><%= paymentSuccess ? "Completed" : "Failed" %></strong></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Date & Time:</span>
                        <span class="detail-value"><%= new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date()) %></span>
                    </div>
                </div>
            </div>
                 
            <!-- Actions -->
            <div class="text-center mt-4">
                <a href="home" class="btn btn-primary">Return to Home</a>
                <% if (!paymentSuccess) { %>
                    <a href="payment.jsp" class="btn btn-outline-primary">Try Again</a>
                <% } %>
            </div>
            </form>
            <!-- Payment Status -->
           
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    </body>
</html>
