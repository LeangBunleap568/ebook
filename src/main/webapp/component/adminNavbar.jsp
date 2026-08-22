<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentUri" value="${not empty requestScope['jakarta.servlet.include.request_uri'] ? requestScope['jakarta.servlet.include.request_uri'] : pageContext.request.requestURI}" />

<style>
    /* Modern Admin Layout Styling */
    :root {
        --sidebar-width: 210px;
        --sidebar-bg: #ffffff;
        --sidebar-active-bg: #e6f4ea; 
        --sidebar-active-text: #0f5132;
        --sidebar-hover-bg: #f8fafc;
        --border-color: #e2e8f0;
        --topbar-bg: #ffffff;
        --text-main: #334155;
        --text-muted: #64748b;
        --body-bg: #f4f7f6;
    }

    body {
        background-color: var(--body-bg) !important;
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif !important;
        color: var(--text-main) !important;
        margin: 0;
        font-size: 13px !important;
    }

    /* Layout Structure */
    .app-wrapper {
        display: flex;
        min-height: 100vh;
    }

    /* Modern Sidebar */
    .sidebar {
        width: var(--sidebar-width);
        background-color: var(--sidebar-bg);
        border-right: 1px solid var(--border-color);
        flex-shrink: 0;
        display: flex;
        flex-direction: column;
        box-shadow: 2px 0 8px rgba(0,0,0,0.02);
        z-index: 10;
    }
    .sidebar .brand-header {
        height: 56px;
        display: flex;
        align-items: center;
        padding: 0 20px;
        font-size: 15px;
        font-weight: 700;
        color: #0f5132;
        border-bottom: 1px solid var(--border-color);
        letter-spacing: 0.5px;
    }
    .sidebar .nav-section {
        padding: 16px 12px;
    }
    .sidebar .nav-item-title {
        padding: 0 12px 8px;
        font-size: 11px;
        font-weight: 600;
        color: #94a3b8;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    .sidebar .nav-link-custom {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 8px 12px;
        color: var(--text-muted);
        text-decoration: none;
        border-radius: 6px;
        margin-bottom: 4px;
        font-weight: 500;
        transition: all 0.2s ease;
    }
    .sidebar .nav-link-custom i {
        font-size: 14px;
        width: 16px;
        text-align: center;
    }
    .sidebar .nav-link-custom:hover {
        background-color: var(--sidebar-hover-bg);
        color: #0f5132;
    }
    .sidebar .nav-link-custom.active {
        background-color: var(--sidebar-active-bg);
        color: var(--sidebar-active-text);
        font-weight: 600;
    }

    /* Main Container */
    .main-container {
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        overflow-x: hidden;
    }

    /* Modern Top Navbar */
    .top-navbar {
        height: 56px;
        background-color: var(--topbar-bg);
        border-bottom: 1px solid var(--border-color);
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 24px;
        box-shadow: 0 1px 4px rgba(0,0,0,0.02);
        z-index: 5;
    }
    
    .top-navbar .menu-toggle {
        color: var(--text-muted);
        font-size: 16px;
        cursor: pointer;
        transition: color 0.2s;
    }
    .top-navbar .menu-toggle:hover {
        color: #0f5132;
    }
    
    .top-navbar .admin-profile {
        display: flex;
        align-items: center;
        gap: 8px;
        color: var(--text-main);
        font-weight: 500;
        text-decoration: none;
        padding: 6px 12px;
        border-radius: 20px;
        border: 1px solid var(--border-color);
        transition: all 0.2s ease;
    }
    .top-navbar .admin-profile:hover {
        background-color: var(--sidebar-hover-bg);
        border-color: #cbd5e1;
        color: #0f5132;
    }
    .top-navbar .admin-profile i {
        font-size: 14px;
    }
</style>

<div class="app-wrapper">

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="brand-header">
            <i class="fas fa-book-open me-2 text-success"></i> Ebook Admin
        </div>
        <div class="nav-section">
            <div class="nav-item-title">System Overview</div>
            <a href="${pageContext.request.contextPath}/admin/home.jsp" class="nav-link-custom ${currentUri.endsWith('home.jsp') ? 'active' : ''}">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="nav-link-custom ${currentUri.endsWith('allBook.jsp') || currentUri.endsWith('edit_books.jsp') || currentUri.endsWith('edit_cover.jsp') ? 'active' : ''}">
                <i class="fas fa-book"></i> Book Catalog
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="nav-link-custom ${currentUri.endsWith('orders.jsp') || currentUri.endsWith('order_details.jsp') ? 'active' : ''}">
                <i class="fas fa-shopping-cart"></i> Order Requests
            </a>
            <a href="${pageContext.request.contextPath}/admin/users.jsp" class="nav-link-custom ${currentUri.endsWith('users.jsp') ? 'active' : ''}">
                <i class="fas fa-users"></i> User Management
            </a>
            <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="nav-link-custom ${currentUri.endsWith('add_books.jsp') ? 'active' : ''}">
                <i class="fas fa-plus-circle"></i> Add Book
            </a>
        </div>
    </div>

    <!-- Main Workspace -->
    <div class="main-container">

        <!-- Top Bar -->
        <div class="top-navbar">
            <div>
                <i class="fas fa-bars menu-toggle"></i>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/logout" class="admin-profile" title="Logout">
                    <i class="fas fa-user-circle text-success"></i> Admin Exit
                </a>
            </div>
        </div>
