package controller;

import entity.Order;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BookingDAO;

@WebServlet(name = "MyBookingsController", urlPatterns = {"/mybookings"})
public class MyBookingsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Integer customerID = (Integer) session.getAttribute("CustomerID");
        
        // Check if user is logged in
        if (customerID == null) {
            response.sendRedirect("login");
            return;
        }
        
        BookingDAO dao = new BookingDAO();
        List<Order> orders = dao.getOrdersByAccountID(customerID);
        
        // Set attribute for JSP
        request.setAttribute("orderList", orders);
        
        // Get order details if an order is selected
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                ResultSet ticketDetails = dao.getTicketsDetailsByOrderID(orderId);
                ResultSet comboDetails = dao.getOrderCombosByOrderID(orderId);
                
                request.setAttribute("ticketDetails", ticketDetails);
                request.setAttribute("comboDetails", comboDetails);
                request.setAttribute("selectedOrderId", orderId);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid order ID");
            }
        }
        
        request.getRequestDispatcher("mybooking.jsp").forward(request, response);
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

    @Override
    public String getServletInfo() {
        return "My Bookings Controller";
    }
} 