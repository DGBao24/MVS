<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.Account,entity.Cinema,entity.Movie,java.util.ArrayList,java.util.List,java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Revenue Report</title>
    <link rel="stylesheet" href="css/revenue.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body>

<div id="wrapper">
            <!-- Include Sidebar -->
            <%@include file="sidebar.jsp" %>

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">
                <!-- Main Content -->
                <div id="content">
                    <!-- Include Topbar -->
                    <%@include file="topbar.jsp" %>

            <!-- Begin Page Content -->
            <div class="container mt-4">
                <h2 class="text-center">Revenue Report</h2>

                <!-- Filter -->
                <div class="filter-section">
                    <form action="admin" method="GET">
                        <input type="hidden" name="service" value="ViewRevenue">
                        <label for="movieID">Select Movie:</label>
                        <select name="movieID" id="movieID" onchange="this.form.submit()">
                            <option value="">All</option>
                            <% 
                                List<Movie> listMov = (List<Movie>) request.getAttribute("listMov");
                                if (listMov != null) {
                                    for (Movie m : listMov) { 
                            %>
                            <option value="<%= m.getMovieID() %>"><%= m.getMovieName() %></option>
                            <% } } %>
                        </select>
                    </form>
                </div>

                <!-- Chart Container -->
                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>

                <!-- Revenue Table -->
                <div class="revenue-table">
                    <h3 class="text-center mt-4">Detail Revenue by month</h3>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Month</th>
                                <th>Revenue (VNĐ)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                ResultSet rsRev = (ResultSet) request.getAttribute("Rev");
                                String months = "[";
                                String revenues = "[";
                                if (rsRev != null) {
                                    while (rsRev.next()) { 
                                        int month = rsRev.getInt("Month");
                                        double revenue = rsRev.getDouble("TotalSales");
                                        months += "\"" + month + "\",";
                                        revenues += revenue + ",";
                            %>
                            <tr>
                                <td><%= month %></td>
                                <td><%= String.format("%,d", (int) revenue) %></td>
                            </tr>
                            <% } } 
                                months = months.endsWith(",") ? months.substring(0, months.length() - 1) : months;
                                revenues = revenues.endsWith(",") ? revenues.substring(0, revenues.length() - 1) : revenues;
                                months += "]";
                                revenues += "]";
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
                <!-- End of Main Content -->

                <!-- Footer -->
                <footer class="sticky-footer bg-white">
                    <div class="container my-auto">
                        <div class="copyright text-center my-auto">
                            <span>Copyright &copy; Movie Ticket 2025</span>
                        </div>
                    </div>
                </footer>
                <!-- End of Footer -->
            </div>
            <!-- End of Content Wrapper -->
        </div>
        <!-- End of Page Wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

        <!-- Bootstrap core JavaScript-->
        <script src="../admin/vendor/jquery/jquery.min.js"></script>
        <script src="../admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- Core plugin JavaScript-->
        <script src="../admin/vendor/jquery-easing/jquery.easing.min.js"></script>
        <!-- Custom scripts for all pages-->
        <script src="../admin/js/sb-admin-2.min.js"></script>

<script>
    // Biểu đồ doanh thu
    document.addEventListener("DOMContentLoaded", function () {
        const ctx = document.getElementById("revenueChart").getContext("2d");
        new Chart(ctx, {
            type: "bar",
            data: {
                labels: <%= months %>,
                datasets: [{
                    label: "Doanh thu (VNĐ)",
                    data: <%= revenues %>,
                    backgroundColor: "rgba(75, 192, 192, 0.5)",
                    borderColor: "rgba(75, 192, 192, 1)",
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value.toLocaleString("vi-VN") + " đ";
                            }
                        }
                    }
                }
            }
        });
    });
    
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
