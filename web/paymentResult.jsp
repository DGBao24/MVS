<%-- 
    Document   : paymentResult
    Created on : Mar 23, 2025, 3:04:41 PM
    Author     : pdatt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả thanh toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body text-center">
                        <% 
                            Boolean transResult = (Boolean)request.getAttribute("transResult");
                            if (transResult == null) {
                                response.sendRedirect("ticket-confirmation.jsp?mess=Lỗi: Không tìm thấy kết quả giao dịch");
                                return;
                            }
                            
                            if (transResult) { 
                        %>
                            <div class="mb-4">
                                <i class="fas fa-check-circle text-success" style="font-size: 64px;"></i>
                            </div>
                            <h2 class="card-title text-success mb-4">Thanh toán thành công!</h2>
                            <p class="card-text">Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi.</p>
                            <p class="card-text">Vé của bạn đã được xác nhận và gửi đến email của bạn.</p>
                        <% } else { %>
                            <div class="mb-4">
                                <i class="fas fa-times-circle text-danger" style="font-size: 64px;"></i>
                            </div>
                            <h2 class="card-title text-danger mb-4">Thanh toán thất bại!</h2>
                            <p class="card-text">Đã có lỗi xảy ra trong quá trình thanh toán.</p>
                            <p class="card-text">Vui lòng thử lại hoặc liên hệ với chúng tôi để được hỗ trợ.</p>
                        <% } %>
                        <div class="mt-4">
                            <a href="home" class="btn btn-primary">Về trang chủ</a>
                            <a href="ticket-confirmation.jsp" class="btn btn-secondary">Xem chi tiết đơn hàng</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
