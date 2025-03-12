/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import model.MovieDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import entity.Movie;

/**
 *
 * @author jun
 */
@WebServlet(name="MovieController", urlPatterns={"/MovieController"})
public class MovieController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");    
        try {
            MovieDAO dao = new MovieDAO();
            if (service == null || service.equals("list")) {
                // Get now showing movies
                List<Movie> showingMovies = dao.getListShowingMovie();
                System.out.println("Now Showing Movies count: " + (showingMovies != null ? showingMovies.size() : 0));
                request.setAttribute("listShowing", showingMovies);
                
                // Get upcoming movies
                List<Movie> upcomingMovies = dao.getListUpcomingMovie();
                System.out.println("Upcoming Movies count: " + (upcomingMovies != null ? upcomingMovies.size() : 0));
                request.setAttribute("listUpcoming", upcomingMovies);
                
                // Forward to the movie list page
                request.getRequestDispatcher("movie.jsp").forward(request, response);
            } else if (service.equals("detail")) {
                int movieId = Integer.parseInt(request.getParameter("id"));
                Movie movie = dao.getMovieById(movieId);
                request.setAttribute("moviedetail", movie);
                request.getRequestDispatcher("detailmovie.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Log the error and set an error message
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
        return "Movie Controller for managing movie listings and details";
    }
}
