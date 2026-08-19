<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* ========================================
       CLOUD FOUNDRY ADMIN TOPBAR
       ======================================== */

    .custom-admin-nav {
        background-color: #34495e;
        border-bottom: 1px solid #2c3e50;
        padding: 0 15px;
        z-index: 1030;
        min-height: 48px;
    }

    /* ========================================
       BRAND
       ======================================== */

    .custom-admin-nav .navbar-brand {
        color: #ffffff !important;
        font-size: 15px;
        font-weight: 600;
        letter-spacing: -0.2px;
        padding: 10px 0;
        transition: opacity 0.2s ease;
    }

    .custom-admin-nav .navbar-brand:hover {
        opacity: 0.9;
    }

    .custom-admin-nav .navbar-brand i {
        color: #f39c12;
        font-size: 16px;
    }

    /* ========================================
       NAVIGATION LINKS
       ======================================== */

    .custom-admin-nav .nav-link {
        color: #bdc3c7 !important;
        font-size: 13px;
        font-weight: 500;
        padding: 12px 14px !important;
        border-radius: 0;
        border-bottom: 3px solid transparent;
        transition: all 0.2s ease;
    }

    /* Hover */
    .custom-admin-nav .nav-link:hover {
        color: #ffffff !important;
        background-color: rgba(255, 255, 255, 0.05);
    }

    /* Active */
    .custom-admin-nav .nav-link.active {
        color: #ffffff !important;
        background-color: #2c3846;
        border-bottom-color: #f39c12;
        font-weight: 600;
    }

    .custom-admin-nav .nav-link i {
        font-size: 13px;
    }

    /* ========================================
       LOGOUT BUTTON
       ======================================== */

    .custom-admin-nav .logout-btn {
        color: #e74c3c;
        background-color: transparent;
        border: 1px solid #e74c3c;
        font-size: 12px;
        font-weight: 500;
        padding: 4px 12px;
        border-radius: 3px;
        transition: all 0.2s ease;
    }

    .custom-admin-nav .logout-btn:hover {
        color: #ffffff;
        background-color: #e74c3c;
        border-color: #e74c3c;
    }

    /* ========================================
       MOBILE TOGGLER
       ======================================== */

    .custom-admin-nav .navbar-toggler {
        border: 1px solid #7f8c8d;
        padding: 4px 8px;
        border-radius: 3px;
    }

    .custom-admin-nav .navbar-toggler:focus {
        box-shadow: none;
    }

    .custom-admin-nav .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.85%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    /* ========================================
       RESPONSIVE
       ======================================== */

    @media (max-width: 991px) {
        .custom-admin-nav .navbar-collapse {
            background-color: #2c3846;
            margin: 0 -15px;
            padding: 10px 15px;
            border-top: 1px solid #1a252f;
        }

        .custom-admin-nav .nav-link {
            border-bottom: none;
            border-left: 3px solid transparent;
            padding: 8px 12px !important;
        }

        .custom-admin-nav .nav-link.active {
            border-bottom-color: transparent;
            border-left-color: #f39c12;
        }

        .custom-admin-nav .logout-btn {
            margin-top: 8px;
            width: 100%;
            text-align: center;
        }
    }
</style>

<!-- ========================================
     ADMIN NAVBAR
     ======================================== -->

<nav class="navbar navbar-expand-lg custom-admin-nav sticky-top">
    <div class="container-fluid px-3">

        <!-- BRAND -->
        <a class="navbar-brand fw-bold me-4" href="${pageContext.request.contextPath}/admin/home.jsp">
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
                    <a class="nav-link ${activePage == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/home.jsp">
                        <i class="fas fa-home me-1"></i> Home
                    </a>
                </li>

                <!-- ALL BOOKS -->
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'all_books' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/allBook.jsp">
                        <i class="fas fa-book me-1"></i> All Books
                    </a>
                </li>

                <!-- ADD BOOK -->
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'add_books' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/add_books.jsp">
                        <i class="fas fa-plus-circle me-1"></i> Add Book
                    </a>
                </li>

                <!-- ORDERS -->
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'orders' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/orders.jsp">
                        <i class="fas fa-shopping-cart me-1"></i> Orders
                    </a>
                </li>

            </ul>

            <!-- LOGOUT BUTTON -->
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/logout" class="btn logout-btn">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>

    </div>
</nav>