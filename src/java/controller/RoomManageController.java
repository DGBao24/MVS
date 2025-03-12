package controller;

import entity.Cinema;
import entity.Room;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.CinemaRoomDAO;

@WebServlet(name = "RoomManageController", urlPatterns = {"/room"})
public class RoomManageController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        CinemaRoomDAO dao = new CinemaRoomDAO();

        try {
            // Always load cinema list for dropdowns
            List<Cinema> cinemas = dao.getAllCinemas();
            request.setAttribute("Cinemas", cinemas);

            String service = request.getParameter("service");
            if (service == null) {
                service = "listAll";
            }

            if (service.equals("updateRoom")) {
                int rid = Integer.parseInt(request.getParameter("rid"));
                String submit = request.getParameter("submit");
                if (submit == null) {
                    Room room = dao.getRoomID(rid);
                    request.setAttribute("room", room);
                    request.getRequestDispatcher("admin/updateRoom.jsp").forward(request, response);
                } else {
                    String RoomName = request.getParameter("RoomName");
                    String RoomType = request.getParameter("RoomType");
                    if (RoomName == null || RoomName.trim().isEmpty()
                            || RoomType == null || RoomType.trim().isEmpty()) {
                        request.setAttribute("error", "Invalid input data");
                        request.getRequestDispatcher("admin/updateRoom.jsp").forward(request, response);
                        return;
                    }
                     Room room = new Room(rid, RoomName, RoomType);
                     int n = dao.updateRoom(room);
                    if (n > 0) {
                        room = dao.getRoomID(room.getRoomID());
                        request.setAttribute("room", room);
                        request.setAttribute("success", "Update successful");
                        request.getRequestDispatcher("admin/updateRoom.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Update Failed");
                        request.getRequestDispatcher("admin/updateRoom.jsp").forward(request, response);
                    }
                }

            }

            if (service.equals("insertRoom")) {
                String RoomName = request.getParameter("RoomName");
                String RoomType = request.getParameter("RoomType");
                int CinemaID = Integer.parseInt(request.getParameter("CinemaID"));
                boolean Status = Boolean.parseBoolean(request.getParameter("Status"));

                // Validate inputs
                if (RoomName == null || RoomName.trim().isEmpty()
                        || RoomType == null || RoomType.trim().isEmpty()) {
                    request.setAttribute("error", "Invalid input data");

                    request.getRequestDispatcher("room?service=listAll&cinemaId=" + CinemaID).forward(request, response);
                    return;
                }

                Room room = new Room(CinemaID, RoomName, RoomType, Status);
                int n = dao.insertRoom(room);
                if (n > 0) {
                    request.setAttribute("success", "Room added successfully!");
                } else {
                    request.setAttribute("error", "Failed to insert Room");
                }

                // Redirect back to the same cinema view
                request.getRequestDispatcher("room?service=listAll&cinemaId=" + CinemaID).forward(request, response);
                return;
            }

            if (service.equals("DisableStatus")) {
                int rid = Integer.parseInt(request.getParameter("rid"));
                Room room = dao.getRoomID(rid);

                if (room == null) {
                    request.setAttribute("error", "Cannot found Room");
                } else {
                    boolean newStatus = !room.isStatus();
                    Room ro = new Room(rid, newStatus);
                    int updated = dao.disableRoom(ro);

                    if (updated > 0) {
                        request.setAttribute("success", "Status updated successfully!");
                    } else {
                        request.setAttribute("error", "Update failed, please try again!");
                    }

                    // Get the current cinema filter if any
                    String currentCinemaId = request.getParameter("cinemaId");
                    // Redirect back maintaining the current filter
                    response.sendRedirect("room?service=listAll" + (currentCinemaId != null && !currentCinemaId.isEmpty() ? "&cinemaId=" + currentCinemaId : ""));
                    return;
                }
            }

            // Default action - list all rooms for selected cinema
            String cinemaIdStr = request.getParameter("cinemaId");
            Integer cinemaId = null;
            if (cinemaIdStr != null && !cinemaIdStr.isEmpty()) {
                try {
                    cinemaId = Integer.parseInt(cinemaIdStr);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid cinema ID");
                }
            }

            List<Room> rooms = dao.getRoomsByCinema(cinemaId);
            request.setAttribute("Room", rooms);
            request.getRequestDispatcher("admin/room-management.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/room-management.jsp").forward(request, response);
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

    @Override
    public String getServletInfo() {
        return "Room Management Controller";
    }
}
