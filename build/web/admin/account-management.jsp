<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Account,java.util.ArrayList,java.util.List" %>

<%
    List<Account> accounts = (List)request.getAttribute("customers");
    
    Account user = (Account) session.getAttribute("account");
    if (user == null || !"Admin".equals(user.getRole()) && !"Manager".equals(user.getRole())) {
        response.sendRedirect("error.jsp");
        return;
    }

%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Movie Ticket Admin - Account Management</title>

        <!-- Custom fonts for this template -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">


        <!-- Custom styles for this template -->
        <link href="css/sb-admin-2.min.css" rel="stylesheet">


        <!-- Custom styles for this page -->
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

        <style>
            .table-responsive {
                overflow-x: auto;
            }
            .table td {
                max-width: 200px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .table td:hover {
                white-space: normal;
                overflow: visible;
            }
        </style>
    </head>

    <body id="page-top">
        <!-- Page Wrapper -->
        <div id="wrapper">
            <!-- Include Sidebar -->
            <jsp:include page="sidebar.jsp" />

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">
                <!-- Main Content -->
                <div id="content">
                    <!-- Include Topbar -->
                    <jsp:include page="topbar.jsp" />

                    <!-- Begin Page Content -->
                    <div class="container-fluid">
                        <!-- Page Heading -->
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-2 text-gray-800">Account Management</h1>
                            <div>
                                
                                <a class="btn btn-primary" href="account?service=CreateManager">
                                    <i class="fas fa-plus"></i> Add New Account
                                </a>
                            </div>
                        </div>
                        <!-- Account Table -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Account List</h6>
                            </div>
                            <form action="account" method="GET" class="mb-3">
                                <input type="hidden" name="service" value="searchByName">
                                <div class="input-group">
                                    <input type="text" name="cname" class="form-control" placeholder="Search Account Name..." value="${param.cname}">
                                    <div class="input-group-append">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search"></i> Search
                                        </button>
                                    </div>
                                </div>
                            </form>

                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">

                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Password</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Address</th>
                                                <th>Birth Year</th>
                                                <th>Gender</th>
                                                <th>Avatar</th>
                                                <th>Points</th>
                                                <th>Level</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                if(accounts != null) {
                                                    for(Account account : accounts) {
                                            %>
                                            <tr>
                                                <td><%= account.getAccountID() %></td>
                                                <td><%= account.getName() %></td>
                                                <td><%= account.getPassword() %></td>
                                                <td><%= account.getEmail() %></td>
                                                <td><%= account.getPhoneNum() %></td>
                                                <td><%= account.getAddress() %></td>
                                                <td><%= account.getYearOfBirth() %></td>
                                                <td><%= account.getGender() %></td>
                                                <td><%= account.getAvatarID() %></td>
                                                <td><%= account.getLoyaltyPoint() %></td>
                                                <td><span class="badge badge-info"><%= account.getMembershipLevel() %></span></td>
                                                <td><span class="badge badge-primary"><%= account.getRole() %></span></td>
                                                <td>
                                                    <span class="badge <%= account.isStatus() ? "badge-success" : "badge-danger" %>">
                                                        <%= account.isStatus() ? "Active" : "Inactive" %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <form action="account?service=DisableAccount" method="POST" style="display:inline;">
                                                        <input type="hidden" name="cid" value="<%= account.getAccountID() %>">
                                                        <button type="submit" name="submit" class="btn <%= account.isStatus() ? "btn-warning" : "btn-success" %> btn-sm">
                                                            <%= account.isStatus() ? "Deactivate" : "Activate" %>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- End of Main Content -->

                <!-- Include Footer -->
                <jsp:include page="footer.jsp" />
            </div>
            <!-- End of Content Wrapper -->
        </div>
        <!-- End of Page Wrapper -->

        <!-- Add Account Modal -->
        <div class="modal fade" id="addAccountModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New Account</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="account" method="POST">
                        <input type="hidden" name="service" value="CreateManager">
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" class="form-control" name="Name" required>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" class="form-control" name="Password" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" class="form-control" name="Email" required>
                            </div>
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="tel" class="form-control" name="PhoneNum" required>
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <input type="text" class="form-control" name="Address">
                            </div>
                            <div class="form-group">
                                <label>Year of Birth</label>
                                <input type="number" class="form-control" name="YearOfBirth" min="1900" max="2024">
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <select class="form-control" name="gender">
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            
                        </div>
                        <div class="modal-footer">
                            <!--                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                        <button type="//submit" class="btn btn-primary">Add Account</button>-->
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </form>
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->

</body>
</html>
