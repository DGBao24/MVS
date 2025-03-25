<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="entity.Blog, model.DAOImage"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Movie Ticket - Update Blog</title>

    <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${pageContext.request.contextPath}/admin/css/sb-admin-2.min.css" rel="stylesheet">
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
                    <h1 class="h3 mb-4 text-gray-800">Update Blog</h1>

                    <!-- Alert Messages -->
                    <% if (request.getSession().getAttribute("successMessage") != null) { %>
                        <div class="alert alert-success">
                            <%= request.getSession().getAttribute("successMessage") %>
                            <% request.getSession().removeAttribute("successMessage"); %>
                        </div>
                    <% } %>
                    <% if (request.getSession().getAttribute("errorMessage") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getSession().getAttribute("errorMessage") %>
                            <% request.getSession().removeAttribute("errorMessage"); %>
                        </div>
                    <% } %>

                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Edit Blog Details</h6>
                                </div>
                                <div class="card-body">
                                    <%
                                        Blog blog = (Blog) request.getAttribute("blog");
                                        DAOImage daoImage = new DAOImage();
                                        if (blog != null) {
                                    %>
                                    <form action="${pageContext.request.contextPath}/admin/blog" method="POST" enctype="multipart/form-data">
                                        <input type="hidden" name="service" value="updateBlog">
                                        <input type="hidden" name="submit" value="true">
                                        <input type="hidden" name="BlogID" value="<%= blog.getBlogID() %>">
                                        
                                        <div class="form-group">
                                            <label for="Title">Title</label>
                                            <input type="text" class="form-control" name="Title" id="Title" 
                                                   value="<%= blog.getTitle() %>" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="ReleaseDate">Release Date</label>
                                            <input type="date" class="form-control" name="ReleaseDate" id="ReleaseDate" 
                                                   value="<%= blog.getReleaseDate() %>" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="Description">Description</label>
                                            <textarea class="form-control" name="Description" id="Description" 
                                                      rows="4" required><%= blog.getDescription() %></textarea>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Current Image</label>
                                            <div>
                                                <% if (blog.getBlogPoster() > 0) { 
                                                    String imagePath = daoImage.getImagePathById(blog.getBlogPoster());
                                                    if (imagePath != null) {
                                                %>
                                                    <img src="${pageContext.request.contextPath}/images/<%= imagePath %>" 
                                                         alt="Current Blog Image" class="img-thumbnail" style="max-width: 200px;">
                                                <% } else { %>
                                                    <p class="text-muted">Image not found</p>
                                                <% }
                                                } else { %>
                                                    <p class="text-muted">No image uploaded</p>
                                                <% } %>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="BlogPoster">Upload New Image</label>
                                            <input type="file" class="form-control-file" name="BlogPoster" id="BlogPoster" 
                                                   accept="image/*">
                                            <small class="form-text text-muted">Leave empty to keep current image. Maximum file size: 5MB.</small>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="Status">Status</label>
                                            <select class="form-control" name="Status" id="Status" required>
                                                <option value="1" <%= "1".equals(blog.getStatus()) ? "selected" : "" %>>Active</option>
                                                <option value="0" <%= "0".equals(blog.getStatus()) ? "selected" : "" %>>Inactive</option>
                                            </select>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Save Changes
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/blog" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i> Back to List
                                        </a>
                                    </form>
                                    <% } else { %>
                                        <div class="alert alert-danger">
                                            Blog not found. <a href="${pageContext.request.contextPath}/admin/blog">Back to list</a>
                                        </div>
                                    <% } %>
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
                        <span>Copyright &copy; Movie Ticket 2024</span>
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
    <script src="${pageContext.request.contextPath}/admin/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath}/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath}/admin/js/sb-admin-2.min.js"></script>
</body>
</html>
