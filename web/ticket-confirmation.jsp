<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Xác Nhận Đặt Vé</title>
</head>
<body>
    <h2>Thông Tin Vé Đặt Thành Công</h2>
    
    <p><strong>Mã Ghế:</strong> ${seatID}</p>
    <p><strong>Mã Suất Chiếu:</strong> ${showtimeID}</p>
    <p><strong>Mã Rạp:</strong> ${cinemaID}</p>
    <p><strong>Mã Phòng:</strong> ${roomID}</p>
    <p><strong>Thời Gian Chiếu:</strong> ${startTime}</p>
    <c:if test="${not empty comboID}">
        <p><strong>Mã Combo:</strong> ${comboID}</p>
    </c:if>
    
    <p><a href="index.jsp">Quay về trang chủ</a></p>
</body>
</html>
