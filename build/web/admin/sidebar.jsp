<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/admin">
        <div class="sidebar-brand-text mx-3">Movie Ticket Admin</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin">
            <span>Dashboard</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Management
    </div>

    <!-- Nav Item - Account Management -->
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/account?service=ListAllCustomer">
            <span>Account Management</span>
        </a>
    </li>

    <!-- Nav Item - Movie Management -->
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/movie">
            <span>Movie Management</span>
        </a>
    </li>

    <!-- Nav Item - Showtime Management -->
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/showtime?service=listAll">
            <span>Showtime Management</span>
        </a>
    </li>

    <!-- Nav Item - Promotion Management -->
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/promo">
            <span>Promotion Management</span>
        </a>
    </li>

    <!-- Nav Item - Combo Management -->
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/combo">
            <span>Combo Management</span>
        </a>
    </li>

    <!-- Nav Item - Cinema Management -->
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/CinemaManageController">
            
            <span>Cinema Manage</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/room?service=listAll&cinemaId=">
            
            <span>Room Management</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/seat?service=listAll&RoomID=">
           
            <span>Seat Management</span>
        </a>
    </li>
    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul> 
<!-- End of Sidebar -->
