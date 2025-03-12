package controller;

import entity.Account;
import entity.Cinema;
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

@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        
        try {
            
            
            if (account == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            
            if (!account.getRole().equals("Admin") && !account.getRole().equals("Manager")) {
                response.sendRedirect(request.getContextPath() + "/Error.jsp");
                return;
            }
            
            // Initialize DAOs
            DAOAccount acc = new DAOAccount();
            CinemaDAO cin = new CinemaDAO();
            DAOPromotion pro = new DAOPromotion();
            
            try {
                // Get all data
                List<Account> accList = acc.getAllCustomers("select * from Account");
                List<Cinema> cinList = cin.getAllCinemas();
                List<Promotion> proList = pro.getPromotion("select * from Promotion");
                
                // Set attributes
                request.setAttribute("listAcc", accList);
                request.setAttribute("listCin", cinList);
                request.setAttribute("listPro", proList);
                
                // Forward to admin dashboard
                request.getRequestDispatcher("/admin/indexAdmin.jsp").forward(request, response);
            } catch (Exception e) {
                // Log the error and set error message
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error loading dashboard data: " + e.getMessage());
                request.getRequestDispatcher("/admin/indexAdmin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Error.jsp");
        }
    
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
