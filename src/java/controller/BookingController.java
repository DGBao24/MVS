package controller;

import entity.Ticket;
import model.BookingDAO;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BookingController", urlPatterns = {"/book"})
public class BookingController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookingDAO dao = new BookingDAO();
        String movieID = request.getParameter("movieID");
        String cinemaID = request.getParameter("CinemaID");
        String startTime = request.getParameter("StartTime");
        String roomID = request.getParameter("RoomID");
        String seatID = request.getParameter("SeatID");
        String comboID = request.getParameter("ComboID");

        try {
            if (movieID != null && !movieID.isEmpty()) {
                int mid = Integer.parseInt(movieID);
                
                // Dùng ResultSet lấy danh sách rạp chiếu phim
                ResultSet rsCinema = dao.getData("SELECT CinemaID, CinemaName FROM Cinema WHERE MovieID = " + mid);
                request.setAttribute("cinemaList", rsCinema);
            }

            if (cinemaID != null && !cinemaID.isEmpty()) {
                int cid = Integer.parseInt(cinemaID);
                
                // Dùng ResultSet lấy danh sách suất chiếu theo rạp
                ResultSet rsShowtime = dao.getData("SELECT ShowtimeID, StartTime FROM Showtime WHERE CinemaID = " + cid);
                request.setAttribute("showtimeList", rsShowtime);
            }

            if (startTime != null && !startTime.isEmpty()) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                Timestamp timestamp = Timestamp.valueOf(LocalDateTime.parse(startTime, formatter));

                int cid = Integer.parseInt(cinemaID);
                
                // Dùng ResultSet lấy danh sách phòng chiếu
                ResultSet rsRoom = dao.getData("SELECT RoomID, RoomName FROM Room WHERE CinemaID = " + cid + " AND StartTime = '" + timestamp + "'");
                request.setAttribute("roomList", rsRoom);
            }

            if (roomID != null && !roomID.isEmpty()) {
                int rid = Integer.parseInt(roomID);
                
                // Dùng ResultSet lấy danh sách ghế
                ResultSet rsSeat = dao.getData("SELECT SeatID, SeatNumber FROM Seat WHERE RoomID = " + rid);
                request.setAttribute("seatList", rsSeat);
            }

            if (seatID != null && !seatID.isEmpty()) {
                
                // Dùng ResultSet lấy danh sách combo đồ ăn
                ResultSet rsCombo = dao.getData("SELECT ComboID, ComboName, Price FROM Combo");
                request.setAttribute("comboList", rsCombo);
            }

            // Xử lý đặt vé khi bấm submit
            if (request.getParameter("submit") != null) {
                if (seatID == null || seatID.isEmpty()) {
                    request.setAttribute("mess", "Vui lòng chọn ghế!");
                } else {
                    int sid = Integer.parseInt(seatID);
                    int tid = Integer.parseInt(request.getParameter("ShowtimeID"));

                    if (comboID == null || comboID.isEmpty()) {
                        Ticket ticket = new Ticket(sid, tid);
                        dao.insertTicketWithOutCombo(ticket);
                    } else {
                        int cbid = Integer.parseInt(comboID);
                        Ticket ticket = new Ticket(sid, tid, cbid);
                        dao.insertTicket(ticket);
                    }

                    request.getRequestDispatcher("ticket-confirmation.jsp").forward(request, response);
                    return;
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
