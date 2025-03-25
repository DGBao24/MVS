package controller;

import entity.Movie;
import entity.Order;
import entity.Seat;
import entity.Showtime;
import entity.Ticket;
import model.BookingDAO;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet(name = "BookingController", urlPatterns = {"/book"})
public class BookingController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(BookingController.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookingDAO dao = new BookingDAO();
        HttpSession session = request.getSession();

        String movieID = request.getParameter("movieID");
        String cinemaID = request.getParameter("CinemaID");
        String startTime = request.getParameter("StartTime");
        String roomID = request.getParameter("RoomID");
        String[] seatIDs = request.getParameterValues("SeatID");
        Integer accountId = (Integer) session.getAttribute("CustomerID");

        int mid = Integer.parseInt(movieID);
        Movie movie = dao.getMovieById(mid);
        request.setAttribute("movie", movie);

        try {
            if (movieID != null && !movieID.isEmpty()) {

                List<Showtime> cinemas = dao.getShowTimeByMovie(mid);

                ResultSet rsCin = dao.getData("SELECT DISTINCT s.CinemaID, c.CinemaName FROM ShowTime s " 
                        + "JOIN Cinema c ON c.CinemaID = s.CinemaID WHERE s.MovieID = " + mid);

                session.setAttribute("movie", movie);
                session.setAttribute("cin", rsCin);
                session.setAttribute("cinemaList", cinemas);

            }

            if (cinemaID != null && !cinemaID.isEmpty()) {

                int cid = Integer.parseInt(cinemaID);
                ResultSet rsSho = dao.getData("Select StartTime,EndTime From ShowTime Where MovieID=" + mid + " And CinemaID=" + cid + "AND StartTime > DATEADD(MINUTE, 30, GETDATE())");
                session.setAttribute("sho", rsSho);
                request.setAttribute("selectedCinemaID", cid);
            }

            if (startTime != null && !startTime.isEmpty()) {
                Timestamp timestamp = Timestamp.valueOf(startTime.split("\\.")[0]);

                int cid = Integer.parseInt(cinemaID);

                ResultSet rsRoo = dao.getData("SELECT s.RoomID, cr.RoomName, cr.RoomType FROM ShowTime s "
                        + "JOIN CinemaRoom cr ON cr.RoomID = s.RoomID WHERE s.MovieID = " + mid
                        + " AND s.CinemaID = " + cid + " AND StartTime = '" + timestamp + "'");
                session.setAttribute("roo", rsRoo);
                List<Showtime> rooms = dao.getRoomByDate(mid, cid, timestamp);
                session.setAttribute("rooms", rooms);
                request.setAttribute("selectedStartTime", startTime);

            }

            if (roomID != null && !roomID.isEmpty()) {
                int rid = Integer.parseInt(roomID);
                
                // Get the showtime ID based on selected parameters
                Timestamp timestamp = Timestamp.valueOf(startTime.split("\\.")[0]);
                int cid = Integer.parseInt(cinemaID);
                int showtimeID = dao.getShowtimeID(mid, cid, rid, timestamp);
                
                // Use the new method that checks seat availability for this specific showtime
                List<Seat> seats = dao.getSeatByRoomAndShowtime(rid, showtimeID);
                
                // Update the existing ResultSet (keeping for backwards compatibility)
                ResultSet rsSea = dao.getData("SELECT s.SeatID, s.SeatType, s.SeatRow, s.SeatNumber, " +
                        "CASE WHEN t.TicketID IS NULL THEN 'Available' " +
                        "WHEN t.Status = 1 THEN 'Booked' " +
                        "ELSE 'Processing' END AS Status " +
                        "FROM Seat s " +
                        "LEFT JOIN (SELECT * FROM Ticket WHERE ShowTimeID = " + showtimeID + ") t ON s.SeatID = t.SeatID " +
                        "WHERE s.RoomID = " + rid + " ORDER BY s.SeatRow ASC, s.SeatNumber ASC");
                
                session.setAttribute("sea", rsSea);
                session.setAttribute("seats", seats);
                request.setAttribute("selectedRoomID", rid);
                request.setAttribute("selectedShowtimeID", showtimeID);
            }

            if (request.getParameter("confirm") != null) {

                if (seatIDs == null || seatIDs.length == 0) {
                    request.setAttribute("mess", "Vui lòng chọn ít nhất một ghế!");
                } else {
                    boolean success = true;

                    // Lấy ShowtimeID từ thông tin đã chọn
                    Timestamp timestamp = Timestamp.valueOf(startTime.split("\\.")[0]);
                    int cid = Integer.parseInt(cinemaID);
                    int rid = Integer.parseInt(roomID);

                    // Lấy ShowtimeID dựa trên các thông tin đã chọn
                    int tid = dao.getShowtimeID(mid, cid, rid, timestamp);

                    if (tid == -1) {
                        request.setAttribute("mess", "Lỗi: Không tìm thấy suất chiếu!");
                    } else {
                        try {
                            Timestamp orderDate = new Timestamp(System.currentTimeMillis());

                            dao.insertOrder(accountId, orderDate, "Processing");

                            Order lastOrder = dao.getLatestOrder();
                            for (String seat : seatIDs) {
                                int sid = Integer.parseInt(seat);
                                Ticket ticket = new Ticket(sid, tid, lastOrder.getOrderID());
                                int newTicketID = dao.insertTicket(ticket);

                                if (newTicketID > 0) {

                                    dao.updateSeatBooking(sid);
                                } else {
                                    success = false;
                                }
                            }

                            if (success) {
                                List<Integer> ticketIDs = dao.getLastInsertedTickets(seatIDs.length);
                                String ticketQuery = "SELECT "
                                        + "t.*, s.SeatRow, s.SeatNumber, s.SeatType, "
                                        + "st.StartTime, st.EndTime, c.CinemaName, cr.RoomName, cr.RoomType, "
                                        + "m.MovieName, m.Duration, m.BasePrice, "
                                        + "pf_seat.Multiplier AS SeatFactor, pf_room.Multiplier AS RoomFactor "
                                        + "FROM Ticket t "
                                        + "JOIN Seat s ON t.SeatID = s.SeatID "
                                        + "JOIN ShowTime st ON t.ShowTimeID = st.ShowTimeID "
                                        + "JOIN Cinema c ON st.CinemaID = c.CinemaID "
                                        + "JOIN CinemaRoom cr ON st.RoomID = cr.RoomID "
                                        + "JOIN Movie m ON st.MovieID = m.MovieID "
                                        + "JOIN PricingFactor pf_seat ON pf_seat.Type = 'Seat' AND pf_seat.Category = s.SeatType "
                                        + "JOIN PricingFactor pf_room ON pf_room.Type = 'Room' AND pf_room.Category = cr.RoomType "
                                        + "WHERE t.TicketID IN (" + String.join(",", ticketIDs.stream()
                                                .map(String::valueOf)
                                                .toArray(String[]::new)) + ")";

                                try (ResultSet ticketRs = dao.getData(ticketQuery)) {
                                    if (ticketRs == null || !ticketRs.isBeforeFirst()) {
                                        request.setAttribute("mess", "Lỗi: Không tìm thấy thông tin vé!");
                                    } else {
                                        double totalPrice = 0;
                                        double basePrice = 0;
                                        // Create maps to store individual seat factors and seat IDs by type
                                        Map<String, Double> seatTypeFactors = new HashMap<>();
                                        Map<String, List<Integer>> seatsByType = new HashMap<>();
                                        double vipFactor = 0.0;
                                        double standardFactor = 0.0;
                                        int vipCount = 0;
                                        int standardCount = 0;

                                        while (ticketRs.next()) {
                                            basePrice = ticketRs.getDouble("BasePrice");
                                            double seatFactor = ticketRs.getDouble("SeatFactor");
                                            double roomFactor = ticketRs.getDouble("RoomFactor");
                                            String seatType = ticketRs.getString("SeatType");
                                            int seatID = ticketRs.getInt("SeatID");
                                            
                                            // Store the seat factor for each seat type
                                            seatTypeFactors.put(seatType, seatFactor);
                                            
                                            // Group seat IDs by type
                                            if (!seatsByType.containsKey(seatType)) {
                                                seatsByType.put(seatType, new ArrayList<>());
                                            }
                                            seatsByType.get(seatType).add(seatID);
                                            
                                            // Track counts and factors for VIP and Standard seats
                                            if ("VIP".equals(seatType)) {
                                                vipFactor = seatFactor;
                                                vipCount++;
                                            } else if ("Standard".equals(seatType)) {
                                                standardFactor = seatFactor;
                                                standardCount++;
                                            }
                                            
                                            // Calculate individual price for this seat
                                            totalPrice += (basePrice * seatFactor * roomFactor);
                                            
                                            // Save room factor for later use in confirmation page
                                            session.setAttribute("roomFactor", roomFactor);
                                        }
                                        
                                        // Save seat type specific data for pricing details
                                        session.setAttribute("seatTypeFactors", seatTypeFactors);
                                        session.setAttribute("seatsByType", seatsByType);
                                        session.setAttribute("vipFactor", vipFactor);
                                        session.setAttribute("standardFactor", standardFactor);
                                        session.setAttribute("vipCount", vipCount);
                                        session.setAttribute("standardCount", standardCount);
                                        
                                        // For backward compatibility
                                        if (vipCount > 0 && standardCount == 0) {
                                            session.setAttribute("seatFactor", vipFactor);
                                        } else if (standardCount > 0 && vipCount == 0) {
                                            session.setAttribute("seatFactor", standardFactor);
                                        } else {
                                            // If mixed seats, use the VIP factor for display purpose
                                            // The actual calculation will be done properly with individual factors
                                            session.setAttribute("seatFactor", vipFactor > 0 ? vipFactor : standardFactor);
                                        }

                                        session.setAttribute("selectedShowtime", startTime);
                                        session.setAttribute("selectedSeats", seatIDs);
                                        request.setAttribute("ticketDetails", ticketRs);
                                        session.setAttribute("totalPrice", totalPrice);
                                        session.setAttribute("basePrice", basePrice);
                                        session.setAttribute("mess", "Đặt vé thành công!");
                                        session.setAttribute("Order", lastOrder);
                                        request.getRequestDispatcher("combo-promotion").forward(request, response);
                                        return;
                                    }
                                }
                            } else {
                                request.setAttribute("mess", "Lỗi khi đặt một số vé, vui lòng kiểm tra lại!");
                            }
                        } catch (SQLException | NumberFormatException e) {
                            LOGGER.log(Level.SEVERE, "Lỗi đặt vé: ", e);
                            request.setAttribute("mess", "Lỗi hệ thống, vui lòng thử lại!");
                        }
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi tổng quát: ", e);
        }
        request.getRequestDispatcher("select_ticket.jsp").forward(request, response);

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
