<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="entity.Movie, java.util.List" %>

<%
    List<Movie> list = (List)request.getAttribute("listMovie");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Movie Ticket - Movie Management</title>

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
                    <h1 class="h3 mb-4 text-gray-800">Movie Management</h1>

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

                    <!-- Movie Management Content -->
                    <div class="row">
                        <!-- Add New Movie Card -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Add New Movie</div>
                                            <form action="movie" method="POST" id="addMovieForm">
                                                <input type="hidden" name="service" value="insertMovie">
                                                <input type="hidden" name="submit" value="true">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="MovieName" id="MovieName" 
                                                           placeholder="Movie Name" required>
                                                </div>
                                                <div class="form-group">
                                                    <input type="number" class="form-control" name="Duration" id="Duration" 
                                                           placeholder="Duration (minutes)" required>
                                                </div>
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="Genre" id="Genre" 
                                                           placeholder="Genre" required>
                                                </div>
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="Director" id="Director" 
                                                           placeholder="Director" required>
                                                </div>
                                                <div class="form-group">
                                                    <input type="date" class="form-control" name="ReleaseDate" id="ReleaseDate" 
                                                           placeholder="Release Date" required>
                                                </div>
                                                <div class="form-group">
                                                    <textarea class="form-control" name="Description" id="Description" 
                                                              rows="3" placeholder="Description" required></textarea>
                                                </div>
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="Rate" id="Rate" 
                                                           placeholder="Rate" required>
                                                </div>
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="TrailerURL" id="TrailerURL" 
                                                           placeholder="Trailer URL" required>
                                                </div>
                                                <div class="form-group">
                                                    <input type="number" class="form-control" name="BasePrice" id="BasePrice" 
                                                           placeholder="Base Price" required>
                                                </div>
                                                <div class="form-group">
                                                    <select class="form-control" name="Status" id="Status" required>
                                                        <option value="NowShowing">Now Showing</option>
                                                        <option value="UpcomingMovie">Upcoming Movie</option>
                                                        <option value="Inactive">Inactive</option>
                                                    </select>
                                                </div>
                                                <button type="submit" class="btn btn-primary">Add Movie</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Existing Movies List -->
                        <div class="col-xl-8 col-md-6 mb-4">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Existing Movies</h6>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="movieTable" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Movie Name</th>
                                                    <th>Duration</th>
                                                    <th>Genre</th>
                                                    <th>Director</th>
                                                    <th>Release Date</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    if(list != null) {
                                                        for(Movie movie : list) {
                                                %>
                                                    <tr>
                                                        <td><%= movie.getMovieID() %></td>
                                                        <td><%= movie.getMovieName() %></td>
                                                        <td><%= movie.getDuration() %> mins</td>
                                                        <td><%= movie.getGenre() %></td>
                                                        <td><%= movie.getDirector() %></td>
                                                        <td><%= movie.getReleaseDate() %></td>
                                                        <td>
                                                            <span class="badge <%= movie.getStatus().equals("NowShowing") ? "badge-success" : (movie.getStatus().equals("UpcomingMovie") ? "badge-warning" : "badge-danger") %>">
                                                                <%= movie.getStatus() %>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <div class="btn-group" role="group">
                                                                <!-- Update Button -->
                                                                <a href="movie?service=updateMovie&mID=<%= movie.getMovieID() %>" class="btn btn-primary btn-sm">
                                                                    <i class="fas fa-edit"></i> Update
                                                                </a>
                                                            </div>
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
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
</body>
</html>
