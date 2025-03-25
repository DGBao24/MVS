/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Account;
import entity.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import model.BookingDAO;
import model.DAOAccount;
import utils.Config;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author pdatt
 */
@WebServlet(name = "OrderStatus", urlPatterns = {"/paymentstatus"})
public class OrderStatus extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(OrderStatus.class.getName());

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

//        try {
//            LOGGER.info("Processing payment status request");
//            
//            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
//            if (vnp_SecureHash == null) {
//                LOGGER.warning("Missing vnp_SecureHash parameter");
//                response.sendRedirect("ticket-confirmation.jsp?mess=Lỗi: Thiếu thông tin xác thực");
//                return;
//            }
//            
//            Map fields = new HashMap();
//            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
//                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
//                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
//                if ((fieldValue != null) && (fieldValue.length() > 0)) {
//                    fields.put(fieldName, fieldValue);
//                }
//            }
//            
//            if (fields.containsKey("vnp_SecureHashType")) {
//                fields.remove("vnp_SecureHashType");
//            }
//            if (fields.containsKey("vnp_SecureHash")) {
//                fields.remove("vnp_SecureHash");
//            }
//            
//            String signValue = Config.hashAllFields(fields);
//            boolean validSignature = signValue.equals(vnp_SecureHash);
//            
//            if (!validSignature) {
//                LOGGER.warning("Invalid signature");
//                response.sendRedirect("ticket-confirmation.jsp?mess=Lỗi xác thực giao dịch");
//                return;
//            }
//            
//            String orderId = request.getParameter("vnp_TxnRef");
//            String transactionStatus = request.getParameter("vnp_TransactionStatus");
//            
//            LOGGER.info("Processing order: " + orderId + " with status: " + transactionStatus);
//            
//            if (orderId != null && transactionStatus != null) {
//                BookingDAO dao = new BookingDAO();
//                Order order = dao.getOrderById(Integer.parseInt(orderId));
//                
//                if (order != null) {
//                    // Check if order is already processed
//                    if (!"Processing".equals(order.getStatus())) {
//                        LOGGER.warning("Order " + orderId + " is already processed with status: " + order.getStatus());
//                        response.sendRedirect("ticket-confirmation.jsp?mess=Giao dịch đã được xử lý");
//                        return;
//                    }
//                    
//                    // Update order status based on transaction status
//                    if ("00".equals(transactionStatus)) {
//                        order.setStatus("Completed");
//                        // Update loyalty points for completed order
//                        DAOAccount accountDao = new DAOAccount();
//                        accountDao.updateLoyaltyPointsAndLevel(order.getAccountID(), order.getTotalAmount());
//                        LOGGER.info("Order " + orderId + " completed successfully");
//                    } else {
//                        order.setStatus("Failed");
//                        LOGGER.warning("Order " + orderId + " failed with status: " + transactionStatus);
//                    }
//                    
//                    boolean success = dao.updateOrderStatus(order);
//                    
//                    if (success) {
//                        // Clear booking session data
//                        HttpSession session = request.getSession();
//                        session.removeAttribute("selectedSeats");
//                        session.removeAttribute("selectedShowtime");
//                        session.removeAttribute("totalPrice");
//                        session.removeAttribute("basePrice");
//                        session.removeAttribute("finalPrice");
//                        session.removeAttribute("Order");
//                        session.removeAttribute("comboQuantities");
//                        session.removeAttribute("appliedPromo");
//                        
//                        request.setAttribute("transResult", "00".equals(transactionStatus));
//                        LOGGER.info("Forwarding to payment result page");
//                        request.getRequestDispatcher("paymentResult.jsp").forward(request, response);
//                    } else {
//                        LOGGER.severe("Failed to update order status in database");
//                        response.sendRedirect("ticket-confirmation.jsp?mess=Lỗi khi cập nhật trạng thái đơn hàng");
//                    }
//                } else {
//                    LOGGER.warning("Order not found: " + orderId);
//                    response.sendRedirect("ticket-confirmation.jsp?mess=Không tìm thấy đơn hàng");
//                }
//            } else {
//                LOGGER.warning("Missing orderId or transactionStatus");
//                response.sendRedirect("ticket-confirmation.jsp?mess=Thông tin giao dịch không hợp lệ");
//            }
//        } catch (Exception e) {
//            LOGGER.log(Level.SEVERE, "System error", e);
//            response.sendRedirect("ticket-confirmation.jsp?mess=Lỗi hệ thống");
//        }
        try (PrintWriter out = response.getWriter()) {
            BookingDAO bookingDAO = new BookingDAO();
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }
            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
            if (signValue.equals(vnp_SecureHash)) {
                String paymentCode = request.getParameter("vnp_TransactionNo");

                String orderId = request.getParameter("vnp_TxnRef");

                Order order = new Order();
                order.setOrderID(Integer.parseInt(orderId));

                boolean transSuccess = false;
                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                    //update banking system
                    order.setStatus("Completed");
                    transSuccess = true;
                    if (order.getStatus().equals("Completed")) {
                        Order completedOrder = bookingDAO.getOrderById(Integer.parseInt(orderId));
                        if (completedOrder != null) {
                            DAOAccount accountDao = new DAOAccount();
                            accountDao.updateLoyaltyPointsAndLevel(completedOrder.getAccountID(), completedOrder.getTotalAmount());
                        Account acc = accountDao.getAccountById(completedOrder.getAccountID());
                        request.setAttribute("account", acc);
                        }

                    }
                    // Get order details to update loyalty points
                } else {
                    order.setStatus("Failed");
                    transSuccess = false;
                    BookingDAO dao = new BookingDAO();

                    dao.deleteOrderComboByOrderID(Integer.parseInt(orderId));
                    dao.deleteTicketByOrderID(Integer.parseInt(orderId));

                }
                bookingDAO.updateOrderStatus(order);

                // Clear booking session data
                HttpSession session = request.getSession();
                session.removeAttribute("selectedSeats");
                session.removeAttribute("selectedShowtime");
                session.removeAttribute("totalPrice");
                session.removeAttribute("basePrice");
                session.removeAttribute("finalPrice");
                session.removeAttribute("Order");
                session.removeAttribute("comboQuantities");
                session.removeAttribute("appliedPromo");

                request.setAttribute("transResult", transSuccess);
                request.getRequestDispatcher("paymentResult.jsp").forward(request, response);
            } else {
                //RETURN PAGE ERROR
                System.out.println("GD KO HOP LE (invalid signature)");
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
        return "Payment Status Handler";
    }// </editor-fold>

}
