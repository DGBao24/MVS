<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Account,java.util.ArrayList,java.util.List" %>

<%
    List<Account> accounts = (List)request.getAttribute("customers");
    
    Account user = (Account) session.getAttribute("account");
    if (user == null ){
    response.sendRedirect("login.jsp");
    }
    if(!"Admin".equals(user.getRole())) {
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

        <link href="css/sb-admin-2.min.css" rel="stylesheet">
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
        <div id="wrapper">
            <jsp:include page="sidebar.jsp" />
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <jsp:include page="topbar.jsp" />

                    <div class="container-fluid">
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-2 text-gray-800">Account Management</h1>
                            <div>
                                <a class="btn btn-primary" href="account?service=CreateManager">Add New Account</a>
                            </div>
                        </div>

                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Account List</h6>
                            </div>
                            <form action="account" method="GET" class="mb-3">
                                <input type="hidden" name="service" value="searchByName">
                                <div class="input-group">
                                    <input type="text" name="cname" class="form-control" placeholder="Search Account Name..." value="${param.cname}">
                                    <div class="input-group-append">
                                        <button type="submit" class="btn btn-primary">Search</button>
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
                </div>

                <jsp:include page="footer.jsp" />
            </div>
        </div>

        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <script src="js/sb-admin-2.min.js"></script>
        <script src="vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

    </body>
</html>
