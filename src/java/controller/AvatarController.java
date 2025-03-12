package controller;

import entity.Account;
import entity.Image;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.UUID;
import model.DAOAccount;
import model.DAOImage;

@WebServlet(name = "AvatarController", urlPatterns = {"/AvatarController"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AvatarController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        DAOAccount dao = new DAOAccount();
        DAOImage daoImage = new DAOImage();

        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            String submit = request.getParameter("submit");

            // Kiểm tra service và submit
            if (service.equals("ChangeAvatar")) {
                Integer cid = (Integer) session.getAttribute("CustomerID");
                    String contentType = request.getContentType();
                    if (contentType == null || !contentType.toLowerCase().startsWith("multipart/")) {
                       
                        response.sendRedirect("ChangeAvatar.jsp");
                        return;
                    }
                if (cid == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                if (submit == null) {
                    Account customer = dao.getAccountById(cid);
                    session.setAttribute("account", customer);
                    
                } else {

                    // Lấy file ảnh từ request
                    Part filePart = request.getPart("avatar");
                    if (filePart == null || filePart.getSize() == 0) {
                        request.setAttribute("errorMessage", "Bạn chưa chọn ảnh!");
                        response.sendRedirect("ChangeAvatar.jsp");
                        return;
                    }

                    // Kiểm tra định dạng file
                    String fileType = filePart.getContentType();
                    if (!fileType.startsWith("image/")) {
                        request.setAttribute("errorMessage", "Chỉ được tải lên file ảnh!");
                        response.sendRedirect("ChangeAvatar.jsp");
                        return;
                    }

                    // Giới hạn kích thước file (5MB)
                    if (filePart.getSize() > 5 * 1024 * 1024) {
                        request.setAttribute("errorMessage", "Dung lượng ảnh quá lớn! (Tối đa 5MB)");
                        request.getRequestDispatcher("ChangeAvatar.jsp").forward(request, response);
                        return;
                    }

                    // Đổi tên file để tránh trùng lặp
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String extension = fileName.substring(fileName.lastIndexOf("."));
                    String uniqueFileName = UUID.randomUUID().toString() + extension;

                    // Lưu file vào thư mục uploads
                    String uploadDir = request.getServletContext().getRealPath("") + File.separator + "images";
                    File uploadPath = new File(uploadDir);
                    if (!uploadPath.exists()) {
                        uploadPath.mkdir();
                    }

                    String filePath = uploadDir + File.separator + uniqueFileName;
                    filePart.write(filePath);

                    // Chỉ lưu đường dẫn tương đối vào database
                    String relativePath = "images/" + uniqueFileName;
                    int imageId = daoImage.saveImage(relativePath);

                    if (imageId == -1) {
                        request.setAttribute("errorMessage", "Lỗi khi lưu ảnh, vui lòng thử lại.");
                       response.sendRedirect("ChangeAvatar.jsp");
                        return;
                    }

                    if (imageId > 0) {
                        int updated = dao.updateAvatar(cid, imageId);

                        if (updated > 0) {
                            Image newAvatar = new Image();
                            newAvatar.setImageID(imageId);
                            newAvatar.setImagePath(relativePath);

                            Account updatedCustomer = dao.getAccountById(cid);
//                    customer.setAvatar(newAvatar);
                            session.setAttribute("account", updatedCustomer);

                            response.sendRedirect("AvatarController?service=ChangeAvatar");
                        } else {
                            request.setAttribute("errorMessage", "Cập nhật avatar thất bại!");
                            response.sendRedirect("ChangeAvatar.jsp");
                        }
                    } else {
                        request.setAttribute("errorMessage", "Lưu ảnh thất bại!");
                        response.sendRedirect("ChangeAvatar.jsp");
                    }
                }
            }
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
