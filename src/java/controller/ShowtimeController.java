package controller;

import entity.Showtime;
import model.DAOShowtime;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ShowtimeController", urlPatterns = {"/admin/showtime"})
public class ShowtimeController extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");
        DAOShowtime dao = new DAOShowtime();
        
        if (service == null) {
            service = "listAll";
        }
        
        switch (service) {
            case "deleteShowtime":
                dao.deleteShowtime(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect(request.getContextPath() + "/admin/showtime?service=listAll");
                break;
            
            case "updateShowtime":
                String submitUpdate = request.getParameter("submit");
                if (submitUpdate == null) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Showtime showtime = dao.getShowtimeByID(id);
                    request.setAttribute("showtime", showtime);
                    request.getRequestDispatcher("/admin/updateShowtime.jsp").forward(request, response);
                } else {
                    try {
                        int showtimeID = Integer.parseInt(request.getParameter("ShowtimeID"));
                        int movieID = Integer.parseInt(request.getParameter("MovieID"));
                        Timestamp startTime = Timestamp.valueOf(request.getParameter("StartTime"));
                        Timestamp endTime = Timestamp.valueOf(request.getParameter("EndTime"));
                        
                        Showtime showtime = new Showtime(showtimeID, movieID, startTime, endTime);
                        int n = dao.updateShowtime(showtime);
                        
                        if (n > 0) {
                            request.getSession().setAttribute("successMessage", "Showtime updated successfully!");
                        } else {
                            request.getSession().setAttribute("errorMessage", "Failed to update showtime");
                        }
                        response.sendRedirect(request.getContextPath() + "/admin/showtime?service=listAll");
                    } catch (Exception e) {
                        request.getSession().setAttribute("errorMessage", "Invalid input data");
                        response.sendRedirect(request.getContextPath() + "/admin/showtime?service=listAll");
                    }
                }
                break;
                
            case "insertShowtime":
    String submitInsert = request.getParameter("submit");
    if (submitInsert == null) {
        request.getRequestDispatcher("/admin/insertShowtime.jsp").forward(request, response);
    } else {
        try {
            int movieID = Integer.parseInt(request.getParameter("MovieID"));
            Timestamp startTime = Timestamp.valueOf(request.getParameter("StartTime").replace("T", " ") + ":00");
            Timestamp endTime = Timestamp.valueOf(request.getParameter("EndTime").replace("T", " ") + ":00");

            Showtime showtime = new Showtime(movieID, startTime, endTime);
            int n = dao.insertShowtime(showtime);

            if (n > 0) {
                request.getSession().setAttribute("successMessage", "Showtime added successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to insert showtime");
            }
            response.sendRedirect(request.getContextPath() + "/admin/showtime?service=listAll");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Invalid input data");
            response.sendRedirect(request.getContextPath() + "/admin/showtime?service=listAll");
        }
    }
    break;

                
            case "listAll":
                List<Showtime> list = dao.getAllShowtimes();
                request.setAttribute("SHOWTIME_LIST", list);
                request.getRequestDispatcher("/admin/showtime-management.jsp").forward(request, response);
                break;
                
            default:
                response.sendRedirect(request.getContextPath() + "/admin/showtime?service=listAll");
                break;
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
