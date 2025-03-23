package controller;

import entity.Combo;
import entity.Order;
import entity.OrderCombo;
import entity.Promotion;
import model.BookingDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ComboPromotionController", urlPatterns = {"/combo-promotion"})
public class ComboPromotionController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ComboPromotionController.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        BookingDAO dao = new BookingDAO();

        try {
            Object ticketDetailsObj = request.getAttribute("ticketDetails");
            ResultSet TicketRs = (ticketDetailsObj instanceof ResultSet) ? (ResultSet) ticketDetailsObj : null;

            Double totalPrice = (Double) session.getAttribute("totalPrice");
            Double basePrice = (Double) session.getAttribute("basePrice");
            Integer accountId = (Integer) session.getAttribute("CustomerID");
            String[] seatArray = (String[]) session.getAttribute("selectedSeats");
            List<String> seatIDs = (seatArray != null) ? Arrays.asList(seatArray) : new ArrayList<>();
            String showtimeStr = (String) session.getAttribute("selectedShowtime");
            Timestamp showtime = (showtimeStr != null) ? Timestamp.valueOf(showtimeStr) : null;
            String appliedPromo = (String) session.getAttribute("appliedPromo");    
            Order lastOrder = (Order) session.getAttribute("Order");
            if (totalPrice == null || accountId == null || seatIDs == null || showtime == null) {
                request.setAttribute("mess", "Lỗi dữ liệu: Một số thông tin quan trọng bị thiếu!");
                request.getRequestDispatcher("ticket-confirmation.jsp").forward(request, response);
                return;
            }

            ResultSet rsCombo = dao.getData("Select ComboID,ComboItem,Price from Combo");
            request.setAttribute("combo", rsCombo);

            String[] comboIDs = request.getParameterValues("combo");
            if (comboIDs == null) {
                comboIDs = new String[0]; // Tránh lỗi null khi duyệt mảng
            }

            String promoCode = request.getParameter("PromoCode");
            String pay = request.getParameter("pay");
            String confirmCombo = request.getParameter("confirmCombo");
            String applyPromo = request.getParameter("applyPromo");
            int ComboQuantity = 0;
            try {
                String ComboQuantityStr = request.getParameter("ComboQuantity");
                if (ComboQuantityStr != null && !ComboQuantityStr.isEmpty()) {
                    ComboQuantity = Integer.parseInt(ComboQuantityStr);
                }
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Lỗi chuyển đổi ComboQuantity", e);
            }

            if (lastOrder == null) {
                request.setAttribute("mess", "Lỗi: Không tìm thấy đơn hàng!");
                request.getRequestDispatcher("ticket-confirmation.jsp").forward(request, response);
                return;
            }

            // Lấy danh sách combo đã chọn từ session (nếu có)
            List<Combo> selectedCombos = (List<Combo>) session.getAttribute("selectedCombos");
            if (selectedCombos == null) {
                selectedCombos = new ArrayList<>();
            }

// Tạo danh sách lưu số lượng combo đã chọn
            Map<Integer, Integer> comboQuantities = (Map<Integer, Integer>) session.getAttribute("comboQuantities");
            if (comboQuantities == null) {
                comboQuantities = new HashMap<>();
            }

// Xử lý danh sách combo đã chọn
            for (String comboID : comboIDs) {
                if (comboID != null && !comboID.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(comboID);
                        Combo combo = dao.getComboByID(id);
                        if (combo != null) {
                            int quantity = Integer.parseInt(request.getParameter("ComboQuantity_" + id));

                            // Nếu combo chưa được chọn, thêm vào danh sách
                            if (!selectedCombos.contains(combo)) {
                                selectedCombos.add(combo);
                            }

                            // Cập nhật số lượng combo vào Map
                            comboQuantities.put(id, quantity);

                            // Cập nhật tổng tiền
                            totalPrice += combo.getPrice() * quantity;
                        }
                    } catch (NumberFormatException e) {
                        LOGGER.log(Level.WARNING, "Lỗi chuyển đổi ComboID hoặc số lượng: " + comboID, e);
                    }
                }
            }

// Lưu lại vào session để không bị mất khi reload
            session.setAttribute("selectedCombos", selectedCombos);
            session.setAttribute("comboQuantities", comboQuantities);
            session.setAttribute("finalPrice", totalPrice);

            if (confirmCombo != null) {
                // Xử lý xác nhận combo (Giữ nguyên logic cũ)

                for (String param : request.getParameterMap().keySet()) {
                    if (param.startsWith("ComboQuantity_")) {
                        int comboID = Integer.parseInt(param.replace("ComboQuantity_", ""));
                        int quantity = Integer.parseInt(request.getParameter(param));

                        if (quantity > 0) {
                            Combo combo = dao.getComboByID(comboID);
                            selectedCombos.add(combo);
                            comboQuantities.put(comboID, quantity);
                            totalPrice += combo.getPrice() * quantity;
                        }
                    }
                }

                session.setAttribute("selectedCombos", selectedCombos);
                session.setAttribute("comboQuantities", comboQuantities);
                session.setAttribute("finalPrice", totalPrice);
                request.setAttribute("mess", "Combo đã được xác nhận!");
            }

            if (applyPromo != null) {
                // Xóa mã giảm giá cũ trước khi áp dụng mã mới
                if (appliedPromo != null) {
                    totalPrice = basePrice;
                    session.removeAttribute("appliedPromo");
                }

                if (promoCode != null && !promoCode.trim().isEmpty()) {
                    Promotion pro = dao.validatePromotion(promoCode);
                    if (pro != null) {
                        double discountRate = pro.getDiscountPercent();
                        totalPrice -= totalPrice * discountRate;
                        session.setAttribute("appliedPromo", promoCode);
                        request.setAttribute("mess", "Mã giảm giá đã được áp dụng!");
                    } else {
                        request.setAttribute("mess", "Mã giảm giá không hợp lệ!");
                    }
                }

                session.setAttribute("finalPrice", totalPrice);
            }

            if (pay != null) {
                int seatQuantity = seatIDs.size();
                if (!selectedCombos.isEmpty() && (promoCode == null || promoCode.isEmpty())) {
                    dao.updateComboOrder(lastOrder.getOrderID(), totalPrice, seatQuantity, selectedCombos.size());
                } else if (promoCode != null && !promoCode.isEmpty() && selectedCombos.isEmpty()) {
                    Promotion pro = dao.validatePromotion(promoCode);
                    int promotionId = pro.getPromotionID();
                    dao.updatePromotionOrder(lastOrder.getOrderID(), totalPrice, seatQuantity, promotionId);
                } else if (!selectedCombos.isEmpty() && promoCode != null && !promoCode.isEmpty()) {
                    Promotion pro = dao.validatePromotion(promoCode);
                    int promotionId = pro.getPromotionID();
                    dao.updateComboAndPromotion(lastOrder.getOrderID(), totalPrice, seatQuantity, selectedCombos.size(), promotionId);
                }

                response.sendRedirect("payment.jsp");
            } else {
                request.getRequestDispatcher("/ticket-confirmation.jsp").forward(request, response);
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi hệ thống tại ComboPromotionController: {0}", e.getMessage());
            e.printStackTrace();
            request.setAttribute("mess", "Lỗi hệ thống! Chi tiết: " + e.getMessage());
            request.getRequestDispatcher("ticket-confirmation.jsp").forward(request, response);
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
