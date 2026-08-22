<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.app.dao.impl.BookOrderDAOImpl" %>
<%@ page import="com.app.entity.Book_Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="com.app.db.DBconnect" %>
<%@ page import="java.text.DecimalFormat" %>

<%-- Security Check --%>
<c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
    <c:redirect url="../login.jsp" />
</c:if>

<%
    String email = request.getParameter("email");
    if (email == null || email.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/admin/orders.jsp");
        return;
    }
    email = email.trim();

    java.sql.Connection conn = DBconnect.getConn();
    if (conn == null) {
        response.sendRedirect(request.getContextPath() + "/error.jsp");
        return;
    }

    BookOrderDAOImpl dao = new BookOrderDAOImpl(conn);
    List<Book_Order> list = dao.getBookOrder(email);
    Map<String, List<Book_Order>> grouped = new LinkedHashMap<>();

    double customerTotalRevenue = 0.0;
    int activeOrderCount = 0;
    Book_Order customerProfile = null;

    if (list != null) {
        for (Book_Order b : list) {
            grouped.computeIfAbsent(b.getOrderNo(), k -> new ArrayList<>()).add(b);
            if (customerProfile == null) {
                customerProfile = b;
            }
        }
        for (Map.Entry<String, List<Book_Order>> entry : grouped.entrySet()) {
            List<Book_Order> items = entry.getValue();
            Book_Order first = items.get(0);
            if (!"Cancelled".equalsIgnoreCase(first.getStatus())) {
                activeOrderCount++;
                for (Book_Order bo : items) {
                    try {
                        customerTotalRevenue += Double.parseDouble(bo.getPrice());
                    } catch (Exception ignored) {}
                }
            }
        }
    }

    DecimalFormat fmt = new DecimalFormat("#,##0.00");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Orders — <%= email %></title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
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
            padding: 8px 10px;
            border-bottom: 1px solid #f5f5f5;
            vertical-align: middle;
        }
        .status-pill {
            font-size: 11px;
            font-weight: 600;
            padding: 3px 8px;
            border-radius: 3px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .status-pill.pending { background-color: #fff3cd; color: #856404; }
        .status-pill.cancelled { background-color: #f8d7da; color: #721c24; }
        .status-pill.completed { background-color: #d4edda; color: #155724; }

        .stat-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            padding: 10px 14px;
            border-radius: 4px;
        }
        .stat-box .val {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1e293b;
        }
        .stat-box .lbl {
            font-size: 0.75rem;
            color: #64748b;
            text-transform: uppercase;
        }
    </style>
</head>
<body>

<%@include file="navbar.jsp" %>

<main class="admin-main">
    <div class="breadcrumb-bar bg-white px-4 py-2 border-bottom mb-3 text-muted" style="font-size: 11px;">
        <a href="${pageContext.request.contextPath}/admin/home.jsp" class="text-decoration-none text-muted">Admin Console</a> &gt; 
        <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="text-decoration-none text-muted">Customer Orders</a> &gt; 
        <span><%= email %></span>
    </div>

    <div class="content-body">
        <%-- Flash Messages --%>
        <c:if test="${not empty succMsg}">
            <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                <i class="fas fa-check-circle me-1"></i> ${succMsg}
                <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="succMsg" scope="session"/>
        </c:if>
        <c:if test="${not empty failedMsg}">
            <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                <i class="fas fa-exclamation-triangle me-1"></i> ${failedMsg}
                <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="failedMsg" scope="session"/>
        </c:if>

        <!-- Header -->
        <div class="page-title">
            <div>
                <span class="fw-bold">Orders for Customer:</span> <span class="text-primary"><%= customerProfile != null ? customerProfile.getName() : email %></span>
                <span class="text-muted ms-2 small">(<%= email %>)</span>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="btn btn-sm btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Back to Directory
                </a>
            </div>
        </div>

        <!-- Summary Stats Row -->
        <div class="row g-3 mb-3">
            <div class="col-sm-4">
                <div class="stat-box">
                    <div class="lbl">Total Orders Placed</div>
                    <div class="val"><%= grouped.size() %></div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="stat-box">
                    <div class="lbl">Active / Valid Orders</div>
                    <div class="val text-primary"><%= activeOrderCount %></div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="stat-box">
                    <div class="lbl">Active Revenue (USD)</div>
                    <div class="val text-success">$<%= fmt.format(customerTotalRevenue) %></div>
                </div>
            </div>
        </div>

        <!-- Orders List -->
        <% if (grouped.isEmpty()) { %>
            <div class="cf-card text-center py-5 text-muted">
                <i class="fas fa-box-open fa-3x mb-2 text-secondary opacity-50"></i>
                <p class="fw-bold mb-0">No order records found for this user.</p>
                <small>Orders submitted by this account will appear here.</small>
            </div>
        <% } else { %>
            <% for (Map.Entry<String, List<Book_Order>> entry : grouped.entrySet()) {
                String orderNo = entry.getKey();
                List<Book_Order> items = entry.getValue();
                Book_Order first = items.get(0);
                double orderTotal = 0.0;
                for (Book_Order item : items) {
                    try { orderTotal += Double.parseDouble(item.getPrice()); } catch(Exception ignored) {}
                }
                boolean isCancelled = "Cancelled".equalsIgnoreCase(first.getStatus());
            %>
            <div class="cf-card mb-3">
                <div class="cf-card-header">
                    <div class="d-flex align-items-center gap-2">
                        <span class="fw-bold text-dark">Order #<%= orderNo %></span>
                        <% if (isCancelled) { %>
                            <span class="status-pill cancelled"><i class="fas fa-times-circle"></i> Cancelled</span>
                        <% } else { %>
                            <span class="status-pill pending"><i class="fas fa-clock"></i> <%= first.getStatus() != null ? first.getStatus() : "Pending" %></span>
                        <% } %>
                    </div>
                    <div class="d-flex gap-2">
                        <% if (!isCancelled) { %>
                            <a href="${pageContext.request.contextPath}/admin/cancel_order?orderNo=<%= orderNo %>&email=<%= java.net.URLEncoder.encode(email, "UTF-8") %>"
                               class="btn btn-outline-warning btn-sm py-0 px-2" style="font-size: 11px;"
                               onclick="return confirm('Cancel this order? This will deduct $<%= fmt.format(orderTotal) %> from total revenue.')">
                                <i class="fas fa-ban me-1"></i>Cancel Order
                            </a>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/admin/cancel_order?action=delete&orderNo=<%= orderNo %>&email=<%= java.net.URLEncoder.encode(email, "UTF-8") %>"
                           class="btn btn-outline-danger btn-sm py-0 px-2" style="font-size: 11px;"
                           onclick="return confirm('Permanently delete this order record?')">
                            <i class="fas fa-trash-alt me-1"></i>Delete
                        </a>
                    </div>
                </div>

                <!-- Recipient & Shipping Info -->
                <div class="bg-light p-2 rounded mb-2" style="font-size: 12px; color: #475569;">
                    <div class="row g-1">
                        <div class="col-md-4"><strong>Recipient:</strong> <%= first.getName() %> (<%= first.getPhone() %>)</div>
                        <div class="col-md-4"><strong>Payment:</strong> <%= first.getPaymentType() %></div>
                        <div class="col-md-4"><strong>Address:</strong> <%= first.getAddress() %>, <%= first.getCity() %>, <%= first.getState() %> <%= first.getPincode() %></div>
                    </div>
                </div>

                <!-- Items Table -->
                <table class="table-cf">
                    <thead>
                        <tr>
                            <th style="width: 40px;">#</th>
                            <th>Book Title</th>
                            <th>Author</th>
                            <th class="text-end">Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int idx = 1; for (Book_Order item : items) {
                            double itemPrice = 0.0;
                            try { itemPrice = Double.parseDouble(item.getPrice()); } catch(Exception ignored) {}
                        %>
                        <tr>
                            <td class="text-muted"><%= idx++ %></td>
                            <td class="fw-semibold text-dark"><%= item.getBookName() %></td>
                            <td class="text-muted"><%= item.getAuthor() %></td>
                            <td class="text-end fw-bold text-dark">$<%= fmt.format(itemPrice) %></td>
                        </tr>
                        <% } %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" class="text-end fw-bold text-uppercase" style="font-size: 11px; padding-top: 10px;">Order Total:</td>
                            <td class="text-end fw-bold fs-6 <%= isCancelled ? "text-muted text-decoration-line-through" : "text-success" %>" style="padding-top: 10px;">
                                $<%= fmt.format(orderTotal) %>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <% } %>
        <% } %>

    </div>
</main>

<%@include file="footer.jsp" %>

</body>
</html>
