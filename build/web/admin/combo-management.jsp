<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="entity.Combo, java.util.List" %>

<%
    List<Combo> list = (List)request.getAttribute("list");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Movie Ticket - Combo Management</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>

<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
        <!-- Include Sidebar -->
        <jsp:include page="sidebar.jsp"></jsp:include>

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
                <!-- Include Topbar -->
                <jsp:include page="topbar.jsp"></jsp:include>

                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-4 text-gray-800">Combo Management</h1>

                    <!-- Success/Error Messages -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${successMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <!-- Combo Management Content -->
                    <div class="row">
                        <!-- Add New Combo Card -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Add New Combo</div>
                                            <form action="combo" method="POST" id="addComboForm">
                                                <input type="hidden" name="service" value="insertCombo">
                                                <input type="hidden" name="submit" value="true">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="ComboItem" id="ComboItem" 
                                                           placeholder="Combo Item" required>
                                                </div>
                                                <div class="form-group">
                                                    <textarea class="form-control" name="Description" id="comboDescription" 
                                                              rows="3" placeholder="Description" required></textarea>
                                                </div>
                                                <div class="form-group">
                                                    <input type="number" class="form-control" name="Price" id="comboPrice" 
                                                           placeholder="Price" step="1000" min="0" required>
                                                </div>
                                                <div class="form-group">
                                                    <input type="number" class="form-control" name="Quantity" id="Quantity" 
                                                           placeholder="Quantity" step="1" min="0" >
                                                </div>
                                                <div class="form-group">
                                                    <select class="form-control" name="Status" id="Status" required>
                                                        <option value="1">Active</option>
                                                        <option value="0">Inactive</option>
                                                    </select>
                                                </div>
                                                <button type="submit" class="btn btn-primary" value="insertCombo">Add Combo</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Existing Combos List -->
                        <div class="col-xl-8 col-md-6 mb-4">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Existing Combos</h6>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="comboTable" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Combo Item</th>
                                                    <th>Description</th>
                                                    <th>Price</th>
                                                    <th>Quantity</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    for(Combo combo : list) {
                                            %>
                                                    <tr>
                                                        <td><%= combo.getComboID() %></td>
                                                        <td><%= combo.getComboItem() %></td>
                                                        <td><%= combo.getDescription() %></td>
                                                        <td><%= combo.getPrice() %></td>
                                                        <td><%= combo.getQuantity() %></td>
                                                        <td><span class="badge <%= combo.isStatus() ? "badge-success" : "badge-danger" %>">
                                                        <%= combo.isStatus() ? "Active" : "Inactive" %>
                                                         </span>
                                                </td>

                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <form action="combo?service=DisableStatus" method="POST" style="display:inline-block; margin-right: 5px;">
                                                            <input type="hidden" name="cid" value="<%= combo.getComboID() %>">
                                                            <input type="hidden" name="submit" value="true">
                                                            <button type="submit" class="btn <%= combo.isStatus() ? "btn-warning" : "btn-success" %> btn-sm">
                                                                <%= combo.isStatus() ? "Deactivate" : "Activate" %>
                                                            </button>
                                                        </form>
                                                        
                                                        <!-- Update Button -->
                                                        <a href="combo?service=updateCombo&cid=<%= combo.getComboID() %>" class="btn btn-primary btn-sm" style="margin-right: 5px;">
                                                            <i class="fas fa-edit"></i> Update
                                                        </a>
                                                        
                                                        <!-- Delete Button -->
                                                        <form action="combo?service=deleteCombo" method="POST" style="display: inline-block;">
                                                            <input type="hidden" name="cid" value="<%= combo.getComboID() %>">
                                                            <input type="hidden" name="submit" value="true">
                                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this combo?');">
                                                                <i class="fas fa-trash"></i> Delete
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                                    </tr>
                                                <%
                                                    }
                           
                                            %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                 
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->

            <!-- Include Footer -->
            <jsp:include page="includes/footer.jsp"></jsp:include>
        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->

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

 
</body>

</html>
