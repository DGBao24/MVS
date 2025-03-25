/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Account;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOAccount;
import utils.BCrypt;

/**
 *
 * @author pdatt
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

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
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // If no email/password, show login form
        if (email == null || password == null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        DAOAccount dao = new DAOAccount();
        
        // Get stored hashed password from the database
        String storedHashedPassword = dao.getPasswordByEmail(email);

        // Handle case where email is not found
        if (storedHashedPassword == null) {
            request.setAttribute("mess", "Wrong email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Verify password with BCrypt
        boolean isPasswordMatch = BCrypt.checkpw(password, storedHashedPassword);
        Account account = dao.AccountLogin(email, storedHashedPassword);

        // Check if account is null or password does not match
        if (account == null || !isPasswordMatch) {
            request.setAttribute("mess", "Wrong email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        if (!account.isStatus()) {
            request.setAttribute("mess", "Your account has been disabled");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Login successful
        HttpSession session = request.getSession();
        session.setAttribute("account", account);
        session.setAttribute("CustomerID", account.getAccountID());
        
        // Check for return URL
        String returnUrl = (String) session.getAttribute("returnUrl");
        session.removeAttribute("returnUrl"); // Clear it after use
        
        if (returnUrl != null) {
            // Return to the originally requested URL
            response.sendRedirect(returnUrl);
        } else {
            // Default redirect based on role
            if (account.getRole().equals("Admin") || account.getRole().equals("Manager")) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        }
    }

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
        return "Login Controller";
    }
}
