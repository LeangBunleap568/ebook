<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.ebook.entity.user" %>
<%@ page import="com.ebook.dao.impl.CartDAOImpl" %>
<%@ page import="com.ebook.db.DBconnect" %>

<c:set var="currentUri" value="${not empty requestScope['jakarta.servlet.include.request_uri'] ? requestScope['jakarta.servlet.include.request_uri'] : pageContext.request.requestURI}" />

<style>
    /* Global Reset & High-Contrast Classic Palette */
    :root {
        --c-bg: #f4f6f8;             /* Background ប្រផេះស្រាល */
        --c-surface: #ffffff;        /* Surface សច្បាស់ */
        --c-border: #cbd5e1;         /* Border ប្រផេះច្បាស់ */
        --c-text: #1e293b;           /* អក្សរខ្មៅប្រផេះចាស់ (High Contrast) */
        --c-muted: #64748b;          /* អក្សររងច្បាស់ល្មម */
        --c-accent: #2d6a4f;         /* Deep Forest Green (ច្បាស់ មិនស្លេក) */
        --c-accent-hover: #1b4332;   /* Green ដិតពេល Hover */
        --c-input-border: #94a3b8;   /* ព្រំប្រទល់ Input ច្បាស់ */
    }

    *, *::before, *::after {
        border-radius: 0 !important; /* បុរាណជ្រុងៗ 100% */
    }

    body { background-color: var(--c-bg) !important; color: var(--c-text); }

    .header-nav {
        background: var(--c-surface);
        border-bottom: 2px solid var(--c-border);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .top-bar {
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 2rem;
        border-bottom: 1px solid var(--c-border);
    }

    .brand-logo {
        font-weight: 800;
        font-size: 1.25rem;
        letter-spacing: 1px;
        color: var(--c-text);
        text-decoration: none;
        text-transform: uppercase;
    }

    .search-box { display: flex; width: 280px; }
    .search-input {
        background: #ffffff;
        border: 1px solid var(--c-input-border);
        padding: 6px 12px;
        font-size: 0.85rem;
        width: 100%;
        color: var(--c-text);
        font-weight: 500;
    }
    .search-input:focus {
        outline: none;
        border-color: var(--c-accent);
    }
    .search-btn {
        background: var(--c-text);
        color: #fff;
        border: none;
        padding: 0 14px;
        cursor: pointer;
        transition: background-color 0.2s ease;
    }
    .search-btn:hover {
        background: var(--c-accent);
    }

    .nav-actions { display: flex; gap: 8px; }
    .btn-classic {
        background: #ffffff;
        border: 1px solid var(--c-input-border);
        color: var(--c-text);
        padding: 6px 14px;
        font-size: 0.85rem;
        font-weight: 700;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.2s ease;
    }
    .btn-classic:hover { 
        background: var(--c-accent); 
        color: #ffffff; 
        border-color: var(--c-accent);
    }

    .menu-bar {
        display: flex;
        justify-content: space-between;
        padding: 0 2rem;
        background: var(--c-surface);
    }
    .menu-bar a {
        padding: 12px 16px;
        color: var(--c-muted);
        text-decoration: none;
        font-size: 0.85rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 3px solid transparent;
        transition: all 0.2s ease;
    }
    .menu-bar a:hover {
        color: var(--c-text);
        border-bottom-color: var(--c-input-border);
    }
    .menu-bar a.active {
        color: var(--c-accent);
        border-bottom-color: var(--c-accent);
    }
</style>

<div class="header-nav">
    <div class="top-bar">
        <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo">
            <i class="fas fa-book-open me-2" style="color: var(--c-accent);"></i>eBook
        </a>

        <c:if test="${not ((not empty userobj and userobj.email == 'admin@gmail.com') or currentUri.contains('/admin/'))}">
            <form class="search-box" action="${pageContext.request.contextPath}/user/search.jsp" method="GET">
                <input class="search-input" type="search" name="ch" placeholder="Search book..." required>
                <button class="search-btn" type="submit"><i class="fas fa-search"></i></button>
            </form>
        </c:if>

        <div class="nav-actions">
            <c:choose>
                <c:when test="${(not empty userobj and userobj.email == 'admin@gmail.com') or currentUri.contains('/admin/')}">
                    <span class="btn-classic"><i class="fas fa-user-shield me-1"></i>Admin</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-classic"><i class="fas fa-sign-out-alt"></i>Logout</a>
                </c:when>
                <c:when test="${not empty userobj}">
                    <a href="${pageContext.request.contextPath}/user/setting.jsp" class="btn-classic"><i class="fas fa-user"></i>${userobj.name}</a>
                    <%
                        user navUser = (user) session.getAttribute("userobj");
                        int cartCount = (navUser != null) ? new CartDAOImpl(DBconnect.getConn()).countCart(navUser.getId()) : 0;
                    %>
                    <a href="${pageContext.request.contextPath}/user/cart.jsp" class="btn-classic">
                        <i class="fas fa-shopping-cart"></i>Cart (<%= cartCount %>)
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-classic"><i class="fas fa-sign-out-alt"></i></a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn-classic"><i class="fas fa-sign-in-alt"></i>Sign In</a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn-classic"><i class="fas fa-user-plus"></i>Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="menu-bar">
        <div class="d-flex">
            <c:choose>
                <c:when test="${(not empty userobj and userobj.email == 'admin@gmail.com') or currentUri.contains('/admin/')}">
                    <a class="${currentUri.endsWith('/admin/home.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/home.jsp">Overview</a>
                    <a class="${currentUri.endsWith('/admin/add_books.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/add_books.jsp">Add Books</a>
                    <a class="${currentUri.endsWith('/admin/allBook.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/allBook.jsp">Inventory</a>
                    <a class="${currentUri.endsWith('/admin/orders.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/orders.jsp">Orders</a>
                </c:when>
                <c:otherwise>
                    <a class="${currentUri.endsWith('/index.jsp') or currentUri.endsWith('/') ? 'active' : ''}" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <a class="${currentUri.endsWith('/user/all_recent_book.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/all_recent_book.jsp">Recent</a>
                    <a class="${currentUri.endsWith('/user/all_new_book.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/all_new_book.jsp">New Books</a>
                    <a class="${currentUri.endsWith('/user/all_old_book.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/all_old_book.jsp">Old Books</a>
                </c:otherwise>
            </c:choose>
        </div>
        <c:if test="${not ((not empty userobj and userobj.email == 'admin@gmail.com') or currentUri.contains('/admin/'))}">
            <div class="d-flex">
                <a class="${currentUri.endsWith('/user/contact.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/contact.jsp">Contact</a>
                <a class="${currentUri.endsWith('/user/setting.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/user/setting.jsp">Settings</a>
            </div>
        </c:if>
    </div>
</div>