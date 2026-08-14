<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.ebook.entity.user" %>
<%@ page import="com.ebook.dao.impl.CartDAOImpl" %>
<%@ page import="com.ebook.db.DBconnect" %>

<!-- Custom Style for Modern Hover Effect -->
<style>
    .navbar-nav .nav-link {
        position: relative;
        transition: color 0.3s ease-in-out;
    }
    
    /* Hover Underline Animation */
    .navbar-nav .nav-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: 4px;
        left: 0;
        background-color: #ffc107;
        transition: width 0.3s ease-in-out;
    }

    .navbar-nav .nav-link:hover::after,
    .navbar-nav .nav-link.active::after {
        width: 100%;
    }

    .navbar-nav .nav-link:hover {
        color: #ffc107 !important;
    }

    /* Button Smooth Hover Effect */
    .navbar .btn {
        transition: all 0.2s ease-in-out;
    }

    .navbar .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    }
</style>

<!-- Top Header Bar -->
<div class="container-fluid px-4 py-3 bg-white border-bottom">
    <div class="row align-items-center">
        <div class="col-md-3 text-primary">
            <h4 class="fw-bold mb-0"><i class="fas fa-book-open text-primary me-2"></i>Ebook Store</h4>
        </div>
        <div class="col-md-5">
            <form class="d-flex" role="search" action="${pageContext.request.contextPath}/search.jsp" method="GET">
                <input class="form-control rounded-0 me-2" type="search" name="ch" placeholder="Search books..." aria-label="Search">
                <button class="btn btn-outline-primary rounded-0 px-3" type="submit">Search</button>
            </form>
        </div>
        <div class="col-md-4 text-end">
            <c:choose>
                <%-- ONLY ADMIN SEES LOGOUT --%>
                <c:when test="${(not empty userobj and userobj.email == 'admin@gmail.com') or pageContext.request.requestURI.contains('/admin/')}">
                    <a href="#" class="btn btn-success btn-sm rounded-0 px-3 me-1">
                        <i class="fas fa-user-shield me-1"></i>Admin
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm rounded-0 px-3">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </c:when>

                <%-- LOGGED IN USER SEES NAME, CART, LOGOUT --%>
                <c:when test="${not empty userobj}">
                    <a href="${pageContext.request.contextPath}/user/setting.jsp" class="btn btn-success btn-sm rounded-0 px-3 me-1">
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
                    <a href="${pageContext.request.contextPath}/user/cart.jsp" class="btn btn-outline-dark btn-sm rounded-0 px-3 me-1">
                        <i class="fas fa-shopping-cart me-1"></i>Cart (<%= cartCount %>)
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm rounded-0 px-3">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </c:when>

                <%-- NOT LOGGED IN USER SEES SIGN IN + REGISTER --%>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-dark btn-sm rounded-0 px-3 me-1">
                        <i class="fas fa-sign-in-alt me-1"></i>Sign In
                    </a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-dark btn-sm rounded-0 px-3">
                        <i class="fas fa-user-plus me-1"></i>Register
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Main Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark rounded-0 shadow-sm" style="background-color: #303f9f !important;">
    <div class="container-fluid px-4">
        <button class="navbar-toggler rounded-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain" aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarMain">
            <c:choose>
                <%-- ONLY ADMIN SEES ADD BOOKS, ALL BOOKS, ORDERS --%>
                <c:when test="${(not empty userobj and userobj.email == 'admin@gmail.com') or pageContext.request.requestURI.contains('/admin/')}">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item me-2">
                            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/admin/home.jsp">
                                <i class="fas fa-home me-1"></i>Home
                            </a>
                        </li>
                        <li class="nav-item me-2">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/addBook.jsp">
                                <i class="fas fa-plus-circle me-1"></i>Add Books
                            </a>
                        </li>
                        <li class="nav-item me-2">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/allBook.jsp">
                                <i class="fas fa-book-open me-1"></i>All Books
                            </a>
                        </li>
                        <li class="nav-item me-2">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/all_order.jsp">
                                <i class="fas fa-box-open me-1"></i>Orders
                            </a>
                        </li>
                    </ul>
                </c:when>

                <%-- NORMAL USER SEES STANDARD STORE MENU ONLY (NO ADD BOOKS, ALL BOOKS, ORDERS, ADMIN, OR LOGOUT) --%>
                <c:otherwise>
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item me-2">
                            <a class="nav-link text-white active" aria-current="page" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                        </li>
                        <li class="nav-item me-2">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/books/all_recent_book.jsp">Recent Book</a>
                        </li>
                        <li class="nav-item me-2">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/books/all_new_book.jsp">New Book</a>
                        </li>
                        <li class="nav-item me-2">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/books/all_old_book.jsp">Old Book</a>
                        </li>
                    </ul>
                    <div class="d-flex align-items-center gap-2">
                        <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn-light btn-sm text-dark rounded-0 px-3">Contact Us</a>
                        <a href="${pageContext.request.contextPath}/user/setting.jsp" class="btn btn-warning btn-sm text-dark rounded-0 px-3">Setting</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>