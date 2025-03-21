/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.sql.ResultSet;
import entity.Movie;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.List;
import java.util.UUID;
import model.DAOImage;
import model.MovieDAO;
import jakarta.servlet.annotation.MultipartConfig;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

/**
 *
 * @author pdatt
 */
@WebServlet(name = "AdminMovieController", urlPatterns = {"/admin/movie"})
@MultipartConfig
public class AdminMovieController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            DAOImage daoImage = new DAOImage();
            if (service == null) {
                service = "listAll";
            }
            if (service.equals("updateMovie")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    int mID = Integer.parseInt(request.getParameter("mID"));
                    Movie movie = dao.getMovieById(mID);
                    request.setAttribute("movie", movie);
                    request.getRequestDispatcher("/admin/updateMovie.jsp").forward(request, response);
                    return;
                } else {
                    try {
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

                        Part filePart = request.getPart("MoviePoster");
                        String imageId = null;

                       if (filePart != null && filePart.getSize() > 0) {
    // Handle new image upload
    String deploymentPath = request.getServletContext().getRealPath("") + File.separator + "images";
    String projectPath = System.getProperty("user.dir") + File.separator + "web" + File.separator + "images";

    // Create directories if they don't exist
    File deploymentDir = new File(deploymentPath);
    File projectDir = new File(projectPath);
    deploymentDir.mkdirs();
    projectDir.mkdirs();

    // Generate unique filename
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    String extension = fileName.substring(fileName.lastIndexOf("."));
    String uniqueFileName = UUID.randomUUID().toString() + extension;

    // Save file in both locations
    String deploymentFilePath = deploymentPath + File.separator + uniqueFileName;
    String projectFilePath = projectPath + File.separator + uniqueFileName;

    filePart.write(deploymentFilePath);
    Files.copy(new File(deploymentFilePath).toPath(), new File(projectFilePath).toPath(), 
              StandardCopyOption.REPLACE_EXISTING);

    // Save image to database
    imageId = String.valueOf(daoImage.saveMovieImage(uniqueFileName));
} else {
    // Keep existing image if no new image is uploaded
    Movie existingMovie = dao.getMovieById(MovieID);
    if (existingMovie != null) {
        imageId = existingMovie.getMoviePoster();
        System.out.println("Using existing image ID: " + imageId);
    } else {
        System.out.println("Error: Could not find existing movie with ID: " + MovieID);
        request.getSession().setAttribute("errorMessage", "Error: Could not find existing movie.");
        response.sendRedirect(request.getContextPath() + "/admin/movie");
        return;
    }
}

                        // Create the updated movie object
                        Movie updatedMovie = new Movie(MovieID, MovieName, Duration, Genre, Director,
                                ReleaseDate, Description, Rate, imageId,
                                TrailerURL, BasePrice, Status);

                        // Debug information
                        System.out.println("Updating movie with ID: " + MovieID);
                        System.out.println("Movie Name: " + MovieName);
                        System.out.println("Image ID/Path: " + imageId);

                        int n = dao.updateMovie(updatedMovie);

                        if (n > 0) {
                            System.out.println("Movie updated successfully!");
                            request.getSession().setAttribute("successMessage", "Movie updated successfully!");
                        } else {
                            System.out.println("Failed to update movie. No rows affected.");
                            request.getSession().setAttribute("errorMessage", "Failed to update movie. Database operation returned 0 rows affected.");
                        }

                        response.sendRedirect(request.getContextPath() + "/admin/movie");
                        return;

                    } catch (Exception e) {
                        e.printStackTrace();
                        System.out.println("Error updating movie: " + e.getMessage());
                        request.getSession().setAttribute("errorMessage", "Error updating movie: " + e.getMessage());
                        response.sendRedirect(request.getContextPath() + "/admin/movie");
                        return;
                    }
                }
            }
            if (service.equals("insertMovie")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    ResultSet rsStatus = dao.getData("SELECT DISTINCT [Status] FROM [swp391].[dbo].[Movie]");
                    request.setAttribute("rsStatus", rsStatus);
                    request.getRequestDispatcher("/admin/movie-management.jsp").forward(request, response);
                    return;
                }

                try {
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

                    Part filePart = request.getPart("MoviePoster");
                    // Validate file
                    if (filePart == null || filePart.getSize() == 0) {
                        request.getSession().setAttribute("errorMessage", "Bạn chưa chọn ảnh!");
                        response.sendRedirect(request.getContextPath() + "/admin/movie");
                        return;
                    }

                    String fileType = filePart.getContentType();
                    if (!fileType.startsWith("image/")) {
                        request.getSession().setAttribute("errorMessage", "Chỉ được tải lên file ảnh!");
                        response.sendRedirect(request.getContextPath() + "/admin/movie");
                        return;
                    }

                    if (filePart.getSize() > 5 * 1024 * 1024) {
                        request.getSession().setAttribute("errorMessage", "Dung lượng ảnh quá lớn! (Tối đa 5MB)");
                        response.sendRedirect(request.getContextPath() + "/admin/movie");
                        return;
                    }

                    // Get both deployment and project paths
                    String deploymentPath = request.getServletContext().getRealPath("") + File.separator + "images";
                    String projectPath = System.getProperty("user.dir") + File.separator + "web" + File.separator + "images";

                    // Create directories if they don't exist
                    File deploymentDir = new File(deploymentPath);
                    File projectDir = new File(projectPath);
                    if (!deploymentDir.exists()) {
                        deploymentDir.mkdirs();
                    }
                    if (!projectDir.exists()) {
                        projectDir.mkdirs();
                    }

                    // Generate unique filename
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String extension = fileName.substring(fileName.lastIndexOf("."));
                    String uniqueFileName = UUID.randomUUID().toString() + extension;

                    // Save file in both locations
                    String deploymentFilePath = deploymentPath + File.separator + uniqueFileName;
                    String projectFilePath = projectPath + File.separator + uniqueFileName;

                    // Write to deployment directory
                    filePart.write(deploymentFilePath);

                    // Copy to project directory
                    try {
                        Files.copy(new File(deploymentFilePath).toPath(), new File(projectFilePath).toPath(),
                                StandardCopyOption.REPLACE_EXISTING);
                    } catch (IOException e) {
                        e.printStackTrace();
                        request.getSession().setAttribute("errorMessage", "Error copying file to project directory");
                        response.sendRedirect(request.getContextPath() + "/admin/movie");
                        return;
                    }

                    // Store just the filename in the database
                    String databasePath = uniqueFileName;
                    int imageId = daoImage.saveMovieImage(databasePath);

                    if (imageId == -1) {
                        request.getSession().setAttribute("errorMessage", "Lỗi khi lưu ảnh, vui lòng thử lại.");
                        response.sendRedirect(request.getContextPath() + "/admin/movie");
                        return;
                    }

                    // Create new Movie object with the imageId as an integer
                    Movie newMovie = new Movie(MovieName, Duration, Genre, Director, ReleaseDate, Description, Rate, String.valueOf(imageId), TrailerURL, BasePrice, Status);

                    int n = dao.insertMovie(newMovie);

                    if (n > 0) {
                        request.getSession().setAttribute("successMessage", "Movie added successfully!");
                    } else {
                        request.getSession().setAttribute("errorMessage", "Failed to add movie to database.");
                    }

                    response.sendRedirect(request.getContextPath() + "/admin/movie");
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("Error in insertMovie: " + e.getMessage());
                    request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/admin/movie");
                    return;
                }
            }
//
//            String sql = "Select*from Movie";
            String sql = "SELECT m.MovieID, m.MovieName, m.Duration, m.Genre, m.Director, m.ReleaseDate, "
                    + "m.Description, m.Rate, i.ImagePath, m.TrailerURL, m.BasePrice, m.Status "
                    + "FROM [dbo].[Movie] m "
                    + "JOIN Image i ON m.MoviePoster = i.ImageID";
            List<Movie> list = dao.getMovie(sql);
            request.setAttribute("listMovie", list);

            request.getRequestDispatcher("/admin/movie-management.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
