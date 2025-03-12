<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*, entity.Account, entity.Image" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*, jakarta.servlet.annotation.*" %>
<%@include file="Menulist.jsp" %>
<%
    // Lấy thông tin user từ session
    Object accObj = session.getAttribute("account");
    Account account = null;
    if (accObj instanceof Account) {
        account = (Account) accObj;
    }

    // Lấy thông tin avatar hiện tại
    Image avatar = account.getAvatar();
    
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thay Đổi Ảnh Đại Diện</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                margin: 20px;
            }
            .avatar-container {
                margin-bottom: 20px;
            }
            .avatar {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #333;
            }
            .error-message {
                color: red;
            }
        </style>
    </head>
    <body>

        <h2>Thay Đổi Ảnh Đại Diện</h2>

        <%-- Hiển thị avatar hiện tại --%>
        <div class="avatar-container">
            <img src="<%= avatar.getImagePath()%>" alt="Avatar" class="avatar">
        </div>

        <%-- Hiển thị lỗi nếu có --%>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) {%>
        <p class="error-message"><%= errorMessage%></p>
        <% }%>

        <%-- Form upload ảnh --%>
        <form action="AvatarController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="service" value="ChangeAvatar">
            <input type="file" name="avatar" accept="image/*" required>
            <br><br>
            <button type="submit" name="submit">Cập Nhật</button>
        </form>



        <br>
        <a href="home.jsp">Quay lại trang chủ</a>

    </body>
</html>
