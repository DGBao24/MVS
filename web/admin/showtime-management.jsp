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
</head>
<body id="page-top">
    <div id="wrapper">
        <jsp:include page="sidebar.jsp" />
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <jsp:include page="topbar.jsp" />
                <div class="container-fluid">
                    <h1 class="h3 mb-4 text-gray-800">Showtime Management</h1>
                    <table class="table table-bordered" id="showtimeTable" width="100%" cellspacing="0">
                        <thead>
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
                                                <a href="showtime?service=updateShowtime&showtimeID=${showtime.showtimeID}" class="btn btn-primary btn-sm">
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
                                        <td colspan="5" class="text-center">No showtimes available</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
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
