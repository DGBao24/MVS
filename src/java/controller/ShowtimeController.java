package controller;

import entity.Showtime;
import model.DAOShowtime;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ShowtimeController", urlPatterns = {"/admin/showtime"})
public class ShowtimeController extends HttpServlet {
    private DAOShowtime dao;

    @Override
    public void init() throws ServletException {
        dao = new DAOShowtime();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");
        if (service == null) {
            service = "listAll";
        }
        
        switch (service) {
            case "deleteShowtime":
                deleteShowtime(request, response);
                break;
            case "updateShowtime":
                updateShowtime(request, response);
                break;
            case "insertShowtime":
                insertShowtime(request, response);
                break;
            case "listAll":
                listShowtime(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/showtime?service=listAll");
                break;
        }
    }

    private void listShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Showtime> list = dao.getAllShowtimes();
        System.out.println("Retrieved showtimes: " + list.size());  
        request.setAttribute("SHOWTIME_LIST", list);  
        request.getRequestDispatcher("/admin/showtime-management.jsp").forward(request, response);
    }

    private void insertShowtime(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            String submit = request.getParameter("submit");
            if (submit == null) {
                request.getRequestDispatcher("/admin/insertShowtime.jsp").forward(request, response);
            } else {
                int movieID = Integer.parseInt(request.getParameter("MovieID"));
                String startTime = request.getParameter("StartTime");
                String endTime = request.getParameter("EndTime");
                Showtime showtime = new Showtime(0, movieID, startTime, endTime);
                dao.insertShowtime(showtime);
                response.sendRedirect(request.getContextPath() + "/admin/showtime?service=listAll");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Invalid input data");
            request.getRequestDispatcher("/admin/insertShowtime.jsp").forward(request, response);
        }
    }

    private void updateShowtime(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            String submit = request.getParameter("submit");
            if (submit == null) {
                int id = Integer.parseInt(request.getParameter("id"));
                Showtime showtime = dao.getShowtimeByID(id);
                request.setAttribute("showtime", showtime);
                request.getRequestDispatcher("/admin/updateShowtime.jsp").forward(request, response);
            } else {
                int showtimeID = Integer.parseInt(request.getParameter("ShowtimeID"));
                int movieID = Integer.parseInt(request.getParameter("MovieID"));
                String startTime = request.getParameter("StartTime");
                String endTime = request.getParameter("EndTime");
                Showtime showtime = new Showtime(showtimeID, movieID, startTime, endTime);
                dao.updateShowtime(showtime);
                response.sendRedirect(request.getContextPath() + "/admin/showtime?service=listAll");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Invalid input data");
            request.getRequestDispatcher("/admin/updateShowtime.jsp").forward(request, response);
        }
    }

    private void deleteShowtime(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.deleteShowtime(id);
        response.sendRedirect(request.getContextPath() + "/admin/showtime?service=listAll");
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
