/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Combo;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAOCombo;

/**
 *
 * @author pdatt
 */
@WebServlet(name = "ComboManagement", urlPatterns = {"/admin/combo"})
public class ComboController extends HttpServlet {

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
            DAOCombo dao = new DAOCombo();
            if (service == null){
                service = "listAll";
            }
            
            if (service.equals("deleteCombo")){
                dao.deleteCombo(Integer.parseInt(request.getParameter("cid")));
                response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
            }
            
            if (service.equals("updateCombo")){
                String submit = request.getParameter("submit");
                if (submit == null){
                    int cid = Integer.parseInt(request.getParameter("cid"));
                    List<Combo> list = dao.getCombo("SELECT * FROM [swp391].[dbo].[Combo] where ComboID = " + cid);
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("/admin/updateCombo.jsp").forward(request, response);
                } else {
                    try {
                        // Get and validate all parameters
                        String comboIdStr = request.getParameter("ComboID");
                        String comboItem = request.getParameter("ComboItem");
                        String description = request.getParameter("Description");
                        String priceStr = request.getParameter("Price");
                        String quantityStr = request.getParameter("Quantity");
                        String statusStr = request.getParameter("Status");
                        
                        // Check for null parameters
                        if (comboIdStr == null || comboItem == null || description == null || 
                            priceStr == null || quantityStr == null || statusStr == null) {
                            request.getSession().setAttribute("errorMessage", "Missing required fields");
                            response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                            return;
                        }
                        
                        // Parse numeric values
                        int cid = Integer.parseInt(comboIdStr);
                        float price = Float.parseFloat(priceStr);
                        int quantity = Integer.parseInt(quantityStr);
                        boolean status = Boolean.parseBoolean(statusStr);
                        
                        // Validate values
                        if (comboItem.trim().isEmpty() || description.trim().isEmpty() ||
                            price <= 0 || quantity < 0) {
                            request.getSession().setAttribute("errorMessage", "Invalid input values");
                            response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                            return;
                        }
                        
                        // Update combo
                        Combo combo = new Combo(cid, comboItem, description, price, quantity, status);
                        int n = dao.updateCombo(combo);
                        
                        if (n > 0) {
                            request.getSession().setAttribute("successMessage", "Combo updated successfully!");
                        } else {
                            request.getSession().setAttribute("errorMessage", "Failed to update combo");
                        }
                        response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                        
                    } catch (NumberFormatException e) {
                        request.getSession().setAttribute("errorMessage", "Invalid number format: " + e.getMessage());
                        response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                    } catch (Exception e) {
                        request.getSession().setAttribute("errorMessage", "Error updating combo: " + e.getMessage());
                        response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                    }
                }
            }
            
            if (service.equals("insertCombo")){
                String submit = request.getParameter("submit");
                if (submit == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                } else {
                    try {
                        String ComboItem = request.getParameter("ComboItem");
                        String Description = request.getParameter("Description");
                        float Price = Float.parseFloat(request.getParameter("Price"));
                        int Quantity = Integer.parseInt(request.getParameter("Quantity"));
                        boolean Status = request.getParameter("Status").equals("1");
                        
                        if (ComboItem == null || ComboItem.trim().isEmpty() ||
                            Description == null || Description.trim().isEmpty() ||
                            Price <= 0) {
                            request.getSession().setAttribute("errorMessage", "Invalid input data");
                            response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                            return;
                        }
                        
                        int n = dao.insertCombo(new Combo(ComboItem, Description, Price, Quantity, Status));
                        if (n > 0) {
                            request.getSession().setAttribute("successMessage", "Combo added successfully!");
                            response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                        } else {
                            request.getSession().setAttribute("errorMessage", "Failed to insert combo");
                            response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                        }
                    } catch (NumberFormatException e) {
                        request.getSession().setAttribute("errorMessage", "Invalid number format");
                        response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                    }
                }
            }
            
            if (service.equals("listAll")){
                String sql = "select* from Combo";
                List<Combo> list = dao.getCombo(sql);
                request.setAttribute("list", list);
                request.getRequestDispatcher("/admin/combo-management.jsp").forward(request, response);
            }
            
             if (service.equals("DisableStatus")) {
                int cid = Integer.parseInt(request.getParameter("cid"));
                String submit = request.getParameter("submit");

                // Get current combo info
                Combo combo = dao.getComboByID(cid);

                if (submit != null) {
                    if (combo == null) {
                        request.setAttribute("errorMessage", "Cannot find Combo");
                        response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                        return;
                    }

                    // Toggle the status
                    boolean newStatus = !combo.isStatus();
                    int updated = dao.updateCombo(new Combo(cid, combo.getComboItem(), combo.getDescription(), 
                                                          combo.getPrice(), combo.getQuantity(), newStatus));

                    if (updated > 0) {
                        request.getSession().setAttribute("successMessage", "Status updated successfully!");
                    } else {
                        request.getSession().setAttribute("errorMessage", "Failed to update status!");
                    }

                    response.sendRedirect(request.getContextPath() + "/admin/combo?service=listAll");
                } else {
                    List<Combo> list = dao.getCombo("SELECT * FROM Combo");
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("/admin/combo-management.jsp").forward(request, response);
                }
            }
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
