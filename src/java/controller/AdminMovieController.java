/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import entity.Movie;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.List;
import model.MovieDAO;

/**
 *
 * @author pdatt
 */
@WebServlet(name="AdminMovieController", urlPatterns={"/admin/movie"})
public class AdminMovieController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String service = request.getParameter("service");
            MovieDAO dao = new MovieDAO();
            if (service == null){
                service = "listAll";
            }
            if (service.equals("updateMovie")){
                String submit = request.getParameter("submit");
                if (submit == null){
                    int mID = Integer.parseInt(request.getParameter("mID"));
                    List<Movie> list = dao.getMovie("SELECT*FROM [dbo].[Movie] where MovieID = " + mID);
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("/admin/updateMovie.jsp").forward(request, response);
                    return;
                } else {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    int MovieID = Integer.parseInt(request.getParameter("MovieID"));
                    String MovieName = request.getParameter("MovieName");
                    int Duration = Integer.parseInt(request.getParameter("Duration"));
                    String Genre = request.getParameter("Genre");
                    String Director = request.getParameter("Director");
                    String Releasedate = request.getParameter("ReleaseDate");
                    Date ReleaseDate = Date.valueOf(Releasedate);
                    String Description = request.getParameter("Description");
                    String Rate = request.getParameter("Rate");
                    String TrailerURL = request.getParameter("TrailerURL");
                    int BasePrice = Integer.parseInt(request.getParameter("BasePrice"));
                    String Status = request.getParameter("Status"); 
                    int n = dao.updateMovie(new Movie(MovieID, MovieName, Duration, Genre, Director, ReleaseDate, Description, Rate, TrailerURL, BasePrice, Status));
                    response.sendRedirect(request.getContextPath() + "/admin/movie?service=listAll");
                    return;
                }
            }
                if (service.equals("insertMovie")){
                    String submit = request.getParameter("submit");
                    if (submit == null){
                        request.getRequestDispatcher("/admin/movie-managemnet.jsp").forward(request, response);
                    }
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    String MovieName = request.getParameter("MovieName");
                    int Duration = Integer.parseInt(request.getParameter("Duration"));
                    String Genre = request.getParameter("Genre");
                    String Director = request.getParameter("Director");
                    String Releasedate = request.getParameter("ReleaseDate");
                    Date ReleaseDate = Date.valueOf(Releasedate);
                    String Description = request.getParameter("Description");
                    String Rate = request.getParameter("Rate");
                    String TrailerURL = request.getParameter("TrailerURL");
                    int BasePrice = Integer.parseInt(request.getParameter("BasePrice"));
                    String Status = request.getParameter("Status"); 
                    int n = dao.insertMovie(new Movie(MovieName, Duration, Genre, Director, ReleaseDate, Description, Rate, TrailerURL, BasePrice, Status));
                    response.sendRedirect(request.getContextPath() + "/admin/movie");
                }
                String sql = "Select*from Movie";
                List<Movie> list = dao.getMovie(sql);
                request.setAttribute("listMovie", list);
                request.getRequestDispatcher("/admin/movie-management.jsp").forward(request, response);
            }
        }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
