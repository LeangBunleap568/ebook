<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.ebook.dao.impl.BookOrderDAOImpl" %>
<%@ page import="com.ebook.entity.Book_Order" %>
<%@ page import="java.util.*" %>
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
<title>Ebook App — Order Details</title>
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

    /* Sidebar */
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

    /* CF Dashboard Card */
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

    /* CF Tables */
    .table-cf {
        width: 100%;
        border-collapse: collapse;
    }
    .table-cf th {
        text-align: left;
        font-size: 11px;
        color: #7f8c8d;
        padding: 8px 6px;
        border-bottom: 1px solid #eee;
        font-weight: 600;
    }
    .table-cf td {
        padding: 8px 6px;
        border-bottom: 1px solid #f5f5f5;
        vertical-align: middle;
    }

    /* Custom Badges */
    .badge-order-id {
        font-family: monospace;
        background-color: #e8f5e9;
        color: #2e7d32;
        border: 1px solid #a5d6a7;
        padding: 2px 6px;
        border-radius: 3px;
        font-size: 11px;
    }
    .badge-status-completed {
        background-color: #5cb85c;
        color: white;
        padding: 2px 6px;
        border-radius: 3px;
        font-size: 10px;
        font-weight: 600;
    }
    .badge-payment {
        background: #f8f9fa;
        color: #495057;
        border: 1px solid #ced4da;
        padding: 2px 6px;
        border-radius: 3px;
        font-size: 10px;
    }
</style>
</head>
<body>

<%
    String email = request.getParameter("email");
    BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
    List<Book_Order> list = dao.getBookOrder(email);

    // Group by orderNo
    Map<String, List<Book_Order>> grouped = new LinkedHashMap<>();
    if (list != null) {
        for (Book_Order bo : list) {
            grouped.computeIfAbsent(bo.getOrderNo(), k -> new ArrayList<>()).add(bo);
        }
    }
    java.text.DecimalFormat fmt = new java.text.DecimalFormat("#,###");
    Book_Order firstEver = (list != null && !list.isEmpty()) ? list.get(0) : null;
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

    <%-- Main Container --%>
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
            Home &gt; Admin Console &gt; Orders &gt; Customer Details
        </div>

        <%-- Content Body --%>
        <div class="content-body">
            
            <div class="page-title">
                <div class="d-flex align-items-center gap-2">
                    <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="btn btn-outline-secondary btn-sm py-1 px-2" style="font-size: 11px;">
                        &larr; Back
                    </a>
                    <span>Orders for: <%= firstEver != null ? firstEver.getName() : (email != null ? email : "Customer") %></span>
                </div>
                <% if (list != null && !list.isEmpty()) { %>
                    <span class="badge bg-secondary" style="font-size: 10px; font-weight: normal;">
                        Total <%= grouped.size() %> Order(s)
                    </span>
                <% } %>
            </div>

            <% if (list == null || list.isEmpty()) { %>
                <%-- Empty State --%>
                <div class="cf-card text-center py-5">
                    <i class="fas fa-inbox fa-3x text-muted mb-3 opacity-50"></i>
                    <h6 class="fw-bold text-secondary">No orders found for this customer</h6>
                    <p class="text-muted small mb-3">This account hasn't placed any orders yet or the email address is invalid.</p>
                    <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="btn btn-primary btn-sm px-3" style="font-size: 11px;">
                        Back to All Orders
                    </a>
                </div>
            <% } else { %>

                <%-- Customer Info Panel --%>
                <div class="cf-card">
                    <div class="cf-card-header">
                        <div class="cf-card-title">
                            <i class="fas fa-id-card text-secondary"></i> Customer Info
                        </div>
                    </div>
                    <div class="row g-2 text-secondary" style="font-size: 12px;">
                        <div class="col-md-4">
                            <strong>Name:</strong> <span class="text-dark"><%= firstEver.getName() %></span>
                        </div>
                        <div class="col-md-4">
                            <strong>Email:</strong> <span class="text-dark"><%= firstEver.getEmail() %></span>
                        </div>
                        <div class="col-md-4">
                            <strong>Phone:</strong> <span class="text-dark"><%= firstEver.getPhone() %></span>
                        </div>
                        <div class="col-12 mt-1">
                            <strong>Address:</strong>
                            <span class="text-dark">
                                <%= firstEver.getAddress() %>, <%= firstEver.getLandmark() %>, <%= firstEver.getCity() %>, <%= firstEver.getState() %> <%= firstEver.getPincode() %>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="text-muted mb-2" style="font-size: 11px;">
                    Showing <%= grouped.size() %> order(s) containing <%= list.size() %> total item(s)
                </div>

                <%-- Order Cards Loop --%>
                <% for (Map.Entry<String, List<Book_Order>> entry : grouped.entrySet()) {
                    String orderNo = entry.getKey();
                    List<Book_Order> items = entry.getValue();
                    Book_Order first = items.get(0);
                    double orderTotal = 0;
                    for (Book_Order item : items) {
                        try { orderTotal += Double.parseDouble(item.getPrice()); } catch(Exception ex) {}
                    }
                %>
                <div class="cf-card">
                    <div class="cf-card-header">
                        <div class="d-flex align-items-center gap-2">
                            <span class="badge-order-id">#<%= orderNo %></span>
                            <span class="badge-status-completed">Completed</span>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <span class="text-muted" style="font-size: 11px;"><%= items.size() %> book(s)</span>
                            <span class="text-muted">|</span>
                            <span class="fw-bold text-danger"><%= fmt.format(orderTotal) %> ៛</span>
                            <span class="badge-payment"><%= first.getPaymentType() %></span>
                        </div>
                    </div>

                    <table class="table-cf">
                        <thead>
                            <tr>
                                <th style="width: 30px;">#</th>
                                <th>Book Name</th>
                                <th>Author</th>
                                <th style="text-align: right; padding-right: 12px;">Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% int i = 1; for (Book_Order item : items) {
                                double p = 0;
                                try { p = Double.parseDouble(item.getPrice()); } catch(Exception ex) {}
                            %>
                            <tr>
                                <td class="text-muted"><%= i++ %></td>
                                <td class="fw-bold" style="color: #2c3e50;"><%= item.getBookName() %></td>
                                <td class="text-muted" style="font-size: 11px;"><%= item.getAuthor() %></td>
                                <td style="text-align: right; padding-right: 12px;" class="text-danger fw-bold">
                                    <%= fmt.format(p) %> ៛
                                </td>
                            </tr>
                            <% } %>
                            <tr style="background-color: #fafafa;">
                                <td colspan="3" style="text-align: right; font-weight: 600; color: #555;">Order Total:</td>
                                <td style="text-align: right; padding-right: 12px;" class="text-success fw-bold">
                                    <%= fmt.format(orderTotal) %> ៛
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <% } %>

            <% } %>
        </div>
    </div>
</div>

</body>
</html>