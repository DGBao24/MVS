package controller;

import entity.Account;
import entity.Cinema;
import entity.Movie;
import entity.Promotion;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.CinemaDAO;
import model.DAOAccount;
import model.DAOPromotion;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.BookingDAO;
import model.MovieDAO;

@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    MovieDAO mov = new MovieDAO();
    BookingDAO pro = new BookingDAO();

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        String service = request.getParameter("service");
        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if (!account.getRole().equals("Admin") && !account.getRole().equals("Manager")) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }

        if (service == null || service.equals("list")) {
            try {
                List<Movie> movList = mov.getMovie("SELECT * FROM Movie");
                request.setAttribute("listMov", movList);

                // Lấy tổng số phim
                ResultSet rsTotalMovies = mov.getData("SELECT COUNT(*) AS TotalMovies FROM [Movie]");
                if (rsTotalMovies.next()) {
                    request.setAttribute("TotalMovies", rsTotalMovies.getInt("TotalMovies"));
                }

                // Lấy tổng doanh thu
                ResultSet rsTotalRevenue = pro.getData("SELECT SUM(TotalAmount) AS TotalRevenue FROM [Order] where Status like '%Complete%'");
                if (rsTotalRevenue.next()) {
                    request.setAttribute("TotalRevenue", rsTotalRevenue.getDouble("TotalRevenue"));
                }

                request.getRequestDispatcher("/admin/indexAdmin.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (service.equals("ViewRevenue")) {
            String movieID = request.getParameter("movieID");

            // Query doanh thu của 12 tháng
            String query = """
                   SELECT m.Month, COALESCE(SUM(o.TotalAmount), 0) AS TotalSales
                   FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12)) AS m(Month)
                   LEFT JOIN [Order] o ON DATEPART(MONTH, o.OrderDate) = m.Month AND o.Status = 'Completed'
                   """;

            if (movieID != null && !movieID.isEmpty()) {
                query += " AND OrderID IN (SELECT o.OrderID FROM [Order] o "
                        + "JOIN Ticket t ON o.OrderID = t.OrderID "
                        + "JOIN ShowTime s ON t.ShowtimeID = s.ShowTimeID "
                        + "WHERE s.MovieID = " + movieID + ")";
            }

            query += """
                      GROUP BY m.Month
                      ORDER BY m.Month""";

            ResultSet rsRev = pro.getData(query);
            List<Movie> movieList = mov.getMovie("SELECT * FROM Movie");

            request.setAttribute("Rev", rsRev);
            request.setAttribute("listMov", movieList);
            request.getRequestDispatcher("admin/Revenue.jsp").forward(request, response);
        }
    }
}
