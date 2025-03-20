package controller;

import entity.Combo;
import entity.Movie;
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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "BookingController", urlPatterns = {"/book"})
public class BookingController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookingDAO dao = new BookingDAO();

        // Lấy danh sách combo từ DB
        ResultSet rsCom = dao.getData("Select ComboID, ComboItem, Price from Combo");
        request.setAttribute("com", rsCom);

        // Lấy các thông tin từ request
        String movieID = request.getParameter("movieID");
        String cinemaID = request.getParameter("CinemaID");
        String startTime = request.getParameter("StartTime");
        String roomID = request.getParameter("RoomID");
        String[] seatIDs = request.getParameterValues("SeatID"); // Nhận nhiều ghế
        String comboID = request.getParameter("ComboID");

        try {
            if (movieID != null && !movieID.isEmpty()) {
                int mid = Integer.parseInt(movieID);
                Movie movie = dao.getMovieById(mid);
                List<Showtime> cinemas = dao.getShowTimeByMovie(mid);
                ResultSet rsCin = dao.getData("SELECT s.CinemaID, c.CinemaName FROM ShowTime s "
                        + "JOIN Cinema c ON c.CinemaID = s.CinemaID WHERE s.MovieID = " + mid);
                request.setAttribute("movie", movie);
                request.setAttribute("cin", rsCin);
                request.setAttribute("cinemaList", cinemas);
            }

            if (cinemaID != null && !cinemaID.isEmpty()) {
                int mid = Integer.parseInt(movieID);
                int cid = Integer.parseInt(cinemaID);
                List<Showtime> showtimes = dao.getDateByCinema(mid, cid);
                request.setAttribute("showtimes", showtimes);
                request.setAttribute("selectedCinemaID", cid);
            }

            if (startTime != null && !startTime.isEmpty()) {
                Timestamp timestamp = Timestamp.valueOf(startTime.split("\\.")[0]);
                int mid = Integer.parseInt(movieID);
                int cid = Integer.parseInt(cinemaID);
                ResultSet rsRoo = dao.getData("SELECT s.RoomID, cr.RoomName, cr.RoomType FROM ShowTime s "
                        + "JOIN CinemaRoom cr ON cr.RoomID = s.RoomID WHERE s.MovieID = " + mid
                        + " AND s.CinemaID = " + cid + " AND StartTime = '" + timestamp + "'");
                request.setAttribute("roo", rsRoo);
                List<Showtime> rooms = dao.getRoomByDate(mid, cid, timestamp);
                request.setAttribute("rooms", rooms);
                request.setAttribute("selectedStartTime", startTime);
            }

            if (roomID != null && !roomID.isEmpty()) {
                int rid = Integer.parseInt(roomID);
                List<Seat> seats = dao.getSeatByRoom(rid);
                ResultSet rsSea = dao.getData("SELECT SeatID, SeatType, SeatRow, SeatNumber FROM Seat "
                        + "WHERE Status = 'Available' AND RoomID = " + rid);
                request.setAttribute("sea", rsSea);
                request.setAttribute("seats", seats);
                request.setAttribute("selectedRoomID", rid);
            }

            List<Combo> combos = dao.getCombo("SELECT * FROM Combo");
            request.setAttribute("comboList", combos);

            // Xử lý đặt vé khi bấm submit
            if (request.getParameter("buy") != null) {
                if (seatIDs == null || seatIDs.length == 0) {
                    request.setAttribute("mess", "Vui lòng chọn ít nhất một ghế!");
                } else {
                    int tid = -1;
                    List<Showtime> showtimes = (List<Showtime>) request.getAttribute("showtimes");
                    if (showtimes != null && !showtimes.isEmpty()) {
                        tid = showtimes.get(0).getShowtimeID();
                    }
                    if (tid == -1) {
                        request.setAttribute("mess", "Lỗi: Không tìm thấy suất chiếu!");
                    } else {
                        boolean success = true;
                        for (String seat : seatIDs) {
                            try {
                                int sid = Integer.parseInt(seat);
                                Ticket ticket;
                                if (comboID == null || comboID.isEmpty()) {
                                    ticket = new Ticket(sid, tid);
                                    int newTicketID = dao.insertTicketWithOutCombo(ticket);
                                    if (newTicketID > 0) {
                                        ticket.setTicketID(newTicketID);
                                    }
                                } else {
                                    int cbid = Integer.parseInt(comboID);
                                    ticket = new Ticket(sid, tid, cbid);
                                    ticket.setComboID(cbid);
                                    int newTicketID = dao.insertTicket(ticket);
                                    if (newTicketID > 0) {
                                        ticket.setTicketID(newTicketID);
                                    }
                                }
                                if (ticket.getTicketID() > 0) {
                                    dao.updateSeatBooking(sid);
                                } else {
                                    success = false;
                                }
                            } catch (NumberFormatException e) {
                                success = false;
                            }
                        }
                        if (success) {
                            // Lấy danh sách TicketID vừa tạo từ BookingDAO
                            List<Integer> ticketIDs = dao.getLastInsertedTickets(seatIDs.length);

                            // Lấy thông tin chi tiết về vé với câu truy vấn đơn giản hơn
                            String ticketQuery = "SELECT "
                                    + "t.*, "
                                    + "s.SeatRow, s.SeatNumber, s.SeatType, "
                                    + "st.StartTime, st.EndTime, "
                                    + "c.CinemaName, cr.RoomName, cr.RoomType, "
                                    + "m.MovieName, m.Duration, m.BasePrice, "
                                    + "cb.ComboItem, cb.Price AS ComboPrice, "
                                    + "pf_seat.Multiplier AS SeatFactor, "
                                    + "pf_room.Multiplier AS RoomFactor "
                                    + "FROM Ticket t "
                                    + "JOIN Seat s ON t.SeatID = s.SeatID "
                                    + "JOIN ShowTime st ON t.ShowTimeID = st.ShowTimeID "
                                    + "JOIN Cinema c ON st.CinemaID = c.CinemaID "
                                    + "JOIN CinemaRoom cr ON st.RoomID = cr.RoomID "
                                    + "JOIN Movie m ON st.MovieID = m.MovieID "
                                    + "LEFT JOIN Combo cb ON t.ComboID = cb.ComboID "
                                    + "JOIN PricingFactor pf_seat "
                                    + "ON pf_seat.Type = 'Seat' AND pf_seat.Category = s.SeatType "
                                    + "JOIN PricingFactor pf_room "
                                    + "ON pf_room.Type = 'Room' AND pf_room.Category = cr.RoomType "
                                    + "WHERE t.TicketID IN ("
                                    + String.join(",", ticketIDs.stream()
                                            .map(String::valueOf)
                                            .toArray(String[]::new)) + ")";

                            ResultSet ticketRs = dao.getData(ticketQuery);

                            if (ticketRs == null) {
                                request.setAttribute("mess", "Lỗi: Không thể truy vấn thông tin vé!");
                                request.getRequestDispatcher("select_ticket.jsp").forward(request, response);
                                return;
                            }

                            try {
                                if (!ticketRs.isBeforeFirst()) {
                                    request.setAttribute("mess", "Lỗi: Không tìm thấy thông tin vé!");
                                    request.getRequestDispatcher("select_ticket.jsp").forward(request, response);
                                    return;
                                }

                                double totalPrice = 0;
                                double basePrice = 0;

                                while (ticketRs.next()) {
                                    basePrice = ticketRs.getDouble("BasePrice");
                                    double seatFactor = ticketRs.getDouble("SeatFactor");
                                    double roomFactor = ticketRs.getDouble("RoomFactor");
                                    double comboPrice = ticketRs.getDouble("ComboPrice");

                                    totalPrice += (basePrice * seatFactor * roomFactor) + (comboPrice > 0 ? comboPrice : 0);
                                }

                                ticketRs.beforeFirst();
                                request.setAttribute("ticketDetails", ticketRs);
                                request.setAttribute("totalPrice", totalPrice);
                                request.setAttribute("basePrice", basePrice);
                                request.setAttribute("mess", "Đặt vé thành công!");
                                request.getRequestDispatcher("ticket-confirmation.jsp").forward(request, response);
                                return;
                            } catch (SQLException ex) {
                                Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE, null, ex);
                                request.setAttribute("mess", "Lỗi khi xử lý thông tin vé: " + ex.getMessage());
                                request.getRequestDispatcher("select_ticket.jsp").forward(request, response);
                                return;
                            }
                        } else {
                            request.setAttribute("mess", "Lỗi khi đặt một số vé, vui lòng kiểm tra lại!");
                            request.getRequestDispatcher("select_ticket.jsp").forward(request, response);
                        }
                    }
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("mess", "Dữ liệu không hợp lệ, vui lòng thử lại!");
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
