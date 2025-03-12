<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile Page</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <!-- Custom CSS -->
        <style>
            .list-group-item {
                transition: all 0.3s ease;
            }
            .list-group-item:hover {
                background-color: #f8f9fa;
            }
            .form-group {
                margin-bottom: 1rem;
            }
            .alert-banner {
                margin-bottom: 1rem;
                padding: 1rem;
                border-radius: 0.25rem;
            }
            .card {
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            }
            .card-body {
                padding: 1.5rem;
            }
            .list-group {
                position: fixed;
                top: 0;
                left: 0;
                width: 250px; /* Điều chỉnh theo kích thước mong muốn */
                height: 100vh; /* Chiếm toàn bộ chiều cao */
                background-color: #fff; /* Đổi màu nền nếu cần */
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
                z-index: 1000; /* Đảm bảo menu nằm trên các phần khác */
            }

            .list-group-item {
                font-family: "Roboto", sans-serif;
                font-size: 16px; /* Giữ font chữ ổn định */
                padding: 10px 15px; /* Đảm bảo khoảng cách đều */
                text-align: left; /* Giữ văn bản căn chỉnh hợp lý */
            }


        </style>
    </head>

    <body class="bg-light">
        <!-- Alert Messages -->
        <% if (errorMessage != null) {%>   
        <div class="alert alert-danger alert-banner alert-dismissible fade show">
            <%= errorMessage%>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <% if (successMessage != null) {%>
        <div class="alert alert-success alert-banner alert-dismissible fade show">
            <%= successMessage%>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% }%>

        <!-- Main Content -->
        <div class="container mt-5">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3 mb-4">
                    <div class="list-group shadow-sm">
                        <a href="account?service=changeCustomerProfile" 
                           class="list-group-item list-group-item-action" id="profileLink">
                            <i class="fas fa-user me-2"></i>Your Profile
                        </a>
                        <a href="account?service=changePassword" 
                           class="list-group-item list-group-item-action" id="changePasswordLink">
                            <i class="fas fa-key me-2"></i>Change Password
                        </a>
                        <a href="AvatarController?service=ChangeAvatar" 
                           class="list-group-item list-group-item-action" id="changeAvatarLink">
                            <i class="fas fa-key me-2"></i>Change Avatar
                        </a>

                        <a href="home" 
                           class="list-group-item list-group-item-action">
                            <i class="fas fa-home me-2"></i>Home
                        </a>
                    </div>
                </div>

                <!-- Content Area -->
                <div class="col-md-9">
                    <div id="contentContainer">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title mb-4">Your Profile</h4>
                                <hr>

                                <% if (customer != null) {%>
                                <form action="account" method="post" class="mt-4">
                                    <input type="hidden" name="service" value="changeCustomerProfile">
                                    <input type="hidden" name="submit" value="true">

                                    <div class="row">
                                        <!-- Cột trái -->
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="AccountID">ID Customer</label>
                                                <input type="text" name="AccountID" id="AccountID" 
                                                       class="form-control" value="<%= customer.getAccountID()%>" readonly>
                                            </div>

                                            <div class="form-group">
                                                <label for="Name">Username*</label>
                                                <input type="text" name="Name" id="Name" 
                                                       class="form-control" value="<%= customer.getName()%>" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="YearOfBirth">Year of Birth*</label>
                                                <input type="text" name="YearOfBirth" id="YearOfBirth" 
                                                       class="form-control" value="<%= customer.getYearOfBirth()%>" required>
                                            </div>

                                        </div>

                                        <!-- Cột phải -->
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="Gender">Gender*</label>
                                                <select name="Gender" id="Gender" class="form-select" required>
                                                    <option value="Male" <%= customer.getGender().equals("Male") ? "selected" : ""%>>Male</option>
                                                    <option value="Female" <%= customer.getGender().equals("Female") ? "selected" : ""%>>Female</option>
                                                    <option value="Others" <%= customer.getGender().equals("Others") ? "selected" : ""%>>Others</option>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label for="PhoneNum">Phone Number*</label>
                                                <input type="text" name="PhoneNum" id="PhoneNum" 
                                                       class="form-control" value="<%= customer.getPhoneNum()%>" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="Address">Address*</label>
                                                <input type="text" name="Address" id="Address" 
                                                       class="form-control" value="<%= customer.getAddress()%>" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mt-3">
                                        <!-- Cột trái -->
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="LoyaltyPoint">Loyalty Point</label>
                                                <input type="text" name="LoyaltyPoint" id="LoyaltyPoint" 
                                                       class="form-control" value="<%= customer.getLoyaltyPoint()%>" readonly>
                                            </div>
                                        </div>

                                        <!-- Cột phải -->
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="MembershipLevel">Membership Level</label>
                                                <input type="text" name="MembershipLevel" id="MembershipLevel" 
                                                       class="form-control" value="<%= customer.getMembershipLevel()%>" readonly>
                                            </div>
                                        </div>
                                            <div class="form-group">
                                                <label for="Email">Email</label>
                                                <input type="email" name="Email" id="Email" 
                                                       class="form-control bg-light" value="<%= customer.getEmail()%>" readonly>
                                            </div>
                                    </div>

                                    <div class="form-group row mt-4">
                                        <div class="col-sm-12 text-center">
                                            <button type="submit" class="btn btn-primary">
                                                Update Profile
                                            </button>
                                        </div>
                                    </div>
                                </form>
                                <% }%>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                // Handle password change link
                $("#changePasswordLink").click(function (e) {
                    e.preventDefault();

                    $.ajax({
                        url: "account?service=changePassword",
                        type: "post",
                        success: function (response) {
                            $("#contentContainer").html(response);
                        },
                        error: function () {
                            alert("Failed to load page. Please try again!");
                        }
                    });
                });

                // Handle profile link
                $("#profileLink").click(function (e) {
                    e.preventDefault();
                    location.reload();
                });

                // Auto-hide alerts after 5 seconds
                setTimeout(function () {
                    $('.alert').alert('close');
                }, 5000);
            });
        </script>
    </body>
</html>