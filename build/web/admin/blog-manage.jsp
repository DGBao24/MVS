<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="entity.Blog, java.util.List, model.DAOImage" %>

<%
    List<Blog> list = (List)request.getAttribute("blogList");
    DAOImage daoImage = new DAOImage();
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Movie Ticket - Blog Management</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/admin/css/sb-admin-2.min.css" rel="stylesheet">
        
        <!-- Custom styles for status toggle button -->
        <style>
            .status-toggle {
                cursor: pointer;
            }
            .btn-group-xs > .btn, .btn-xs {
                padding: .25rem .4rem;
                font-size: .875rem;
                line-height: .5;
                border-radius: .2rem;
            }
        </style>
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
                        <h1 class="h3 mb-4 text-gray-800">Blog Management</h1>

                        <!-- Success/Error Messages -->
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
                            <!-- Add New Blog Card -->
                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-primary shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                    Add New Blog</div>
                                                <form action="${pageContext.request.contextPath}/admin/blog" method="POST" id="addBlogForm" enctype="multipart/form-data">
                                                    <input type="hidden" name="service" value="insertBlog">
                                                    <input type="hidden" name="submit" value="true">
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" name="Title" id="Title" 
                                                               placeholder="Blog Title" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <input type="date" class="form-control" name="ReleaseDate" id="ReleaseDate" 
                                                               required>
                                                    </div>
                                                    <div class="form-group">
                                                        <textarea class="form-control" name="Description" id="Description" 
                                                                  placeholder="Blog Description" rows="4" required></textarea>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="BlogPoster">Blog Image</label>
                                                        <input type="file" class="form-control-file" name="BlogPoster" id="BlogPoster" 
                                                               accept="image/*" required>
                                                        <small class="form-text text-muted">Maximum file size: 5MB. Only image files allowed.</small>
                                                    </div>
                                                    <div class="form-group">
                                                        <select class="form-control" name="Status" id="Status" required>
                                                            <option value="1">Active</option>
                                                            <option value="0">Inactive</option>
                                                        </select>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary btn-block">
                                                        <i class="fas fa-plus"></i> Add Blog
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Blog List Card -->
                            <div class="col-xl-8 col-md-6 mb-4">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Existing Blogs</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Title</th>
                                                        <th>Release Date</th>
                                                        <th>Image</th>
                                                        <th>Status</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% if(list != null) { %>
                                                        <% for(Blog blog : list) { %>
                                                            <tr>
                                                                <td><%= blog.getBlogID() %></td>
                                                                <td><%= blog.getTitle() %></td>
                                                                <td><%= blog.getReleaseDate() %></td>
                                                                <td>
                                                                    <% if (blog.getBlogPoster() > 0) { 
                                                                        String imagePath = daoImage.getImagePathById(blog.getBlogPoster());
                                                                        if (imagePath != null) {
                                                                    %>
                                                                        <img src="${pageContext.request.contextPath}/images/<%= imagePath %>" 
                                                                             alt="Blog Image" class="img-thumbnail" style="max-width: 100px;">
                                                                    <% } else { %>
                                                                        <span class="text-muted">Image not found</span>
                                                                    <% } 
                                                                    } else { %>
                                                                        <span class="text-muted">No image</span>
                                                                    <% } %>
                                                                </td>
                                                                <td>
                                                                    <span class="badge badge-<%= blog.getStatus().equals("1") ? "success" : "secondary" %>">
                                                                        <%= blog.getStatus().equals("1") ? "Active" : "Inactive" %>
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <a href="${pageContext.request.contextPath}/admin/blog?service=updateBlog&blogId=<%= blog.getBlogID() %>" 
                                                                       class="btn btn-warning btn-sm">
                                                                        <i class="fas fa-edit"></i> Update
                                                                    </a>
                                                                    <a href="${pageContext.request.contextPath}/admin/blog?service=deleteBlog&blogId=<%= blog.getBlogID() %>" 
                                                                       class="btn btn-danger btn-sm"
                                                                       onclick="return confirm('Are you sure you want to delete this blog?');">
                                                                        <i class="fas fa-trash"></i> Delete
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        <% } %>
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
