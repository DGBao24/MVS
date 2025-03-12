/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Promotion;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import model.DAOPromotion;

/**
 *
 * @author pdatt
 */
@WebServlet(name = "PromotionController", urlPatterns = {"/admin/promo", "/PromotionController"})
public class PromotionController extends HttpServlet {

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
        DAOPromotion dao = new DAOPromotion();
        
        // Check if this is an admin route
        boolean isAdminRoute = request.getRequestURI().contains("/admin/");
        
        String service = request.getParameter("service");
        if (service == null){
            service = isAdminRoute ? "listAll" : "publicList";
        }
        
        try {
            // Handle public promotion list view
            if (service.equals("publicList")) {
                String sql = "SELECT * FROM Promotion WHERE Status = 1 AND EndDate >= GETDATE() ORDER BY StartDate DESC";
                List<Promotion> promotions = dao.getPromotion(sql);
                request.setAttribute("promotionList", promotions);
                request.getRequestDispatcher("/promotion.jsp").forward(request, response);
                return;
            }
            
            // Admin routes below this point
            if (!isAdminRoute) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            
            if (service.equals("deletePromotion")){
                dao.deletePromotion(Integer.parseInt(request.getParameter("pid")));
                response.sendRedirect(request.getContextPath() + "/admin/promo?service=listAll");
                return;
            }
            
            if (service.equals("updatePromotion")){
                String submit = request.getParameter("submit");
                if (submit == null){
                    int pid = Integer.parseInt(request.getParameter("pid"));
                    List<Promotion> list = dao.getPromotion("SELECT * FROM [swp391].[dbo].[Promotion] where PromotionID = " + pid);
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("/admin/updatePromotion.jsp").forward(request, response);
                    return;
                } else {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    int PromotionID = Integer.parseInt(request.getParameter("PromotionID"));
                    String PromoCode = request.getParameter("PromoCode");
                    int DiscountPercent = Integer.parseInt(request.getParameter("DiscountPercent"));
                    String Startdate = request.getParameter("StartDate"); 
                    Date StartDate = Date.valueOf(Startdate);
                    String Enddate = request.getParameter("EndDate");
                    Date EndDate = Date.valueOf(Enddate);
                    boolean Status = Boolean.parseBoolean(request.getParameter("Status"));
                    String Description = request.getParameter("Description");
                    int RemainRedemption = Integer.parseInt(request.getParameter("RemainRedemption"));
                    Promotion promotion = new Promotion(PromotionID, PromoCode, DiscountPercent, StartDate, EndDate, Status, Description, RemainRedemption);
                    int n = dao.updatePromotion(promotion);
                    response.sendRedirect(request.getContextPath() + "/admin/promo?service=listAll");
                    return;
                }
            }
            
            if (service.equals("insertPromotion")){
                String submit = request.getParameter("submit");
                if (submit == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/promo?service=listAll");
                    return;
                } else {
                    try {
                        String PromoCode = request.getParameter("PromoCode");
                        int DiscountPercent = Integer.parseInt(request.getParameter("DiscountPercent"));
                        String Startdate = request.getParameter("StartDate"); 
                        Date StartDate = Date.valueOf(Startdate);
                        String Enddate = request.getParameter("EndDate");
                        Date EndDate = Date.valueOf(Enddate);
                        boolean Status = Boolean.parseBoolean(request.getParameter("Status"));
                        String Description = request.getParameter("Description");
                        int RemainRedemption = Integer.parseInt(request.getParameter("RemainRedemption"));
                        
                        // Validate inputs
                        if (PromoCode == null || PromoCode.trim().isEmpty() ||
                            Description == null || Description.trim().isEmpty() ||
                            DiscountPercent <= 0 || DiscountPercent > 100 ||
                            RemainRedemption < 0 ||
                            StartDate.after(EndDate)) {
                            request.setAttribute("error", "Invalid input data");
                            response.sendRedirect(request.getContextPath() + "/admin/promo?service=listAll");
                            return;
                        }
                        
                        Promotion promotion = new Promotion(PromoCode, DiscountPercent, StartDate, EndDate, Status, Description, RemainRedemption);
                        int n = dao.insertPromotion(promotion);
                        if (n > 0) {
                            response.sendRedirect(request.getContextPath() + "/admin/promo?service=listAll");
                        } else {
                            request.setAttribute("error", "Failed to insert promotion");
                            response.sendRedirect(request.getContextPath() + "/admin/promo?service=listAll");
                        }
                        return;
                    } catch (Exception e) {
                        request.setAttribute("error", "Error: " + e.getMessage());
                        response.sendRedirect(request.getContextPath() + "/admin/promo?service=listAll");
                        return;
                    }
                }
            }
            
            if (service.equals("DisableStatus")) {
                int pid = Integer.parseInt(request.getParameter("pid"));
                String submit = request.getParameter("submit");

                Promotion promotion = dao.getPromoByID(pid);

                if (submit != null) {
                    if (promotion == null) {
                        request.setAttribute("errorMessage", "Cannot found Promotion");
                        response.sendRedirect(request.getContextPath() + "/admin/promo?service=listAll");
                        return;
                    }

                    boolean newStatus = !promotion.isStatus();
                    Promotion pro = new Promotion(pid, newStatus);
                    int updated = dao.disablePromotion(pro);

                    if (updated > 0) {
                        request.getSession().setAttribute("successMessage", "Status updated successfully!");
                    } else {
                        request.getSession().setAttribute("errorMessage", "Update failed, please try again!");
                    }

                    response.sendRedirect(request.getContextPath() + "/admin/promo?service=listAll");
                    return;
                }
            }
            
            // Default case: listAll
            String sql = "SELECT * FROM Promotion";
            List<Promotion> list = dao.getPromotion(sql);
            request.setAttribute("list", list);
            request.getRequestDispatcher("/admin/promotion-management.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/admin/promotion-management.jsp").forward(request, response);
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
