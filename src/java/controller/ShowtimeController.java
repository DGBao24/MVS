package controller;

import entity.Cinema;
import entity.Movie;
import entity.Room;
import entity.Showtime;
import model.DAOShowtime;
import model.BookingDAO;
import model.CinemaDAO;
import model.MovieDAO;
import java.sql.ResultSet;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ShowtimeController", urlPatterns = {"/admin/showtime"})
public class ShowtimeController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");
        DAOShowtime show = new DAOShowtime();

        if (service == null) {
            service = "listAll";
        }

        String submit = request.getParameter("add");

        if (service.equals("listAll")) {
            ResultSet rsMov = show.getData("SELECT MovieID, MovieName FROM Movie");
            request.setAttribute("rsMov", rsMov);

            ResultSet rsCin = show.getData("SELECT CinemaID, CinemaName FROM Cinema");
            request.setAttribute("rsCin", rsCin);
            List<Showtime> showtime = show.getAllShowtimes();
            request.setAttribute("showtime", showtime);
            request.getRequestDispatcher("/admin/showtime-management.jsp").forward(request, response);

        }
        if (service.equals("addShowtime")) {
            // Luôn lấy danh sách movie và cinema
            ResultSet rsMov = show.getData("SELECT MovieID, MovieName FROM Movie");
            request.setAttribute("rsMov", rsMov);

            ResultSet rsCin = show.getData("SELECT CinemaID, CinemaName FROM Cinema");
            request.setAttribute("rsCin", rsCin);
            
            // Lấy danh sách showtime hiện tại
            List<Showtime> showtime = show.getAllShowtimes();
            request.setAttribute("showtime", showtime);

            String movieID = request.getParameter("MovieID");
            String cinemaID = request.getParameter("CinemaID");
            String startTime = request.getParameter("StartTime");
            String roomID = request.getParameter("RoomID");
            String endTime = request.getParameter("EndTime");

            // Nếu có Cinema được chọn, lấy danh sách phòng
            if (cinemaID != null && !cinemaID.isEmpty()) {
                request.setAttribute("selectedCinemaID", cinemaID);
                ResultSet rsRoo = show.getData("SELECT RoomID, RoomName, RoomType FROM CinemaRoom WHERE CinemaID = " + cinemaID);
                request.setAttribute("rsRoo", rsRoo);
            }

            if (request.getParameter("add") != null) {
                StringBuilder errorMessage = new StringBuilder();
                
                // Kiểm tra từng trường và tích lũy thông báo lỗi
                if (movieID == null || movieID.isEmpty()) {
                    errorMessage.append("Vui lòng chọn phim. ");
                }
                if (cinemaID == null || cinemaID.isEmpty()) {
                    errorMessage.append("Vui lòng chọn rạp. ");
                }
                if (roomID == null || roomID.isEmpty()) {
                    errorMessage.append("Vui lòng chọn phòng chiếu. ");
                }
                if (startTime == null || startTime.isEmpty()) {
                    errorMessage.append("Vui lòng chọn thời gian bắt đầu. ");
                }
                if (endTime == null || endTime.isEmpty()) {
                    errorMessage.append("Vui lòng chọn thời gian kết thúc. ");
                }

                // Nếu không có lỗi, tiến hành thêm showtime
                if (errorMessage.length() == 0) {
                    try {
                        int mid = Integer.parseInt(movieID);
                        int cid = Integer.parseInt(cinemaID);
                        int rid = Integer.parseInt(roomID);
                        
                        // Chuyển đổi định dạng thời gian từ HTML datetime-local sang Timestamp
                        startTime = startTime.replace("T", " ") + ":00";
                        endTime = endTime.replace("T", " ") + ":00";
                        
                        Timestamp StartTime = Timestamp.valueOf(startTime);
                        Timestamp EndTime = Timestamp.valueOf(endTime);

                        // Kiểm tra thời gian hợp lệ
                        if (EndTime.before(StartTime)) {
                            request.setAttribute("message", "Thời gian kết thúc phải sau thời gian bắt đầu!");
                        } else {
                            Showtime showtimes = new Showtime(mid, cid, rid, StartTime, EndTime);
                            int n = show.insertShowtime(showtimes);
                            if (n > 0) {
                                request.setAttribute("message", "Thêm suất chiếu thành công!");
                                // Cập nhật lại danh sách showtime
                                showtime = show.getAllShowtimes();
                                request.setAttribute("showtime", showtime);
                            } else {
                                request.setAttribute("message", "Thêm suất chiếu thất bại!");
                            }
                        }
                    } catch (Exception e) {
                        request.setAttribute("message", "Lỗi xử lý dữ liệu: " + e.getMessage());
                    }
                } else {
                    request.setAttribute("message", errorMessage.toString());
                }
            }
            request.getRequestDispatcher("/admin/showtime-management.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
