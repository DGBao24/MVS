/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Blog;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.util.List;
import java.util.UUID;
import model.BlogDAO;
import model.DAOImage;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
@WebServlet(name = "BlogManageController", urlPatterns = {"/admin/blog"})
public class BlogManageController extends HttpServlet {
    
    private String handleImageUpload(Part filePart, HttpServletRequest request) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        // Check file type
        String fileType = filePart.getContentType();
        if (!fileType.startsWith("image/")) {
            throw new IOException("Chỉ được tải lên file ảnh!");
        }

        // Limit file size (5MB)
        if (filePart.getSize() > 5 * 1024 * 1024) {
            throw new IOException("Dung lượng ảnh quá lớn! (Tối đa 5MB)");
        }

        // Generate unique filename
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = UUID.randomUUID().toString() + extension;

        // Get both deployment and project paths
        String deploymentPath = request.getServletContext().getRealPath("") + File.separator + "images";
        String projectPath = System.getProperty("user.dir") + File.separator + "web" + File.separator + "images";

        // Create directories if they don't exist
        File deploymentDir = new File(deploymentPath);
        File projectDir = new File(projectPath);
        deploymentDir.mkdirs();
        projectDir.mkdirs();

        // Save file in both locations
        String deploymentFilePath = deploymentPath + File.separator + uniqueFileName;
        String projectFilePath = projectPath + File.separator + uniqueFileName;

        filePart.write(deploymentFilePath);
        Files.copy(new File(deploymentFilePath).toPath(), new File(projectFilePath).toPath(), 
                  StandardCopyOption.REPLACE_EXISTING);

        return uniqueFileName;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String service = request.getParameter("service");
        BlogDAO dao = new BlogDAO();
        DAOImage daoImage = new DAOImage();
        
        try {
            if (service == null) {
                service = "listAll";
            }
            
            switch (service) {
                case "listAll":
                    List<Blog> list = dao.getAllBlogs();
                    request.setAttribute("blogList", list);
                    request.getRequestDispatcher("/admin/blog-manage.jsp").forward(request, response);
                    break;
                    
                case "insertBlog":
                    if ("POST".equals(request.getMethod()) && request.getParameter("submit") != null) {
                        try {
                            String title = request.getParameter("Title");
                            String releaseDate = request.getParameter("ReleaseDate");
                            String description = request.getParameter("Description");
                            String status = request.getParameter("Status");
                            
                            // Handle image upload
                            Part filePart = request.getPart("BlogPoster");
                            if (filePart == null || filePart.getSize() == 0) {
                                request.getSession().setAttribute("errorMessage", "Bạn chưa chọn ảnh!");
                                response.sendRedirect(request.getContextPath() + "/admin/blog");
                                return;
                            }

                            String imagePath = handleImageUpload(filePart, request);
                            if (imagePath != null) {
                                // Save new image and get its ID
                                int imageId = daoImage.saveBlogImage(imagePath);
                                Blog blog = new Blog();
                                blog.setTitle(title);
                                blog.setReleaseDate(Date.valueOf(releaseDate));
                                blog.setDescription(description);
                                blog.setStatus(status);
                                blog.setBlogPoster(imageId);
                                
                                dao.insertBlog(blog);
                                request.getSession().setAttribute("successMessage", "Blog thêm mới thành công!");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
                        }
                        response.sendRedirect(request.getContextPath() + "/admin/blog");
                    } else {
                        request.getRequestDispatcher("/admin/insertBlog.jsp").forward(request, response);
                    }
                    break;
                    
                case "updateBlog":
                    if ("POST".equals(request.getMethod()) && request.getParameter("submit") != null) {
                        try {
                            int blogId = Integer.parseInt(request.getParameter("BlogID"));
                            String title = request.getParameter("Title");
                            String releaseDate = request.getParameter("ReleaseDate");
                            String description = request.getParameter("Description");
                            String status = request.getParameter("Status");
                            
                            Blog blog = dao.getBlogById(blogId);
                            if (blog != null) {
                                // Handle image upload
                                Part filePart = request.getPart("BlogPoster");
                                String newImagePath = null;
                                int imageId = blog.getBlogPoster();

                                if (filePart != null && filePart.getSize() > 0) {
                                    newImagePath = handleImageUpload(filePart, request);
                                    if (newImagePath != null) {
                                        // Save new image and get its ID
                                        imageId = daoImage.saveBlogImage(newImagePath);
                                    }
                                }
                                
                                // Update blog details
                                blog.setTitle(title);
                                blog.setReleaseDate(Date.valueOf(releaseDate));
                                blog.setDescription(description);
                                blog.setStatus(status);
                                blog.setBlogPoster(imageId);
                                
                                dao.updateBlog(blog);
                                request.getSession().setAttribute("successMessage", "Blog cập nhật thành công!");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
                        }
                        response.sendRedirect(request.getContextPath() + "/admin/blog");
                    } else {
                        int blogId = Integer.parseInt(request.getParameter("blogId"));
                        Blog blog = dao.getBlogById(blogId);
                        if (blog != null) {
                            request.setAttribute("blog", blog);
                            request.getRequestDispatcher("/admin/updateBlog.jsp").forward(request, response);
                        } else {
                            request.getSession().setAttribute("errorMessage", "Không tìm thấy blog");
                            response.sendRedirect(request.getContextPath() + "/admin/blog");
                        }
                    }
                    break;
                    
                case "deleteBlog":
                    try {
                        int blogId = Integer.parseInt(request.getParameter("blogId"));
                        Blog blog = dao.getBlogById(blogId);
                        if (blog != null) {
                            // Delete image file if exists
                            if (blog.getBlogPoster() > 0) {
                                String imagePath = daoImage.getImagePathById(blog.getBlogPoster());
                                if (imagePath != null && !imagePath.isEmpty()) {
                                    String deploymentPath = request.getServletContext().getRealPath("") + File.separator + "images";
                                    String projectPath = System.getProperty("user.dir") + File.separator + "web" + File.separator + "images";
                                    
                                    // Delete from both locations
                                    File deploymentFile = new File(deploymentPath + File.separator + imagePath);
                                    File projectFile = new File(projectPath + File.separator + imagePath);
                                    
                                    if (deploymentFile.exists()) deploymentFile.delete();
                                    if (projectFile.exists()) projectFile.delete();
                                    
                                    daoImage.deleteImage(blog.getBlogPoster());
                                }
                            }
                            
                            dao.deleteBlog(blogId);
                            request.getSession().setAttribute("successMessage", "Blog xóa thành công!");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/blog");
                    break;
                    
                case "updateStatus":
                    try {
                        int blogId = Integer.parseInt(request.getParameter("blogId"));
                        String newStatus = request.getParameter("newStatus");
                        dao.updateBlogStatus(blogId, newStatus);
                        request.getSession().setAttribute("successMessage", "Trạng thái blog cập nhật thành công!");
                    } catch (Exception e) {
                        e.printStackTrace();
                        request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/blog");
                    break;
                    
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/blog");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/blog");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
