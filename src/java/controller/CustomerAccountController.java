/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Account;
import entity.Image;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Vector;
import model.DAOAccount;
import utils.Validation;
import java.io.File;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import model.DAOImage;

/**
 *
 * @author pdatt
 */
@WebServlet(name = "CustomerAccountController", urlPatterns = {"/account"})

public class CustomerAccountController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        DAOAccount dao = new DAOAccount();
        DAOImage daoImage = new DAOImage();
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String service = request.getParameter("service");

            if (service.equals("changeCustomerProfile")) {
                Integer cid = (Integer) session.getAttribute("CustomerID");

                if (cid == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                Account customer = dao.getAccountById(cid);
                String submit = request.getParameter("submit");

                if (submit == null) {
                    request.setAttribute("dataCustomer", customer);
                    response.sendRedirect(request.getContextPath() + "/Profile.jsp");
                } else {

                    request.setCharacterEncoding("UTF-8");
                    String Name = request.getParameter("Name");

                    String Address = request.getParameter("Address");
                    String PhoneNum = request.getParameter("PhoneNum");
                    String YearOfBirth = request.getParameter("YearOfBirth");
                    String Gender = request.getParameter("Gender");

                    if (Name.isEmpty() || Address.isEmpty() || PhoneNum.isEmpty() || YearOfBirth.isEmpty() || Gender.isEmpty()) {
                        request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin!");
                        response.sendRedirect(request.getContextPath() + "/Profile.jsp");
                        return;
                    }

                    int YearOfBirtH;
                    try {
                        YearOfBirtH = Integer.parseInt(YearOfBirth);
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "Năm sinh không hợp lệ!");
                        response.sendRedirect(request.getContextPath() + "/Profile.jsp");
                        return;
                    }

                    // Cập nhật thông tin khách hàng
                    Account acc = new Account(cid, Name, PhoneNum, Address, YearOfBirtH, Gender);
                    int updated = dao.updateCustomer(acc);

                    if (updated > 0) {

                        Account updatedCustomer = dao.getAccountById(customer.getAccountID());
                        session.setAttribute("account", updatedCustomer);

                        request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
                        response.sendRedirect(request.getContextPath() + "/Profile.jsp");
                    } else {
                        request.setAttribute("errorMessage", "Cập nhật thất bại, vui lòng thử lại!");
                        response.sendRedirect(request.getContextPath() + "/Profile.jsp");
                    }
                }
            }

            if (service.equals("changePassword")) {
                Integer cid = (Integer) session.getAttribute("CustomerID");

                if (cid == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                Account customer = dao.getAccountById(cid);
                String submit = request.getParameter("submit");

                if (submit == null) {
                    request.setAttribute("dataCustomer", customer);
                    request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                } else {
                    String currentPassword = request.getParameter("currentPassword");
                    String newPassword = request.getParameter("newPassword");
                    String confirmPassword = request.getParameter("confirmPassword");

                    // Kiểm tra nếu có ô nào bị bỏ trống
                    if (currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                        request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin!");
                        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                        return;
                    }

                    // Kiểm tra mật khẩu cũ có đúng không
                    if (!customer.getPassword().equals(currentPassword)) {
                        request.setAttribute("errorMessage", "Mật khẩu cũ không chính xác!");
                        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                        return;
                    }

                    // Kiểm tra mật khẩu mới và xác nhận mật khẩu mới có khớp không
                    if (!newPassword.equals(confirmPassword)) {
                        request.setAttribute("errorMessage", "Mật khẩu mới không khớp, vui lòng nhập lại!");
                        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                        return;
                    }

                    if (!Validation.checkPassWord(newPassword)) {
                        request.setAttribute("errorMessage", "Password must have at least 6 characters, including uppercase letters, lowercase letters, numbers, and special characters.");
                        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                        return;
                    }

                    // Cập nhật mật khẩu trong database
                    int updated = dao.updatePassword(cid, newPassword);

                    if (updated > 0) {
                        request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
                        request.getRequestDispatcher("home.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "Có lỗi xảy ra, vui lòng thử lại!");
                        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                    }
                }

            }

            if (service.equals("ListAllCustomer")) {
                String sql = "select * from Account";
                List<Account> customers = dao.getAllCustomers(sql);
                request.setAttribute("customers", customers);
                request.getRequestDispatcher("/admin/account-management.jsp").forward(request, response);
            }

            if (service.equals("DisableAccount")) {
                int cid = Integer.parseInt(request.getParameter("cid"));
                String submit = request.getParameter("submit");

                // Lấy thông tin tài khoản hiện tại
                Account customer = dao.getAccountById(cid);

                if (submit != null) { // Khi bấm vào nút kích hoạt / vô hiệu hóa
                    if (customer == null) {
                        request.setAttribute("errorMessage", "Không tìm thấy tài khoản!");
                        response.sendRedirect("account?service=ListAllCustomer");
                        return;
                    }

                    // Đảo trạng thái tài khoản
                    boolean newStatus = !customer.isStatus();
                    Account acc = new Account(cid, newStatus);
                    int updated = dao.disableAccount(acc);

                    // Kiểm tra cập nhật thành công hay không
                    if (updated > 0) {
                        request.getSession().setAttribute("successMessage", "Cập nhật trạng thái thành công!");
                    } else {
                        request.getSession().setAttribute("errorMessage", "Cập nhật thất bại, vui lòng thử lại!");
                    }

                    // Redirect để tránh lỗi khi F5
                    response.sendRedirect("account?service=ListAllCustomer");
                } else { // Trường hợp chỉ vào trang danh sách
                    List<Account> accounts = dao.getAllCustomers("SELECT * FROM Account");
                    request.setAttribute("customers", accounts);
                    request.getRequestDispatcher("admin/account-management.jsp").forward(request, response);
                }
            }

            if (service.equals("searchByName")) {
                request.setCharacterEncoding("UTF-8");
                String cname = request.getParameter("cname");
                String sql = "SELECT * from Account Where Name like '%" + cname + "%'";
                List<Account> accounts = dao.getAllCustomers(sql); // Viết phương thức này trong DAO
                request.setAttribute("customers", accounts);
                request.getRequestDispatcher("/admin/account-management.jsp").forward(request, response);
            }
            
            if (service.equals("CreateManager")) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String re_password = request.getParameter("confirm_password");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String yearOfBirth = request.getParameter("yearOfBirth");
                String gender = request.getParameter("Gender");
                try {
                    int YOB = Integer.parseInt(yearOfBirth);

                    // Check if passwords match
                    if (!password.equals(re_password)) {
                        request.setAttribute("mess", "Your password does not match.");
                        request.getRequestDispatcher("/admin/createManager.jsp").forward(request, response);
                        return;
                    }

                    // Check if email exists
                    if (dao.isEmailExist(email)) {
                        request.setAttribute("mess", "This email is already existed! Please try another email!");
                        request.getRequestDispatcher("/admin/createManager.jsp").forward(request, response);
                        return;
                    }

                    if (!Validation.checkPassWord(password)) {
                        request.setAttribute("mess", "Password must have at least 6 characters, including uppercase letters, lowercase letters, and special characters");
                        request.getRequestDispatcher("/admin/createManager.jsp").forward(request, response);
                        return;
                    }

                    if (dao.isEmailExist(email)) {
                        request.setAttribute("mess", "This email is already existed! Please try another email!");
                        request.getRequestDispatcher("/admin/createManager.jsp").forward(request, response);
                        return;
                    }
                    //Check if phone number exists
                    if (dao.isPhoneExist(phone)) {
                        request.setAttribute("mess", "This phone number is already existed!");
                        request.getRequestDispatcher("/admin/createManager.jsp").forward(request, response);
                        return;
                    }

                    if (!Validation.checkPhoneNum(phone)) {
                        request.setAttribute("mess", "Invalid phone number. Please enter a valid Vietnamese phone number.");
                        request.getRequestDispatcher("/admin/createManager.jsp").forward(request, response);
                        return;
                    }

                    // Create new account
                    int result = dao.createAccount(new Account(name, email, password, phone, address, YOB, true, "Manager", gender));

                    if (result > 0) {
                        // Success - redirect to home
                        response.sendRedirect("account?service=ListAllCustomer");
                    } else {
                        // Failed to create account
                        request.setAttribute("mess", "Failed to create account. Please try again.");
                        request.getRequestDispatcher("/admin/createManager.jsp").forward(request, response);
                    }
                } catch (NumberFormatException e) {
                    request.getRequestDispatcher("/admin/createManager.jsp").forward(request, response);
                } catch (Exception e) {
                    request.setAttribute("mess", "An error occurred: " + e.getMessage());
                    request.getRequestDispatcher("/admin/createManager.jsp").forward(request, response);
                }
            }

        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
