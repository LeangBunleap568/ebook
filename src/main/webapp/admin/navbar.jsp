<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* ========================================
       ADMIN TOPBAR - REFINED SLATE THEME
       ======================================== */

    .custom-admin-nav {
        background-color: #1e293b;
        border-bottom: 1px solid #334155;
        padding: 0 1rem;
        z-index: 1030;
        min-height: 52px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    }

    /* ========================================
       BRAND
       ======================================== */

    .custom-admin-nav .navbar-brand {
        color: #f8fafc !important;
        font-size: 15px;
        font-weight: 700;
        letter-spacing: -0.3px;
        padding: 10px 0;
        display: flex;
        align-items: center;
        transition: opacity 0.2s ease;
    }

    .custom-admin-nav .navbar-brand:hover {
        opacity: 0.9;
    }

    .custom-admin-nav .navbar-brand i {
        color: #0ea5e9;
        font-size: 17px;
    }

    /* ========================================
       NAVIGATION LINKS
       ======================================== */

    .custom-admin-nav .nav-link {
        color: #94a3b8 !important;
        font-size: 13px;
        font-weight: 500;
        padding: 14px 16px !important;
        border-radius: 0;
        border-bottom: 2px solid transparent;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
    }

    /* Hover */
    .custom-admin-nav .nav-link:hover {
        color: #f8fafc !important;
        background-color: rgba(255, 255, 255, 0.03);
    }

    /* Active */
    .custom-admin-nav .nav-link.active {
        color: #ffffff !important;
        background-color: rgba(14, 165, 233, 0.1);
        border-bottom-color: #0ea5e9;
        font-weight: 600;
    }

    .custom-admin-nav .nav-link i {
        font-size: 14px;
        opacity: 0.85;
    }

    .custom-admin-nav .nav-link:hover i,
    .custom-admin-nav .nav-link.active i {
        opacity: 1;
    }

    /* ========================================
       LOGOUT BUTTON
       ======================================== */

    .custom-admin-nav .logout-btn {
        color: #ef4444;
        background-color: #fef2f2;
        border: 1px solid #fecaca;
        font-size: 12px;
        font-weight: 600;
        padding: 5px 14px;
        border-radius: 6px;
        transition: all 0.2s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
    }

    .custom-admin-nav .logout-btn:hover {
        color: #ffffff;
        background-color: #ef4444;
        border-color: #ef4444;
    }

    /* ========================================
       MOBILE TOGGLER
       ======================================== */

    .custom-admin-nav .navbar-toggler {
        border: 1px solid #475569;
        padding: 4px 8px;
        border-radius: 6px;
    }

    .custom-admin-nav .navbar-toggler:focus {
        box-shadow: 0 0 0 2px rgba(14, 165, 233, 0.25);
    }

    .custom-admin-nav .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28248, 250, 252, 0.85%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    /* ========================================
       RESPONSIVE
       ======================================== */

    @media (max-width: 991px) {
        .custom-admin-nav .navbar-collapse {
            background-color: #0f172a;
            margin: 8px -1rem -8px -1rem;
            padding: 12px 1rem;
            border-top: 1px solid #334155;
            border-bottom: 1px solid #334155;
        }

        .custom-admin-nav .nav-link {
            border-bottom: none;
            border-left: 3px solid transparent;
            padding: 10px 14px !important;
            border-radius: 4px;
            margin-bottom: 2px;
        }

        .custom-admin-nav .nav-link.active {
            border-bottom-color: transparent;
            border-left-color: #0ea5e9;
        }

        .custom-admin-nav .logout-btn {
            margin-top: 10px;
            width: 100%;
            justify-content: center;
        }
    }
</style>

<!-- ========================================
     ADMIN NAVBAR
     ======================================== -->

<nav class="navbar navbar-expand-lg custom-admin-nav sticky-top">
    <div class="container-fluid px-3">

        <!-- BRAND -->
        <a class="navbar-brand fw-bold me-4" href="${pageContext.request.contextPath}/admin/home">
            <i class="fas fa-book-reader me-2"></i>Ebook Admin
        </a>

        <!-- MOBILE TOGGLER -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar" aria-controls="adminNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- NAVIGATION CONTENT -->
        <div class="collapse navbar-collapse" id="adminNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <!-- HOME -->
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/home">
                        <i class="fas fa-home me-2"></i> Home
                    </a>
                </li>

                <!-- ALL BOOKS -->
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'all_books' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/all_books.jsp">
                        <i class="fas fa-book me-2"></i> All Books
                    </a>
                </li>

                <!-- ADD BOOK -->
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'add_books' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/add_books.jsp">
                        <i class="fas fa-plus-circle me-2"></i> Add Book
                    </a>
                </li>

                <!-- ORDERS -->
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'orders' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/orders.jsp">
                        <i class="fas fa-shopping-cart me-2"></i> Orders
                    </a>
                </li>

                <!-- USERS -->
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'users' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/users">
                        <i class="fas fa-users me-2"></i> Users
                    </a>
                </li>

            </ul>

            <!-- LOGOUT BUTTON -->
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/logout" class="btn logout-btn">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </a>
            </div>
        </div>

    </div>
</nav>
