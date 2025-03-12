<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Showtime Management</title>
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <style>
        .table-hover tbody tr:hover { background-color: #f8f9fc; }
        .btn-sm { margin-right: 5px; }
        .form-group label { font-weight: bold; }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <jsp:include page="sidebar.jsp" />
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <jsp:include page="topbar.jsp" />
                <div class="container-fluid">
                    <h1 class="h3 mb-4 text-gray-800">Showtime Management</h1>
                    
                    <div class="card border-left-primary shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Add New Showtime</h6>
                        </div>
                        <div class="card-body">
                            <form action="showtime" method="POST" id="addShowtimeForm">
                                <input type="hidden" name="service" value="insertShowtime">
                                <input type="hidden" name="submit" value="true">

                                <div class="form-group">
                                    <label for="MovieID"><i class="fas fa-film"></i> Movie ID:</label>
                                    <input type="number" class="form-control" name="MovieID" id="MovieID" placeholder="Enter Movie ID" required>
                                </div>

                                <div class="form-group">
                                    <label for="StartTime"><i class="fas fa-clock"></i> Start Time:</label>
                                    <input type="datetime-local" class="form-control" name="StartTime" id="StartTime" required>
                                </div>

                                <div class="form-group">
                                    <label for="EndTime"><i class="fas fa-clock"></i> End Time:</label>
                                    <input type="datetime-local" class="form-control" name="EndTime" id="EndTime" required>
                                </div>

                                <button type="submit" class="btn btn-primary"><i class="fas fa-plus-circle"></i> Add Showtime</button>
                            </form>
                        </div>
                    </div>

                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Showtime List</h6>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered table-hover" id="showtimeTable" width="100%" cellspacing="0">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Movie ID</th>
                                        <th>Start Time</th>
                                        <th>End Time</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty SHOWTIME_LIST}">
                                            <c:forEach var="showtime" items="${SHOWTIME_LIST}">
                                                <tr>
                                                    <td>${showtime.showtimeID}</td>
                                                    <td>${showtime.movieID}</td>
                                                    <td>${showtime.startTime}</td>
                                                    <td>${showtime.endTime}</td>
                                                    <td>
                                                        <a href="updateshowtime.jsp?showtimeID=${showtime.showtimeID}" class="btn btn-warning btn-sm">
                                                            <i class="fas fa-edit"></i> Update
                                                        </a>
                                                        <form action="showtime?service=deleteShowtime" method="POST" style="display:inline;">
                                                            <input type="hidden" name="id" value="${showtime.showtimeID}">
                                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this showtime?');">
                                                                <i class="fas fa-trash"></i> Delete
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="text-center text-danger">No showtimes available</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="js/sb-admin-2.min.js"></script>
</body>
</html>
