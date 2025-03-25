package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BookingDAO;

@WebServlet(name = "CancelOrderController", urlPatterns = {"/cancelOrder"})
public class CancelOrderController extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            BookingDAO dao = new BookingDAO();
            
            boolean success = dao.cancelOrder(orderId);
            
            if (success) {
                response.sendRedirect("ticket-confirmation.jsp?mess=Hủy đơn hàng thành công");
            } else {
                response.sendRedirect("ticket-confirmation.jsp?mess=Lỗi khi hủy đơn hàng");
            }
            
        } catch (Exception e) {
            response.sendRedirect("ticket-confirmation.jsp?mess=Lỗi hệ thống");
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