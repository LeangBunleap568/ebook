<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* ========================================
       WHITE ADMIN NAVBAR
       ======================================== */

    .custom-admin-nav {
        background-color: #ffffff;
        border-bottom: 1px solid #e5e7eb;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
        padding: 10px 0;
        z-index: 1030;
    }

    /* ========================================
       BRAND
       ======================================== */

    .custom-admin-nav .navbar-brand {
        color: #1f2937 !important;
        font-size: 18px;
        font-weight: 700;
        letter-spacing: -0.2px;
        transition: color 0.2s ease;
    }

    .custom-admin-nav .navbar-brand:hover {
        color: #0d6efd !important;
    }

    .custom-admin-nav .navbar-brand i {
        color: #0d6efd;
        font-size: 20px;
    }

    /* ========================================
       NAVIGATION LINKS
       ======================================== */

    .custom-admin-nav .nav-link {
        color: #4b5563 !important;
        font-size: 14px;
        font-weight: 500;
        padding: 8px 14px !important;
        border-radius: 8px;
        transition: all 0.2s ease;
    }

    /* Hover */
    .custom-admin-nav .nav-link:hover {
        color: #0d6efd !important;
        background-color: #f0f6ff;
    }

    /* Active */
    .custom-admin-nav .nav-link.active {
        color: #0d6efd !important;
        background-color: #eaf3ff;
        font-weight: 600;
    }

    .custom-admin-nav .nav-link i {
        font-size: 14px;
    }

    /* ========================================
       LOGOUT BUTTON
       ======================================== */

    .custom-admin-nav .logout-btn {
        color: #dc3545;
        background-color: transparent;
        border: 1px solid #dc3545;
        font-size: 14px;
        font-weight: 500;
        padding: 7px 16px;
        transition: all 0.2s ease;
    }

    .custom-admin-nav .logout-btn:hover {
        color: #ffffff;
        background-color: #dc3545;
        border-color: #dc3545;
        box-shadow: 0 3px 8px rgba(220, 53, 69, 0.2);
    }

    /* ========================================
       MOBILE TOGGLER
       ======================================== */

    .custom-admin-nav .navbar-toggler {
        border: 1px solid #d1d5db;
        padding: 6px 9px;
        border-radius: 7px;
    }

    .custom-admin-nav .navbar-toggler:hover {
        background-color: #f3f4f6;
    }

    .custom-admin-nav .navbar-toggler:focus {
        box-shadow: 0 0 0 2px rgba(13, 110, 253, 0.15);
    }

    /*
     * Bootstrap's navbar-toggler-icon is white by default
     * because navbar-dark was removed.
     * This makes the icon dark.
     */
    .custom-admin-nav .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%2831, 41, 55, 0.85%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    /* ========================================
       NAVBAR CONTAINER
       ======================================== */

    .custom-admin-nav .container-fluid {
        min-height: 42px;
    }

    /* ========================================
       RESPONSIVE
       ======================================== */

    @media (max-width: 991px) {

        .custom-admin-nav {
            padding: 8px 0;
        }

        .custom-admin-nav .navbar-brand {
            font-size: 17px;
        }

        .custom-admin-nav .navbar-collapse {
            margin-top: 12px;
            padding-top: 10px;
            border-top: 1px solid #f0f0f0;
        }

        .custom-admin-nav .navbar-nav {
            gap: 4px !important;
        }

        .custom-admin-nav .nav-link {
            padding: 10px 14px !important;
        }

        .custom-admin-nav .logout-btn {
            margin-top: 10px;
            width: 100%;
            text-align: center;
        }
    }

    /* ========================================
       SMALL MOBILE
       ======================================== */

    @media (max-width: 576px) {

        .custom-admin-nav .container-fluid {
            padding-left: 15px !important;
            padding-right: 15px !important;
        }

        .custom-admin-nav .navbar-brand {
            font-size: 16px;
        }

        .custom-admin-nav .navbar-brand i {
            font-size: 18px;
        }
    }
</style>


<!-- ========================================
     ADMIN NAVBAR
     ======================================== -->

<nav class="navbar navbar-expand-lg custom-admin-nav sticky-top">

    <div class="container-fluid px-4">

        <!-- ========================================
             BRAND
             ======================================== -->

        <a class="navbar-brand fw-bold me-4"
           href="${pageContext.request.contextPath}/admin/home.jsp">

            <i class="fas fa-book-reader me-2"></i>
           Admin

        </a>


        <!-- ========================================
             MOBILE TOGGLER
             ======================================== -->

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#adminNavbar"
                aria-controls="adminNavbar"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>

        </button>


        <!-- ========================================
             NAVIGATION CONTENT
             ======================================== -->

        <div class="collapse navbar-collapse" id="adminNavbar">


            <!-- ========================================
                 NAVIGATION ITEMS
                 ======================================== -->

            <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-1">


                <!-- HOME -->
                <li class="nav-item">

                    <a class="nav-link ${activePage == 'home' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin/home.jsp">

                        <i class="fas fa-home me-1"></i>
                        Home

                    </a>

                </li>


                <!-- ALL BOOKS -->
                <li class="nav-item">

                    <a class="nav-link ${activePage == 'allBooks' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin/all_books.jsp">

                        <i class="fas fa-book me-1"></i>
                        All Books

                    </a>

                </li>


                <!-- ADD BOOK -->
                <li class="nav-item">

                    <a class="nav-link ${activePage == 'addBook' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin/add_books.jsp">

                        <i class="fas fa-plus-circle me-1"></i>
                        Add Book

                    </a>

                </li>


                <!-- ORDERS -->
                <li class="nav-item">

                    <a class="nav-link ${activePage == 'orders' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin/all_order.jsp">

                        <i class="fas fa-shopping-cart me-1"></i>
                        Orders

                    </a>

                </li>


            </ul>


            <!-- ========================================
                 LOGOUT BUTTON
                 ======================================== -->

            <div class="d-flex align-items-center">

                <a href="${pageContext.request.contextPath}/logout"
                   class="btn logout-btn rounded-pill">

                    <i class="fas fa-sign-out-alt me-1"></i>
                    Logout

                </a>

            </div>


        </div>

    </div>

</nav>

