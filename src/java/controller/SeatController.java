    package controller;

import entity.Seat;
import entity.Room;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.SeatDAO;
import model.CinemaRoomDAO;

@WebServlet(name = "SeatController", urlPatterns = {"/seat"})
public class SeatController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        CinemaRoomDAO dao = new CinemaRoomDAO();
        SeatDAO sdao = new SeatDAO();
        String service = request.getParameter("service");
        if (service == null) {
            service = "listAll";
        }

        if (service.equals("updateSeat")) {
            int sid = Integer.parseInt(request.getParameter("sid"));
            String submit = request.getParameter("submit");
            if (submit == null) {
                Seat seat = sdao.getSeatID(sid);
                request.setAttribute("seat", seat);
                request.getRequestDispatcher("admin/updateSeat.jsp").forward(request, response);
            } else {
                String SeatType = request.getParameter("SeatType");
                String Status = request.getParameter("Status");
                if (SeatType == null || SeatType.trim().isEmpty()) {
                    request.setAttribute("error", "Invalid input data");
                    request.getRequestDispatcher("admin/updateSeat.jsp").forward(request, response);
                    return;
                }
                Seat seat = new Seat(sid, SeatType, Status);
                int n = sdao.updateSeat(seat);
                if (n > 0) {
                    seat = sdao.getSeatID(sid);
                    request.setAttribute("seat", seat);
                    request.setAttribute("success", "Update successful");
                    request.getRequestDispatcher("admin/seat-management.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Update Failed");
                    request.getRequestDispatcher("admin/updateSeat.jsp").forward(request, response);
                }
            }
            return;
        }

        if (service.equals("insertSeat")) {
            String SeatRow = request.getParameter("SeatRow");
            int SeatNumber = Integer.parseInt(request.getParameter("SeatNumber"));
            String SeatType = request.getParameter("SeatType");
            int RoomID = Integer.parseInt(request.getParameter("RoomID"));
            String Status = request.getParameter("Status");

            // Validate inputs
            if (SeatRow == null || SeatRow.trim().isEmpty()
                    || SeatType == null || SeatType.trim().isEmpty()) {
                request.setAttribute("error", "Invalid input data");
                request.getRequestDispatcher("seat?service=listAll&RoomID=" + RoomID).forward(request, response);
                return;
            }

            Seat seat = new Seat(SeatRow, SeatNumber, SeatType, RoomID, Status);
            int n = sdao.insertSeat(seat);
            if (n > 0) {
                request.setAttribute("success", "Seat added successfully!");
            } else {
                request.setAttribute("error", "Failed to insert Seat");
            }

            // Redirect back to the same cinema view
            request.getRequestDispatcher("seat?service=listAll&RoomID=" + RoomID).forward(request, response);
            return;
        }

        // **Hiển thị danh sách ghế**
        String roomIDParam = request.getParameter("RoomID");
        Integer RoomID = null;
        List<Seat> seats;

        if (roomIDParam != null && !roomIDParam.isEmpty()) {
            try {
                RoomID = Integer.parseInt(roomIDParam);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid Room ID");
            }
        }

        if (RoomID == null) {
            // Nếu không chọn Room hoặc chọn "All Room", hiển thị tất cả ghế
            seats = sdao.getAllSeats();
        } else {
            // Nếu chọn một Room cụ thể, lấy ghế của phòng đó
            seats = sdao.getSeatsByRoom(RoomID);
        }

        List<Room> rooms = dao.getAllCinemaRooms();
        request.setAttribute("Seats", seats);
        request.setAttribute("Rooms", rooms);
        request.getRequestDispatcher("admin/seat-management.jsp").forward(request, response);
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
        return "Seat Management Controller";
    }
}
