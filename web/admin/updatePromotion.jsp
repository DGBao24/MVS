<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, entity.Promotion" %>
<%
    List<Promotion> list = (List)request.getAttribute("list");
    Promotion promotion = list.get(0);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Promotion</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2>Update Promotion</h2>
            <form action="promo" method="POST">
                <input type="hidden" name="service" value="updatePromotion">
                <input type="hidden" name="submit" value="true">
             
                 <div class="mb-3">
                    <label class="form-label">PromotionID:</label>
                    <input type="text" class="form-control" name="PromotionID" value="<%=promotion.getPromotionID()%>" readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label">Promo Code:</label>
                    <input type="text" class="form-control" name="PromoCode" value="<%=promotion.getPromoCode()%>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Discount Percent:</label>
                    <input type="number" class="form-control" name="DiscountPercent" value="<%=promotion.getDiscountPercent()%>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Start Date:</label>
                    <input type="date" class="form-control" name="StartDate" value="<%=promotion.getStartDate()%>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">End Date:</label>
                    <input type="date" class="form-control" name="EndDate" value="<%=promotion.getEndDate()%>" required>
                </div>
                
                 <div class="mb-3">
                    <label class="form-label">Status:</label>
                    <select class="form-control" name="Status" required>
                        <option value="true" <%= promotion.isStatus() ? "selected" : "" %>>Active</option>
                        <option value="false" <%= !promotion.isStatus() ? "selected" : "" %>>Inactive</option>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Description:</label>
                    <textarea class="form-control" name="Description" required><%=promotion.getDescription()%></textarea>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Remain Redemption:</label>
                    <input type="number" class="form-control" name="RemainRedemption" value="<%=promotion.getRemainRedemption()%>" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Update Promotion</button>
                <a href="promo?service=listAll" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </body>
</html>
