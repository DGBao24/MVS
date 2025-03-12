package controller;

import model.CinemaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.Cinema;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CinemaManageController", urlPatterns = {"/CinemaManageController"})
public class CinemaManageController extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }
        
        CinemaDAO dao = new CinemaDAO();
        
        try {
            switch (action) {
                case "list":
                    listCinemas(request, response, dao);
                    break;
                case "edit":
                    editCinema(request, response, dao);
                    break;
                case "update":
                    updateCinema(request, response, dao);
                    break;
                case "insert":
                    insertCinema(request, response, dao);
                    break;
                default:
                    response.sendRedirect("error.jsp");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void listCinemas(HttpServletRequest request, HttpServletResponse response, CinemaDAO dao) 
            throws ServletException, IOException {
        List<Cinema> cinemas = dao.getAllCinemas();
        request.setAttribute("CINEMA_LIST", cinemas);
        request.getRequestDispatcher("/admin/cinemamanage.jsp").forward(request, response);
    }

    private void editCinema(HttpServletRequest request, HttpServletResponse response, CinemaDAO dao) 
            throws ServletException, IOException {
        try {
            int cinemaID = Integer.parseInt(request.getParameter("cinemaID"));
            Cinema cinema = dao.getCinemaById(cinemaID);
            
            if (cinema != null) {
                request.setAttribute("cinema", cinema);
                request.getRequestDispatcher("/admin/cinemaupdate.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
        }
    }

    private void updateCinema(HttpServletRequest request, HttpServletResponse response, CinemaDAO dao) 
            throws IOException, ServletException {
        try {
            int cinemaID = Integer.parseInt(request.getParameter("cinemaID"));
            String cinemaName = request.getParameter("cinemaName").trim();
            String address = request.getParameter("address").trim();

            if (cinemaName.isEmpty() || address.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Cinema Name and Address cannot be empty.");
                response.sendRedirect("CinemaManageController?action=edit&cinemaID=" + cinemaID);
                return;
            }

            Cinema cinema = new Cinema(cinemaID, cinemaName, address);
            int updated = dao.updateCinema(cinema);

            if (updated > 0) {
                request.getSession().setAttribute("successMessage", "Cinema updated successfully!");
                request.setAttribute("cinema", cinema);
                request.getRequestDispatcher("/admin/cinemaupdate.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update cinema!");
                response.sendRedirect("CinemaManageController?action=edit&cinemaID=" + cinemaID);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void insertCinema(HttpServletRequest request, HttpServletResponse response, CinemaDAO dao) 
            throws ServletException, IOException {
        String cinemaName = request.getParameter("cinemaName").trim();
        String address = request.getParameter("address").trim();

        if (cinemaName.isEmpty() || address.isEmpty()) {
            request.setAttribute("error", "Cinema Name and Address cannot be empty.");
            request.getRequestDispatcher("/admin/cinemacreate.jsp").forward(request, response);
            return;
        }

        Cinema cinema = new Cinema();
        cinema.setCinemaName(cinemaName);
        cinema.setAddress(address);

        if (dao.insertCinema(cinema)) {
            request.getSession().setAttribute("successMessage", "Cinema created successfully.");
            response.sendRedirect("CinemaManageController?action=list");
        } else {
            request.setAttribute("error", "Cinema Name or Address already exists.");
            request.getRequestDispatcher("/admin/cinemacreate.jsp").forward(request, response);
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
        return "Cinema Management Controller";
    }
}