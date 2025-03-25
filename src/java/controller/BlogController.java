/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Blog;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BlogDAO;

/**
 *
 * @author jun
 */
@WebServlet(name = "BlogController", urlPatterns = {"/BlogController"})
public class BlogController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        BlogDAO dao = new BlogDAO();
        
        try {
            if (action == null || action.equals("list")) {
                // Get only active blogs for public view
                List<Blog> blogs = dao.getActiveBlogs();
                request.setAttribute("blogList", blogs);
                request.getRequestDispatcher("Blog.jsp").forward(request, response);
            } else if (action.equals("detail")) {
                // Get blog detail
                int blogId = Integer.parseInt(request.getParameter("id"));
                Blog blog = dao.getBlogById(blogId);
                // Only show active blogs in detail view
                if (blog != null && blog.getStatus().equals("1")) {
                    request.setAttribute("blog", blog);
                    request.getRequestDispatcher("BlogDetail.jsp").forward(request, response);
                } else {
                    response.sendRedirect("BlogController?action=list");
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            response.sendRedirect("error.jsp");
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

    @Override
    public String getServletInfo() {
        return "Blog Controller";
    }
}
