<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="entity.Account" %>
<%
    // Get account from session
    Object accObj = session.getAttribute("account");
    Account account = null;
    if (accObj instanceof Account) {
        account = (Account) accObj;
    }

    boolean isLoggedIn = (account != null);
    Integer customerID = (Integer) session.getAttribute("CustomerID");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
    Account customer = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #4e73df;
            --danger-color: #e74a3b;
            --success-color: #1cc88a;
            --error-color: #e74a3b;
            --text-color: #5a5c69;
            --border-radius: 0.35rem;
            --box-shadow: 0 .15rem 1.75rem 0 rgba(58,59,69,.15);
        }

        body {
            font-family: "Nunito", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: var(--text-color);
            background: #f8f9fc;
            min-height: 100vh;
        }

        .list-group-item {
            transition: all 0.3s ease;
        }
        
        .list-group-item:hover {
            background-color: #f8f9fa;
        }

        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 1px solid #e3e6f0;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 1.5rem;
        }

        .card-header {
            padding: 1.5rem;
            margin-bottom: 0;
            background-color: #f8f9fc;
            border-bottom: 1px solid #e3e6f0;
        }

        .card-header h2 {
            color: var(--primary-color);
            font-size: 1.75rem;
            font-weight: 700;
            margin: 0;
        }

        .card-body {
            padding: 1.5rem;
        }

        .message {
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: var(--border-radius);
            font-size: 0.875rem;
        }

        .error {
            background-color: rgba(231, 74, 59, 0.1);
            color: var(--error-color);
            border-left: 4px solid var(--error-color);
        }

        .success {
            background-color: rgba(28, 200, 138, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }

        .form-group {
            margin-bottom: 1rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            font-size: 0.875rem;
            color: var(--text-color);
        }

        .input-group {
            position: relative;
            display: flex;
            flex-wrap: wrap;
            align-items: stretch;
            width: 100%;
        }

        input {
            display: block;
            width: 100%;
            padding: 0.8rem 1rem;
            font-size: 0.875rem;
            line-height: 1.5;
            color: #6e707e;
            background-color: #fff;
            border: 1px solid #d1d3e2;
            border-radius: var(--border-radius);
            transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
        }

        input:focus {
            border-color: #bac8f3;
            outline: 0;
            box-shadow: 0 0 0 0.2rem rgba(78,115,223,.25);
        }

        .toggle-password {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #858796;
            transition: color 0.2s ease;
            font-size: 1rem;
        }

        .toggle-password:hover {
            color: var(--primary-color);
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        button {
            padding: 0.8rem 1.5rem;
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: all 0.2s ease-in-out;
        }

        button[type="submit"] {
            background-color: var(--primary-color);
            color: white;
            width: auto;
        }

        button[type="submit"]:hover {
            background-color: #2e59d9;
            transform: translateY(-1px);
        }

        .btn {
            background-color: var(--danger-color);
            color: white;
            width: auto;
        }

        .btn:hover {
            background-color: #be2617;
            transform: translateY(-1px);
        }

        @media (max-width: 576px) {
            .container {
                padding: 1rem;
            }

            .card-header h2 {
                font-size: 1.5rem;
            }

            .btn-group {
                flex-direction: column;
            }

            button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 mb-4">
                <div class="list-group shadow-sm">
                    <a href="account?service=changeCustomerProfile&cid=<%= customerID %>" 
                        class="list-group-item list-group-item-action" id="profileLink">
                        <i class="fas fa-user me-2"></i>Your Profile
                    </a>
                    <a href="account?service=changePassword" 
                        class="list-group-item list-group-item-action active" id="changePasswordLink">
                        <i class="fas fa-key me-2"></i>Change Password
                    </a>
                    <a href="home" 
                        class="list-group-item list-group-item-action">
                        <i class="fas fa-home me-2"></i>Home
                    </a>
                </div>
            </div>

            <!-- Content Area -->
            <div class="col-md-9">
                <div class="card">
                    <div class="card-header">
                        <h2>Đổi mật khẩu</h2>
                    </div>
                    <div class="card-body">
                        <% if (request.getAttribute("errorMessage") != null) { %>
                            <p class="message error"><%= request.getAttribute("errorMessage") %></p>
                        <% } %>

                        <% if (request.getAttribute("successMessage") != null) { %>
                            <p class="message success"><%= request.getAttribute("successMessage") %></p>
                        <% } %>

                        <form action="account" method="post">
                            <input type="hidden" name="service" value="changePassword">
                            
                            <div class="form-group">
                                <label for="currentPassword">Mật khẩu hiện tại:</label>
                                <div class="input-group">
                                    <input type="password" id="currentPassword" name="currentPassword" required>
                                    <span class="toggle-password" onclick="togglePassword('currentPassword')">
                                        <i class="fas fa-eye"></i>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="newPassword">Mật khẩu mới:</label>
                                <div class="input-group">
                                    <input type="password" id="newPassword" name="newPassword" required>
                                    <span class="toggle-password" onclick="togglePassword('newPassword')">
                                        <i class="fas fa-eye"></i>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword">Nhập lại mật khẩu mới:</label>
                                <div class="input-group">
                                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                                    <span class="toggle-password" onclick="togglePassword('confirmPassword')">
                                        <i class="fas fa-eye"></i>
                                    </span>
                                </div>
                            </div>

                            <div class="btn-group">
                                <button type="submit" name="submit">
                                    <i class="fas fa-key me-2"></i>Đổi mật khẩu
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function togglePassword(inputId) {
            let input = document.getElementById(inputId);
            let icon = input.nextElementSibling.querySelector('i');
            
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = "password";
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }

        // Auto-hide messages after 5 seconds
        setTimeout(function() {
            let messages = document.getElementsByClassName('message');
            for (let message of messages) {
                message.style.display = 'none';
            }
        }, 5000);
    </script>
</body>
</html>
