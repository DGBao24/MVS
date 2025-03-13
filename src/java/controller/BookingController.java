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

@WebServlet(name = "BookingController", urlPatterns = {"/book"})
public class BookingController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookingDAO dao = new BookingDAO();

                        ResultSet rsCom = dao.getData("Select ComboID,ComboItem,Price from Combo");
                        request.setAttribute("com", rsCom);
        // Lấy movieID từ request (được truyền từ trang khác)
        String movieID = request.getParameter("movieID");
        String cinemaID = request.getParameter("CinemaID");
        String startTime = request.getParameter("StartTime");
        String roomID = request.getParameter("RoomID");
        String seatID = request.getParameter("SeatID");
        String comboID = request.getParameter("ComboID");

        try {
            if (movieID != null && !movieID.isEmpty()) {
                int mid = Integer.parseInt(movieID);
                Movie movie = dao.getMovieById(mid);
                List<Showtime> cinemas = dao.getShowTimeByMovie(mid);
                ResultSet rsCin = dao.getData("Select s.CinemaID,c.CinemaName from ShowTime s "
                        + "join Cinema c on c.CinemaID = s.CinemaID Where s.MovieID  = " + mid);
                request.setAttribute("movie", movie);
                request.setAttribute("cin", rsCin);
                request.setAttribute("cinemaList", cinemas);
            }

            if (cinemaID != null && !cinemaID.isEmpty()) {
                int mid = Integer.parseInt(movieID);
                int cid = Integer.parseInt(cinemaID);

                // ✅ Sửa lỗi: Lấy danh sách suất chiếu theo đúng CinemaID
                List<Showtime> showtimes = dao.getDateByCinema(mid, cid);

                request.setAttribute("showtimes", showtimes);

                request.setAttribute("selectedCinemaID", cid); // Giữ giá trị đã chọn
            }

            if (startTime != null && !startTime.isEmpty()) {
                Timestamp timestamp = Timestamp.valueOf(startTime.split("\\.")[0]);

                int mid = Integer.parseInt(movieID);
                int cid = Integer.parseInt(cinemaID);

                // ✅ Sửa lỗi: Lấy danh sách phòng đúng theo startTime đã chọn
                ResultSet rsRoo = dao.getData("Select s.RoomID,cr.RoomName,cr.RoomType from ShowTime s "
                        + "join CinemaRoom cr on cr.RoomID = s.RoomID Where s.MovieID  = "
                        + mid + " And s.CinemaID = " + cid + " And StartTime = '" + timestamp + "'");
                request.setAttribute("roo", rsRoo);
                List<Showtime> rooms = dao.getRoomByDate(mid, cid, timestamp);
                request.setAttribute("rooms", rooms);
                request.setAttribute("selectedStartTime", startTime); // Giữ lại StartTime
            }

            if (roomID != null && !roomID.isEmpty()) {
                int rid = Integer.parseInt(roomID);
                List<Seat> seats = dao.getSeatByRoom(rid);
                ResultSet rsSea = dao.getData("Select SeatID,SeatType,SeatRow,SeatNumber from Seat Where Status like 'Available' And RoomID = " + rid);
                request.setAttribute("sea", rsSea);
                request.setAttribute("seats", seats);
                request.setAttribute("selectedRoomID", rid); // Giữ lại RoomID
            }

            List<Combo> combos = dao.getCombo("SELECT * FROM Combo");
            request.setAttribute("comboList", combos);

            // Xử lý đặt vé khi bấm submit
            if (request.getParameter("buy") != null) {
                if (seatID == null || seatID.isEmpty()) {
                    request.setAttribute("mess", "Vui lòng chọn ghế!");
                } else {
                    int sid = Integer.parseInt(seatID);

                    // ✅ Lấy ShowtimeID từ danh sách showtimes
                    int tid = -1;
                    List<Showtime> showtimes = (List<Showtime>) request.getAttribute("showtimes");
                    if (showtimes != null && !showtimes.isEmpty()) {
                        tid = showtimes.get(0).getShowtimeID();
                    }
                    
                    if (tid == -1) {
                        request.setAttribute("mess", "Lỗi: Không tìm thấy suất chiếu!");
                    } else {
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

// Kiểm tra xem vé có được tạo thành công không
                        if (ticket.getTicketID() > 0) {
                            request.setAttribute("ticket", ticket);
                            Showtime showtime = dao.getShowTimeByID(ticket.getShowTimeID());
                            Movie movie = dao.getMovieById(showtime.getMovieID());
                            request.setAttribute("showtime", showtime);
                            request.setAttribute("movie", movie);
                            request.getRequestDispatcher("ticket-confirmation.jsp").forward(request, response);
                        } else {
                            request.setAttribute("mess", "Lỗi khi đặt vé, vui lòng thử lại!");
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
