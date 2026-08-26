<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.app.entity.user" %>
<%@ page import="com.app.dao.impl.CartDAOImpl" %>
<%@ page import="com.app.db.DBconnect" %>

<c:set var="currentUri" value="${not empty requestScope['jakarta.servlet.include.request_uri'] ? requestScope['jakarta.servlet.include.request_uri'] : pageContext.request.requestURI}" />

<style>
    /* Global Reset & High-Contrast Classic Palette */
    :root {
        --c-bg: #f4f6f8;             /* Background áž”áŸ’ážšáž•áŸáŸ‡ážŸáŸ’ážšáž¶áž› */
        --c-surface: #ffffff;        /* Surface ážŸáž…áŸ’áž”áž¶ážŸáŸ‹ */
        --c-border: #cbd5e1;         /* Border áž”áŸ’ážšáž•áŸáŸ‡áž…áŸ’áž”áž¶ážŸáŸ‹ */
        --c-text: #1e293b;           /* áž¢áž€áŸ’ážŸážšážáŸ’áž˜áŸ…áž”áŸ’ážšáž•áŸáŸ‡áž…áž¶ážŸáŸ‹ (High Contrast) */
        --c-muted: #64748b;          /* áž¢áž€áŸ’ážŸážšážšáž„áž…áŸ’áž”áž¶ážŸáŸ‹áž›áŸ’áž˜áž˜ */
        --c-accent: #2d6a4f;         /* Deep Forest Green (áž…áŸ’áž”áž¶ážŸáŸ‹ áž˜áž·áž“ážŸáŸ’áž›áŸáž€) */
        --c-accent-hover: #1b4332;   /* Green ážŠáž·ážáž–áŸáž› Hover */
        --c-input-border: #94a3b8;   /* áž–áŸ’ážšáŸ†áž”áŸ’ážšáž‘áž›áŸ‹ Input áž…áŸ’áž”áž¶ážŸáŸ‹ */
    }

    *, *::before, *::after {
        border-radius: 0 !important; /* áž”áž»ážšáž¶ážŽáž‡áŸ’ážšáž»áž„áŸ— 100% */
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

    .search-box { display: flex; flex: 1; max-width: 320px; min-width: 0; }
    .search-input {
        background: #ffffff;
        border: 1px solid var(--c-input-border);
        padding: 6px 12px;
        font-size: 0.85rem;
        width: 100%;
        min-width: 0;
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
        flex-shrink: 0;
    }
    .search-btn:hover {
        background: var(--c-accent);
    }

    .nav-actions { display: flex; gap: 8px; flex-wrap: wrap; align-items: center; }
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
        white-space: nowrap;
    }
    .btn-classic:hover { 
        background: var(--c-accent); 
        color: #ffffff; 
        border-color: var(--c-accent);
    }

    /* Mobile hamburger toggle */
    .nav-toggle {
        display: none;
        background: none;
        border: 1px solid var(--c-input-border);
        color: var(--c-text);
        padding: 6px 10px;
        cursor: pointer;
        font-size: 1rem;
    }
    .mobile-collapse {
        display: flex;
        align-items: center;
        gap: 12px;
        flex: 1;
        justify-content: flex-end;
    }

    .menu-bar {
        display: flex;
        justify-content: space-between;
        padding: 0 1rem;
        background: var(--c-surface);
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
        scrollbar-width: none;
    }
    .menu-bar::-webkit-scrollbar { display: none; }
    .menu-bar a {
        padding: 10px 14px;
        color: var(--c-muted);
        text-decoration: none;
        font-size: 0.85rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 3px solid transparent;
        transition: all 0.2s ease;
        white-space: nowrap;
    }
    .menu-bar a:hover {
        color: var(--c-text);
        border-bottom-color: var(--c-input-border);
    }
    .menu-bar a.active {
        color: var(--c-accent);
        border-bottom-color: var(--c-accent);
    }

    @media (max-width: 767px) {
        .top-bar { padding: 0 1rem; gap: 8px; flex-wrap: nowrap; }
        .nav-toggle { display: inline-flex; align-items: center; }
        .mobile-collapse { display: none; flex-direction: column; align-items: flex-start; gap: 8px; }
        .mobile-collapse.show { display: flex; }
        .search-box { max-width: 100%; width: 100%; }
        .nav-actions { width: 100%; }
        .btn-classic { font-size: 0.8rem; padding: 5px 10px; }
        .brand-logo { font-size: 1.05rem; }
    }
    @media (min-width: 768px) {
        .top-bar { gap: 16px; }
    }
</style>

<div class="header-nav">
    <div class="top-bar">
        <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo">
            <i class="fas fa-book-open me-2" style="color: var(--c-accent);"></i>eBook
        </a>

        <%-- Mobile toggle button --%>
        <button class="nav-toggle" id="navToggle" onclick="document.getElementById('mobileCollapse').classList.toggle('show')" aria-label="Toggle navigation">
            <i class="fas fa-bars"></i>
        </button>

        <div class="mobile-collapse" id="mobileCollapse">
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
                            int cartCount = 0;
                            if (navUser != null) {
                                java.sql.Connection navbarConn = DBconnect.getConn();
                                if (navbarConn != null) {
                                    cartCount = new CartDAOImpl(navbarConn).countCart(navUser.getId());
                                }
                            }
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
    </div>

    <div class="menu-bar">
        <div class="d-flex">
            <c:choose>
                <c:when test="${(not empty userobj and userobj.email == 'admin@gmail.com') or currentUri.contains('/admin/')}">
                    <a class="${currentUri.endsWith('/admin/home.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/home.jsp">Overview</a>
                    <a class="${currentUri.endsWith('/admin/add_books.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/add_books.jsp">Add Books</a>
                    <a class="${currentUri.endsWith('/admin/all_books.jsp') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/all_books.jsp">Inventory</a>
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