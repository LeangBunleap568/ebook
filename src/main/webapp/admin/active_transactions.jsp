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
    java.sql.Connection conn = DBconnect.getConn();
    if (conn == null) {
        response.sendRedirect(request.getContextPath() + "/error.jsp");
        return;
    }
    BookOrderDAOImpl dao = new BookOrderDAOImpl(conn);
    List<Book_Order> list = dao.getAllOrder();
    Map<String, List<Book_Order>> activeOrders = new LinkedHashMap<>();

    double activeTotalRevenue = 0.0;

    if (list != null) {
        for (Book_Order b : list) {
            if (!"Cancelled".equalsIgnoreCase(b.getStatus())) {
                activeOrders.computeIfAbsent(b.getOrderNo(), k -> new ArrayList<>()).add(b);
            }
        }
        for (Map.Entry<String, List<Book_Order>> entry : activeOrders.entrySet()) {
            for (Book_Order bo : entry.getValue()) {
                try {
                    activeTotalRevenue += Double.parseDouble(bo.getPrice());
                } catch (Exception ignored) {}
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
    <title>Admin Dashboard — Active Transactions</title>
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
            padding: 10px;
            border-bottom: 1px solid #f5f5f5;
            vertical-align: middle;
        }
        .table-cf tbody tr:hover {
            background-color: #fafafa;
        }

        .status-pill {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .search-input {
            font-size: 12px;
            border-radius: 3px;
            border: 1px solid #ccc;
            padding: 4px 8px;
            width: 250px;
        }
    </style>
</head>
<body>

<%@include file="navbar.jsp" %>

<main class="admin-main">
    <%-- Breadcrumbs --%>
    <div class="breadcrumb-bar bg-white px-4 py-2 border-bottom mb-3 text-muted" style="font-size: 11px;">
        <a href="${pageContext.request.contextPath}/admin/home.jsp" class="text-decoration-none text-muted">Admin Console</a> &gt; 
        <span>Active Transactions</span>
    </div>

    <%-- Content Body --%>
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

        <div class="row g-2 mb-3">
            <div class="col-md-6">
                <div class="p-3 bg-white border rounded">
                    <div class="text-muted small text-uppercase fw-bold">Active Transaction Count</div>
                    <div class="fs-5 fw-bold text-primary"><%= activeOrders.size() %> Active Orders</div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="p-3 bg-white border rounded">
                    <div class="text-muted small text-uppercase fw-bold">Active Order Revenue</div>
                    <div class="fs-5 fw-bold text-success">$<%= fmt.format(activeTotalRevenue) %></div>
                </div>
            </div>
        </div>

        <div class="page-title">
            <span>Active Transactions Management</span>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="btn btn-sm btn-outline-secondary">
                    <i class="fas fa-list me-1"></i> View All Orders Directory
                </a>
            </div>
        </div>

        <div class="cf-card">
            <div class="cf-card-header">
                <div class="cf-card-title">
                    <i class="fas fa-bolt text-warning"></i> Open / Processing Orders (<%= activeOrders.size() %>)
                </div>
                <div>
                    <input type="text" id="searchInput" class="search-input"
                           placeholder="Filter order #, name, or email..." onkeyup="filterTable()">
                </div>
            </div>

            <div class="table-responsive">
                <table class="table-cf" id="txTable">
                    <thead>
                        <tr>
                            <th>Order No</th>
                            <th>Customer Info</th>
                            <th>Items in Order</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th style="text-align: right; padding-right: 15px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        for (Map.Entry<String, List<Book_Order>> entry : activeOrders.entrySet()) {
                            String orderNo = entry.getKey();
                            List<Book_Order> items = entry.getValue();
                            Book_Order first = items.get(0);
                            double orderTotal = 0.0;
                            for (Book_Order b : items) {
                                try { orderTotal += Double.parseDouble(b.getPrice()); } catch (Exception ignored) {}
                            }
                        %>
                        <tr>
                            <td>
                                <span class="fw-bold font-monospace text-primary">#<%= orderNo %></span>
                            </td>
                            <td>
                                <div class="fw-bold" style="color: #2c3e50;"><%= first.getName() %></div>
                                <div class="text-muted small"><%= first.getEmail() %> &bull; <%= first.getPhone() %></div>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border">
                                    <i class="fas fa-book me-1 text-secondary"></i><%= items.size() %> Item(s)
                                </span>
                                <div class="text-muted" style="font-size: 11px; max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                    <%= first.getBookName() %><% if (items.size() > 1) { %>, +<%= items.size() - 1 %> more<% } %>
                                </div>
                            </td>
                            <td>
                                <span class="fw-bold text-success">$<%= fmt.format(orderTotal) %></span>
                                <div class="text-muted" style="font-size: 10px;"><%= first.getPaymentType() %></div>
                            </td>
                            <td>
                                <span class="status-pill">
                                    <i class="fas fa-clock"></i> <%= first.getStatus() != null ? first.getStatus() : "Pending" %>
                                </span>
                            </td>
                            <td style="text-align: right; padding-right: 15px;">
                                <a href="${pageContext.request.contextPath}/admin/order_details.jsp?email=<%= java.net.URLEncoder.encode(first.getEmail(), "UTF-8") %>"
                                   class="btn btn-outline-primary btn-sm py-0 px-2 me-1" style="font-size: 11px;">
                                    <i class="fas fa-eye me-1"></i>Details
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/cancel_order?orderNo=<%= orderNo %>&returnUrl=/admin/active_transactions.jsp"
                                   class="btn btn-outline-danger btn-sm py-0 px-2" style="font-size: 11px;"
                                   onclick="return confirm('Cancel active transaction #<%= orderNo %>? Revenue will decrease by $<%= fmt.format(orderTotal) %>.')">
                                    <i class="fas fa-ban me-1"></i>Cancel
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <% if (activeOrders.isEmpty()) { %>
                <div class="text-center py-5 text-muted">
                    <i class="fas fa-check-double fa-3x mb-2 text-success opacity-50"></i>
                    <p class="fw-bold mb-0">No active transactions pending.</p>
                    <small>All transactions are completed or no active orders exist.</small>
                </div>
            <% } %>
        </div>

    </div>
</main>

<%@include file="footer.jsp" %>

<script>
    function filterTable() {
        const query = document.getElementById('searchInput').value.toLowerCase();
        document.querySelectorAll('#txTable tbody tr').forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(query) ? '' : 'none';
        });
    }
</script>

</body>
</html>
