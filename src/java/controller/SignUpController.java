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
import model.DAOAccount;
import utils.Validation;

/**
 *
 * @author pdatt
 */
@WebServlet(name = "SignUpController", urlPatterns = {"/signup"})
public class SignUpController extends HttpServlet {

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
        DAOAccount dao = new DAOAccount();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String re_password = request.getParameter("confirm_password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String yearOfBirth = request.getParameter("yearOfBirth");
        String gender = request.getParameter("Gender");
        try {
            int YOB = Integer.parseInt(yearOfBirth);

            // Check if passwords match
            if (!password.equals(re_password)) {
                request.setAttribute("mess", "Your password does not match.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            // Check if email exists
            if (dao.isEmailExist(email)) {
                request.setAttribute("mess", "This email is already existed! Please try another email!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            
            if(!Validation.checkPassWord(password)){
                request.setAttribute("mess", "Password must have at least 6 characters, including uppercase letters, lowercase letters, and special characters");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            
             if (dao.isEmailExist(email)) {
                request.setAttribute("mess", "This email is already existed! Please try another email!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
             //Check if phone number exists
            if (dao.isPhoneExist(phone)){
                request.setAttribute("mess", "This phone number is already existed!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            
            if (!Validation.checkPhoneNum(phone)) {
                request.setAttribute("mess", "Invalid phone number. Please enter a valid Vietnamese phone number.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            // Create new account
            int result = dao.createAccount(new Account(name, email, password, phone, address, YOB, true, "Customer",gender));
            
            if (result > 0) {
                // Success - redirect to home
                response.sendRedirect("home");
            } else {
                // Failed to create account
                request.setAttribute("mess", "Failed to create account. Please try again.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("mess", "Invalid year of birth format.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("mess", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("signup.jsp").forward(request, response);
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
