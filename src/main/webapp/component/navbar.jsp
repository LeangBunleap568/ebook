<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.ebook.entity.user" %>
<%@ page import="com.ebook.dao.impl.CartDAOImpl" %>
<%@ page import="com.ebook.db.DBconnect" %>

<%-- Determine active URI dynamically --%>
<c:set var="currentUri" value="${requestScope['jakarta.servlet.include.request_uri']}" />
<c:if test="${empty currentUri}">
    <c:set var="currentUri" value="${pageContext.request.requestURI}" />
</c:if>

<!-- Custom Palette & Navbar Styling -->
<style>
    :root {
        --color-amber-yellow: #f5a623; 
        --color-coral-pink: #f05a66;   
        --color-emerald-green: #00b074; 
        --color-dark-slate: #2d404e;   
        --color-light-bg: #f5f7fa;     
        --color-card-white: #ffffff;   
        --color-input-bg: #eef2f5;     
        --color-input-border: #dcdfe3; 
        --color-text-dark: #2d404e;    
        --color-text-muted: #8c9ba5;   
        --color-text-light: #ffffff;   
    }

    .sticky-top-navbar {
        position: sticky;
        top: 0;
        z-index: 1030;
    }

    .top-header-bar {
        background-color: var(--color-card-white) !important;
        border-bottom: 1px solid var(--color-input-border);
    }

    .brand-title {
        color: var(--color-dark-slate);
        font-weight: 800;
        letter-spacing: -0.5px;
    }

    .brand-icon {
        color: var(--color-amber-yellow);
    }

    .search-input {
        background-color: var(--color-input-bg) !important;
        border: 1px solid var(--color-input-border) !important;
        color: var(--color-text-dark) !important;
    }

    .search-input:focus {
        border-color: var(--color-amber-yellow) !important;
        box-shadow: 0 0 0 0.25rem rgba(245, 166, 35, 0.25) !important;
    }

    .btn-search {
        background-color: var(--color-amber-yellow) !important;
        border-color: var(--color-amber-yellow) !important;
        color: var(--color-text-dark) !important;
        font-weight: 600;
    }

    .btn-search:hover {
        background-color: #e0951c !important;
        border-color: #e0951c !important;
    }

    .btn-user-profile {
        background-color: rgba(0, 176, 116, 0.15) !important;
        color: var(--color-emerald-green) !important;
        border: 1px solid var(--color-emerald-green) !important;
        font-weight: 600;
    }

    .btn-user-profile:hover {
        background-color: var(--color-emerald-green) !important;
        color: var(--color-text-light) !important;
    }

    .btn-cart-custom {
        border: 1px solid var(--color-input-border) !important;
        color: var(--color-dark-slate) !important;
        background-color: var(--color-card-white);
        font-weight: 600;
    }

    .btn-cart-custom:hover {
        background-color: var(--color-input-bg) !important;
        color: var(--color-dark-slate) !important;
    }

    .btn-logout-custom {
        background-color: var(--color-coral-pink) !important;
        border-color: var(--color-coral-pink) !important;
        color: var(--color-text-light) !important;
        font-weight: 600;
    }

    .btn-logout-custom:hover {
        background-color: #d94854 !important;
        border-color: #d94854 !important;
    }

    .btn-signin-custom {
        background-color: var(--color-amber-yellow) !important;
        border-color: var(--color-amber-yellow) !important;
        color: var(--color-text-dark) !important;
        font-weight: 600;
    }

    .btn-signin-custom:hover {
        background-color: #e0951c !important;
    }

    .btn-signup-custom {
        background-color: var(--color-coral-pink) !important;
        border-color: var(--color-coral-pink) !important;
        color: var(--color-text-light) !important;
        font-weight: 600;
    }

    .btn-signup-custom:hover {
        background-color: #d94854 !important;
    }

    .main-navbar {
        background-color: var(--color-dark-slate) !important;
        box-shadow: 0 4px 12px rgba(45, 64, 78, 0.15);
    }

    .navbar-nav .nav-link {
        position: relative;
        opacity: 0.85;
        color: var(--color-text-light) !important;
        font-weight: 500;
        transition: all 0.25s ease;
    }

    .navbar-nav .nav-link:hover,
    .navbar-nav .nav-link.active {
        opacity: 1;
        color: var(--color-amber-yellow) !important;
        font-weight: 600;
    }

    .navbar-nav .nav-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 3px;
        bottom: 2px;
        left: 50%;
        background-color: var(--color-amber-yellow);
        border-radius: 2px;
        transition: all 0.3s ease-in-out;
        transform: translateX(-50%);
    }

    .navbar-nav .nav-link:hover::after,
    .navbar-nav .nav-link.active::after {
        width: 100%;
    }

    .btn-contact-custom {
        background-color: var(--color-card-white) !important;
        color: var(--color-dark-slate) !important;
        border: none;
    }

    .btn-contact-custom:hover {
        background-color: var(--color-input-bg) !important;
    }

    .btn-setting-custom {
        background-color: var(--color-amber-yellow) !important;
        color: var(--color-text-dark) !important;
        border: none;
    }

    .btn-setting-custom:hover {
        background-color: #e0951c !important;
    }
</style>

<div class="sticky-top-navbar shadow-sm">
    <!-- Top Header Bar -->
    <div class="container-fluid px-4 py-3 top-header-bar">
        <div class="row align-items-center">
            <div class="col-md-3">
                <a href="${pageContext.request.contextPath}/index.jsp" class="text-decoration-none">
                    <h4 class="brand-title mb-0">
                        <i class="fas fa-book-open brand-icon me-2"></i>Ebook Store
                    </h4>
                </a>
            </div>
            <div class="col-md-5">
                <form class="d-flex" role="search" action="${pageContext.request.contextPath}/user/search.jsp" method="GET">
                    <input class="form-control search-input rounded-pill me-2 px-3 shadow-none" type="search" name="ch" placeholder="Search books..." aria-label="Search">
                    <button class="btn btn-search rounded-pill px-4 shadow-sm" type="submit">Search</button>
                </form>
            </div>
            <div class="col-md-4 text-end">
                <c:choose>
                    <c:when test="${(not empty userobj and userobj.email == 'admin@gmail.com') or pageContext.request.requestURI.contains('/admin/')}">
                        <a href="#" class="btn btn-user-profile btn-sm rounded-pill px-3 me-1">
                            <i class="fas fa-user-shield me-1"></i>Admin
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout-custom btn-sm rounded-pill px-3">
                            <i class="fas fa-sign-out-alt me-1"></i>Logout
                        </a>
                    </c:when>

                    <c:when test="${not empty userobj}">
                        <a href="${pageContext.request.contextPath}/user/setting.jsp" class="btn btn-user-profile btn-sm rounded-pill px-3 me-1">
                            <i class="fas fa-user me-1"></i>${userobj.name}
                        </a>
                        <%
                            int cartCount = 0;
                            user navUser = (user) session.getAttribute("userobj");
                            if(navUser != null) {
                                CartDAOImpl cartDao = new CartDAOImpl(DBconnect.getConn());
                                cartCount = cartDao.countCart(navUser.getId());
                            }
                        %>
                        <a href="${pageContext.request.contextPath}/user/cart.jsp" class="btn btn-cart-custom btn-sm rounded-pill px-3 me-1 shadow-sm">
                            <i class="fas fa-shopping-cart me-1" style="color: var(--color-coral-pink);"></i>Cart (<%= cartCount %>)
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout-custom btn-sm rounded-pill px-3">
                            <i class="fas fa-sign-out-alt me-1"></i>Logout
                        </a>
                    </c:when>

                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-signin-custom btn-sm rounded-pill px-3 me-1 shadow-sm">
                            <i class="fas fa-sign-in-alt me-1"></i>Sign In
                        </a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-signup-custom btn-sm rounded-pill px-3 shadow-sm">
                            <i class="fas fa-user-plus me-1"></i>Register
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Main Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark main-navbar">
        <div class="container-fluid px-4">
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain" aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarMain">
                <c:choose>
                    <c:when test="${(not empty userobj and userobj.email == 'admin@gmail.com') or pageContext.request.requestURI.contains('/admin/')}">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item me-2">
                                <a class="nav-link ${currentUri.endsWith('/admin/home.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/home.jsp">
                                    <i class="fas fa-home me-1"></i>Home
                                </a>
                            </li>
                            <li class="nav-item me-2">
                                <a class="nav-link ${currentUri.endsWith('/admin/add_books.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/add_books.jsp">
                                    <i class="fas fa-plus-circle me-1"></i>Add Books
                                </a>
                            </li>
                            <li class="nav-item me-2">
                                <a class="nav-link ${currentUri.endsWith('/admin/allBook.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/allBook.jsp">
                                    <i class="fas fa-book-open me-1"></i>All Books
                                </a>
                            </li>
                            <li class="nav-item me-2">
                                <a class="nav-link ${currentUri.endsWith('/admin/orders.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/orders.jsp">
                                    <i class="fas fa-box-open me-1"></i>Orders
                                </a>
                            </li>
                        </ul>
                    </c:when>

                    <c:otherwise>
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item me-2">
                                <a class="nav-link ${currentUri.endsWith('/index.jsp') or currentUri.endsWith('/') ? 'active' : ''}" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                            </li>
                            <li class="nav-item me-2">
                                <a class="nav-link ${currentUri.endsWith('/user/all_recent_book.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/all_recent_book.jsp">Recent Book</a>
                            </li>
                            <li class="nav-item me-2">
                                <a class="nav-link ${currentUri.endsWith('/user/all_new_book.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/all_new_book.jsp">New Book</a>
                            </li>
                            <li class="nav-item me-2">
                                <a class="nav-link ${currentUri.endsWith('/user/all_old_book.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/all_old_book.jsp">Old Book</a>
                            </li>
                        </ul>
                        <div class="d-flex align-items-center gap-2">
                            <a href="${pageContext.request.contextPath}/user/contact.jsp" class="btn btn-contact-custom btn-sm rounded-pill px-3 fw-bold">Contact Us</a>
                            <a href="${pageContext.request.contextPath}/user/setting.jsp" class="btn btn-setting-custom btn-sm rounded-pill px-3 fw-bold">Setting</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>
</div>
