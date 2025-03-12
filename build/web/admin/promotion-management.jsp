<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List, entity.Promotion" %>
<%
    List<Promotion> list = (List)request.getAttribute("list");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Movie Ticket - Promotion Management</title>

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
                    <h1 class="h3 mb-4 text-gray-800">Promotion Management</h1>

                    <!-- Success/Error Messages -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% session.removeAttribute("successMessage"); %>
                    </c:if>
                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% session.removeAttribute("errorMessage"); %>
                    </c:if>

                    <!-- Promotion Management Content -->
                    <div class="row">
                        <!-- Add New Promotion Card -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Add New Promotion</div>
                                            <form action="promo" method="POST" class="mb-4">
                                                <input type="hidden" name="service" value="insertPromotion">
                                                <input type="hidden" name="submit" value="true">
                                                
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Promo Code:</label>
                                                            <input type="text" class="form-control" name="PromoCode" required>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Discount (%):</label>
                                                            <input type="number" class="form-control" name="DiscountPercent" min="1" max="100" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Redemption Count:</label>
                                                            <input type="number" class="form-control" name="RemainRedemption" min="0" required>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Start Date:</label>
                                                            <input type="date" class="form-control" name="StartDate" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">End Date:</label>
                                                            <input type="date" class="form-control" name="EndDate" required>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Description:</label>
                                                            <input type="text" class="form-control" name="Description" required>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Status:</label>
                                                            <select class="form-control" name="Status" required>
                                                                <option value="true">Active</option>
                                                                <option value="false">Inactive</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 d-flex align-items-end">
                                                        <div class="mb-3">
                                                            <button type="submit" class="btn btn-primary">Create Promotion</button>
                                                            <a href="promo?service=listAll" class="btn btn-secondary">Cancel</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Existing Promotions List -->
                        <div class="col-xl-8 col-md-6 mb-4">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Existing Promotions</h6>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="promotionTable" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Code</th>
                                                    <th>Discount</th>
                                                    <th>Start Date</th>
                                                    <th>End Date</th>
                                                    <th>Status</th>
                                                    <th>Description</th>
                                                    <th>Remain Redemption</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%for (Promotion promotion : list) {%>
                                                    <tr>
                                                        <td><%=promotion.getPromotionID()%></td>
                                                        <td><%=promotion.getPromoCode()%></td>
                                                        <td><%=promotion.getDiscountPercent()%>%</td>
                                                        <td><%=promotion.getStartDate()%></td>
                                                        <td><%=promotion.getEndDate()%></td>
                                                        <td>
                                                            <span class="badge <%= promotion.isStatus() ? "badge-success" : "badge-danger" %>">
                                                        <%= promotion.isStatus() ? "Active" : "Inactive" %>
                                                    </span>
                                                        </td>
                                                        <td><%=promotion.getDescription()%></td>
                                                        <td><%=promotion.getRemainRedemption()%></td>
                                                        <td>
                                                          <form action="promo?service=DisableStatus" method="POST" style="display: inline;">
                                                                <input type="hidden" name="pid" value="<%= promotion.getPromotionID() %>">
                                                                <input type="hidden" name="promotionId" value="<%= promotion.getPromotionID() %>">
                                                               <button type="submit" name="submit" class="btn <%= promotion.isStatus() ? "btn-warning" : "btn-success" %> btn-sm">
                                                            <%= promotion.isStatus() ? "Deactivate" : "Activate" %>
                                                        </button>
                                                            </form>
                                                            
                                                            <!-- Update Button -->
                                                            <a href="promo?service=updatePromotion&pid=<%= promotion.getPromotionID() %>" class="btn btn-primary btn-sm">
                                                                <i class="fas fa-edit"></i> Update
                                                            </a>
                                                            
                                                            <!-- Delete Button -->
                                                            <form action="promo?service=deletePromotion" method="POST" style="display: inline;" 
                                                                  onsubmit="return confirm('Are you sure you want to delete this promotion?');">
                                                                <input type="hidden" name="pid" value="<%= promotion.getPromotionID() %>">
                                                                <button type="submit" class="btn btn-danger btn-sm">
                                                                    <i class="fas fa-trash"></i> Delete
                                                                </button>
                                                            </form>
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
            <jsp:include page="includes/footer.jsp" />
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

    <!-- Page level plugins -->
    <script src="vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page specific script -->
    <script>
        $(document).ready(function() {
            // Initialize DataTable
            $('#promotionTable').DataTable();

            // Set min date for date inputs to today
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('startDate').min = today;
            document.getElementById('endTime').min = today;

            // Validate end date is after start date
            document.getElementById('startDate').addEventListener('change', function() {
                document.getElementById('endTime').min = this.value;
            });
    </script>
</body>
</html>
