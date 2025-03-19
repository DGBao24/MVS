<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.Showtime, entity.Room, entity.Cinema, entity.Movie, java.util.List, java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Showtime Management - MVS Admin</title>
        
        <!-- Custom fonts for this template-->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="css/sb-admin-2.min.css" rel="stylesheet">
    </head>

    <body id="page-top">
        <%
        List<Showtime> showtimeList = (List<Showtime>)request.getAttribute("showtime");
        ResultSet rsMov = (ResultSet) request.getAttribute("rsMov");
        ResultSet rsCin = (ResultSet) request.getAttribute("rsCin");
        ResultSet rsRoo = (ResultSet) request.getAttribute("rsRoo");
        String cidstr = request.getParameter("CinemaID");
        String message = (String) request.getAttribute("message");
        String movieID = request.getParameter("movieID");
        String startTime = request.getParameter("StartTime");
        String endTime = request.getParameter("EndTime");
        %>

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp" />
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <jsp:include page="topbar.jsp" />
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <!-- Page Heading -->
                        <h1 class="h3 mb-4 text-gray-800">Showtime Management</h1>

                        <% if(message != null && !message.isEmpty()) { %>
                        <div class="alert <%= message.contains("thành công") ? "alert-success" : "alert-danger" %> alert-dismissible fade show" role="alert">
                            <%= message %>
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <% } %>

                        <!-- Content Row -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Add New Showtime</h6>
                                    </div>
                                    <div class="card-body">
                                        <!-- Form chọn Cinema -->
                                        <form action="showtime" method="POST">
                                            <input type="hidden" name="service" value="addShowtime">
                                            <div class="mb-3">
                                                <label for="CinemaID" class="form-label">Cinema:</label>
                                                <select class="form-select form-control" name="CinemaID" id="CinemaID" onchange="this.form.submit()" required>
                                                    <option value="">-- Select Cinema --</option>
                                                    <% if(rsCin != null) { while(rsCin.next()) { %>
                                                    <option value="<%= rsCin.getInt(1) %>" <%= (cidstr != null && cidstr.equals(String.valueOf(rsCin.getInt(1)))) ? "selected" : "" %>>
                                                        <%= rsCin.getString(2) %>
                                                    </option>
                                                    <% } } %>
                                                </select>
                                            </div>
                                        </form>

                                        <!-- Form thêm Showtime -->
                                        <form action="showtime" method="POST" id="addShowtimeForm">
                                            <input type="hidden" name="service" value="addShowtime">
                                            <input type="hidden" name="CinemaID" value="<%= cidstr %>">

                                            <div class="mb-3">
                                                <label for="RoomID" class="form-label">Room:</label>
                                                <select class="form-select form-control" name="RoomID" id="RoomID" required>
                                        <% if (cidstr != null && !cidstr.isEmpty() && rsRoo != null) { %>
                                                    <% while(rsRoo.next()){ %>
                                                    <option value="<%= rsRoo.getInt(1) %>"><%= rsRoo.getString(2) %> | <%= rsRoo.getString(3) %></option>
                                                    <% } %>
                                        <% } %>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label for="movieID" class="form-label">Movie Name:</label>
                                                <select class="form-select form-control" name="MovieID" id="movieID" required>
                                                    <% if(rsMov != null) { rsMov.beforeFirst(); while(rsMov.next()){ %>
                                                    <option value="<%= rsMov.getInt(1) %>" <%= (movieID != null && movieID.equals(String.valueOf(rsMov.getInt(1)))) ? "selected" : "" %>>
                                                        <%= rsMov.getString(2) %>
                                                    </option>
                                                    <% } } %>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label for="StartTime" class="form-label">Start Time:</label>
                                                <input type="datetime-local" class="form-control" name="StartTime" id="StartTime" 
                                                       value="<%= startTime != null ? startTime.replace(" ", "T").substring(0, 16) : "" %>" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="EndTime" class="form-label">End Time:</label>
                                                <input type="datetime-local" class="form-control" name="EndTime" id="EndTime" 
                                                       value="<%= endTime != null ? endTime.replace(" ", "T").substring(0, 16) : "" %>" required>
                                            </div>

                                            <button type="submit" name="add" value="true" class="btn btn-primary">Add Showtime</button>
                                        </form>
                                    </div>
                                </div>

                                <!-- Danh sách showtime -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Showtime List</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Movie</th>
                                                        <th>Cinema</th>
                                                        <th>Room</th>
                                                        <th>Start Time</th>
                                                        <th>End Time</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% if (showtimeList != null && !showtimeList.isEmpty()) {
                                                        for (Showtime showtime : showtimeList) { %>
                                                        <tr>
                                                            <td><%= showtime.getShowtimeID() %></td>
                                                            <td><%= showtime.getMovieID() %></td>
                                                            <td><%= showtime.getCinemaID() %></td>
                                                            <td><%= showtime.getRoomID() %></td>
                                                            <td><%= showtime.getStartTime() %></td>
                                                            <td><%= showtime.getEndTime() %></td>
                                                            <td>
                                                                <a href="showtime?service=updateShowtime&id=<%= showtime.getShowtimeID() %>" 
                                                                   class="btn btn-primary btn-sm">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                                <form action="showtime" method="POST" style="display:inline;">
                                                                    <input type="hidden" name="service" value="deleteShowtime">
                                                                    <input type="hidden" name="id" value="<%= showtime.getShowtimeID() %>">
                                                                    <button type="submit" class="btn btn-danger btn-sm" 
                                                                            onclick="return confirm('Are you sure you want to delete this showtime?');">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                    <% } } else { %>
                                                        <tr>
                                                            <td colspan="7" class="text-center">No showtimes available</td>
                                                        </tr>
                                                    <% } %>
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

                <!-- Footer -->
                <footer class="sticky-footer bg-white">
                    <div class="container my-auto">
                        <div class="copyright text-center my-auto">
                            <span>Copyright &copy; Movie Ticket Booking 2024</span>
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
        <script src="js/demo/datatables-demo.js"></script>
        
        <script>
        // Reset form sau khi thêm thành công
        <% if(message != null && message.contains("thành công")) { %>
            document.getElementById('addShowtimeForm').reset();
        <% } %>
        
        // Validate thời gian
        document.getElementById('addShowtimeForm').addEventListener('submit', function(e) {
            var startTime = new Date(document.getElementById('StartTime').value);
            var endTime = new Date(document.getElementById('EndTime').value);
            
            if (endTime <= startTime) {
                e.preventDefault();
                alert('Thời gian kết thúc phải sau thời gian bắt đầu!');
            }
        });
        </script>
    </body>
</html>
