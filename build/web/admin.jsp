<%-- 
    Document   : admin
    Created on : 12 thg 2, 2025, 19:33:23
    Author     : Tĩnh ăn loz
--%>



<%@ page import="entity.Account, utils.Role" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
    Account user = (Account) session.getAttribute("account");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("error.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Page</title>
</head>
<body>
    <h2>Admin Panel</h2>
    <a href="dashboard.jsp">Back to Dashboard</a>
    <a href="account?service=ListAllCustomer">Account Manager</a>
</body>
</html>

