<%-- 
    Document   : dashboard
    Created on : 12 thg 2, 2025, 19:32:42
    Author     : Tĩnh ăn loz
--%>


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>



<%@ page import="entity.Account" %>
<%
    Account user = (Account) session.getAttribute("account");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h2>Welcome, <%= user.getName() %>!</h2>
    <a href="admin.jsp">Admin Page</a> | <a href="home">User Page</a> | <a href="logout">Logout</a>
</body>
</html>

