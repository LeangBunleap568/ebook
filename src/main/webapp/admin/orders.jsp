<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.ebook.dao.impl.BookOrderDAOImpl" %>
<%@ page import="com.ebook.entity.Book_Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="com.ebook.db.DBconnect" %>

<%-- Security Check --%>
<c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
    <c:redirect url="../login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ebook App — Customer Orders</title>
<%@include file="../component/rootCss.jsp" %>
<style>
    :root {
        --sidebar-bg: #2c3846;
        --sidebar-active: #232d38;
        --brand-bg: #f39c12;
        --topbar-bg: #34495e;
        --body-bg: #eaedf1;
    }

    body {
        background-color: var(--body-bg);
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
        margin: 0;
        padding: 0;
        font-size: 13px;
        color: #333;
    }

    /* Layout Structure */
    .app-wrapper {
        display: flex;
        min-height: 100vh;
    }

    /* Sidebar Navigation */
    .sidebar {
        width: 220px;
        background-color: var(--sidebar-bg);
        color: #95a5a6;
        flex-shrink: 0;
    }
    .sidebar .brand-header {
        background-color: var(--brand-bg);
        color: #fff;
        padding: 14px 20px;
        font-size: 16px;
        font-weight: 600;
    }
    .sidebar .nav-section {
        padding: 10px 0;
    }
    .sidebar .nav-item-title {
        padding: 8px 20px;
        color: #bdc3c7;
        font-weight: 500;
    }
    .sidebar .nav-link-custom {
        display: block;
        padding: 8px 20px 8px 30px;
        color: #95a5a6;
        text-decoration: none;
        transition: all 0.2s;
    }
    .sidebar .nav-link-custom:hover {
        color: #fff;
        background: rgba(255,255,255,0.05);
    }
    .sidebar .nav-link-custom.active {
        color: #fff;
        background-color: var(--sidebar-active);
    }

    /* Main Container */
    .main-container {
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    /* Top Navbar */
    .top-navbar {
        height: 48px;
        background-color: var(--topbar-bg);
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 20px;
        color: #fff;
    }

    /* Breadcrumbs */
    .breadcrumb-bar {
        padding: 10px 20px;
        font-size: 11px;
        color: #7f8c8d;
    }

    /* Content Body */
    .content-body {
        padding: 0 20px 20px 20px;
    }

    .page-title {
        font-size: 18px;
        font-weight: 500;
        margin-bottom: 15px;
        color: #2c3e50;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    /* CF Card Component */
    .cf-card {
        background: #fff;
        border-radius: 4px;
        border: 1px solid #dcdcdc;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        padding: 15px;
        margin-bottom: 15px;
    }
    .cf-card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 12px;
        border-bottom: 1px solid #eee;
        padding-bottom: 8px;
    }
    .cf-card-title {
        font-size: 13px;
        font-weight: 600;
        color: #333;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    /* CF Custom Tables */
    .table-cf {
        width: 100%;
        border-collapse: collapse;
    }
    .table-cf th {
        text-align: left;
        font-size: 11px;
        color: #7f8c8d;
        padding: 8px 10px;
        border-bottom: 1px solid #eee;
        font-weight: 600;
    }
    .table-cf td {
        padding: 10px;
        border-bottom: 1px solid #f5f5f5;
        vertical-align: middle;
    }
    .table-cf tbody tr:hover {
        background-color: #fafafa;
    }

    /* Avatar & Badges */
    .avatar-circle {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        background: #e9ecef;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #495057;
        font-weight: 600;
        font-size: 12px;
    }
    .badge-count {
        background-color: #e8f4fd;
        color: #2980b9;
        border: 1px solid #bee3f8;
        padding: 2px 8px;
        border-radius: 3px;
        font-size: 11px;
        font-weight: 500;
    }
    .search-input {
        font-size: 12px;
        border-radius: 3px;
        border: 1px solid #ccc;
        padding: 4px 8px;
        width: 220px;
    }
</style>
</head>
<body>

<%
    BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
    List<Book_Order> list = dao.getAllOrder();
    Map<String, List<Book_Order>> grouped = new LinkedHashMap<>();

    if (list != null) {
        for (Book_Order b : list) {
            grouped.computeIfAbsent(b.getEmail(), k -> new ArrayList<>()).add(b);
        }
    }
%>

<div class="app-wrapper">

    <%-- Sidebar Navigation --%>
    <div class="sidebar">
        <div class="brand-header">
            Ebook Admin
        </div>
        <div class="nav-section">
            <div class="nav-item-title">System Overview</div>
            <a href="${pageContext.request.contextPath}/admin/home.jsp" class="nav-link-custom">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="nav-link-custom">Book Catalog</a>
            <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="nav-link-custom active">Order Requests</a>
            <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="nav-link-custom">Management</a>
        </div>
    </div>

    <%-- Main Content Area --%>
    <div class="main-container">

        <%-- Top Bar --%>
        <div class="top-navbar">
            <div><i class="fas fa-bars cursor-pointer"></i></div>
            <div>
                <a href="${pageContext.request.contextPath}/logout" class="text-white text-decoration-none" title="Logout">
                    <i class="fas fa-user me-1"></i> Admin Exit
                </a>
            </div>
        </div>

        <%-- Breadcrumbs --%>
        <div class="breadcrumb-bar">
            Home &gt; Admin Console &gt; Customer Orders Overview
        </div>

        <%-- Content Body --%>
        <div class="content-body">

            <div class="page-title">
                <span>Customer Order Directory</span>
                <span class="badge bg-secondary" style="font-size: 10px; font-weight: normal;">
                    Total Customers: <%= grouped.size() %>
                </span>
            </div>

            <div class="cf-card">
                <div class="cf-card-header">
                    <div class="cf-card-title">
                        <i class="fas fa-users text-secondary"></i> Accounts with Order History
                    </div>
                    <div>
                        <input type="text" id="searchInput" class="search-input"
                               placeholder="Search customer name or email..." onkeyup="filterTable()">
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table-cf" id="ordersTable">
                        <thead>
                            <tr>
                                <th>Customer Name</th>
                                <th>Email Address</th>
                                <th>Phone Number</th>
                                <th>Total Items Ordered</th>
                                <th style="text-align: right; padding-right: 15px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            for (Map.Entry<String, List<Book_Order>> entry : grouped.entrySet()) {
                                List<Book_Order> userOrders = entry.getValue();
                                Book_Order firstOrder = userOrders.get(0);
                                String initials = firstOrder.getName() != null && !firstOrder.getName().trim().isEmpty()
                                    ? firstOrder.getName().trim().substring(0, 1).toUpperCase()
                                    : "U";
                            %>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="avatar-circle"><%= initials %></div>
                                        <span class="fw-bold" style="color: #2c3e50;"><%= firstOrder.getName() %></span>
                                    </div>
                                </td>
                                <td class="text-muted"><%= firstOrder.getEmail() %></td>
                                <td class="text-muted"><%= firstOrder.getPhone() %></td>
                                <td>
                                    <span class="badge-count">
                                        <i class="fas fa-box me-1" style="font-size: 10px;"></i><%= userOrders.size() %> Item(s)
                                    </span>
                                </td>
                                <td style="text-align: right; padding-right: 15px;">
                                    <a href="${pageContext.request.contextPath}/admin/order_details.jsp?email=<%= firstOrder.getEmail() %>"
                                       class="btn btn-outline-primary btn-sm py-0 px-2" style="font-size: 11px;">
                                        <i class="fas fa-eye me-1"></i>View Orders
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <% if (grouped.isEmpty()) { %>
                    <div class="text-center py-5 text-muted">
                        <i class="fas fa-box-open fa-3x mb-2 text-secondary opacity-50"></i>
                        <p class="fw-bold mb-0">No customer orders recorded yet.</p>
                        <small>Submitted customer transactions will display in this list.</small>
                    </div>
                <% } %>
            </div>

        </div>
    </div>
</div>

<script>
    function filterTable() {
        const query = document.getElementById('searchInput').value.toLowerCase();
        document.querySelectorAll('#ordersTable tbody tr').forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(query) ? '' : 'none';
        });
    }
</script>

</body>
</html>