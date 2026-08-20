<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.dao.impl.BookOrderDAOImpl" %>
<%@ page import="com.ebook.db.DBconnect" %>
<%@ page import="com.ebook.entity.Book_Order" %>
<%@ page import="com.ebook.entity.user" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders — Ebook Store</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        :root { 
            --ui-bg: #f4f6f8; 
            --ui-card: #ffffff; 
            --ui-navy: #1e293b; 
            --ui-text: #334155; 
            --ui-muted: #64748b; 
            --ui-border: #cbd5e1; 
            --ui-red: #ef4444;
            --ui-green: #16a34a;
            --ui-amber: #d97706;
        }
        *, *::before, *::after { 
            border-radius: 0 !important; 
            backdrop-filter: none !important; 
            -webkit-backdrop-filter: none !important; 
        }
        body { 
            background-color: var(--ui-bg) !important; 
            color: var(--ui-text); 
            font-family: system-ui, -apple-system, sans-serif; 
        }
        .ui-card { 
            background: var(--ui-card); 
            border: 2px solid var(--ui-border); 
        }
        .section-header { 
            border-bottom: 2px solid var(--ui-border); 
            padding-bottom: 12px; 
            margin-bottom: 20px; 
        }
        .btn-ui-primary { 
            background: var(--ui-navy); 
            color: #fff !important; 
            font-weight: 700; 
            font-size: 0.85rem; 
            text-transform: uppercase; 
            border: none;
            padding: 8px 16px;
            display: inline-block;
            text-decoration: none;
        }
        .btn-ui-primary:hover { 
            background: #0f172a; 
        }
        .btn-ui-outline { 
            background: #fff; 
            color: var(--ui-navy) !important; 
            border: 1px solid var(--ui-border); 
            font-weight: 700; 
            font-size: 0.85rem; 
            text-transform: uppercase; 
            display: inline-block;
            text-decoration: none;
            padding: 8px 16px;
        }
        .btn-ui-outline:hover { 
            background: var(--ui-navy); 
            color: #fff !important; 
        }
        .btn-ui-danger {
            background: #fff;
            color: var(--ui-red) !important;
            border: 1px solid var(--ui-red);
            font-weight: 700;
            font-size: 0.75rem;
            text-transform: uppercase;
            padding: 4px 10px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-ui-danger:hover {
            background: var(--ui-red);
            color: #fff !important;
        }
        .info-box {
            background: #f8fafc;
            border: 1px solid var(--ui-border);
            padding: 10px 14px;
            font-size: 0.825rem;
        }
        .table-custom {
            width: 100%;
            border-collapse: collapse;
        }
        .table-custom th {
            background: #f8fafc;
            color: var(--ui-muted);
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            border-bottom: 2px solid var(--ui-border);
            padding: 8px 12px;
        }
        .table-custom td {
            padding: 8px 12px;
            border-bottom: 1px solid var(--ui-border);
            vertical-align: middle;
            font-size: 0.875rem;
        }
        .status-badge {
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            padding: 3px 8px;
            border: 1px solid;
            display: inline-block;
        }
        .status-cancelled { background: #fef2f2; color: var(--ui-red); border-color: var(--ui-red); }
        .status-pending { background: #fffbeb; color: var(--ui-amber); border-color: var(--ui-amber); }
        .status-completed { background: #f0fdf4; color: var(--ui-green); border-color: var(--ui-green); }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@include file="../component/navbar.jsp" %>

    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%
        user u = (user) session.getAttribute("userobj");
        BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
        List<Book_Order> allOrders = dao.getBookOrder(u.getEmail());

        // Group by orderNo
        Map<String, List<Book_Order>> grouped = new LinkedHashMap<>();
        for (Book_Order bo : allOrders) {
            grouped.computeIfAbsent(bo.getOrderNo(), k -> new ArrayList<>()).add(bo);
        }
        java.text.DecimalFormat fmt = new java.text.DecimalFormat("#,###");
    %>

    <div class="container p-3 p-md-4 my-auto flex-grow-1">
        <% if (grouped.isEmpty()) { %>
            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">
                    <div class="ui-card p-5 text-center">
                        <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                        <h5 class="fw-bold text-uppercase mb-1" style="color: var(--ui-navy);">No Orders Found</h5>
                        <p class="small text-muted mb-4">You haven't placed any orders yet. Explore our store to make your first purchase!</p>
                        <a href="${pageContext.request.contextPath}/index.jsp" class="btn-ui-primary">
                            <i class="fas fa-shopping-bag me-1"></i> Start Shopping
                        </a>
                    </div>
                </div>
            </div>
        <% } else { %>
            <div class="row justify-content-center">
                <div class="col-12 col-lg-10">
                    
                    <!-- Section Header -->
                    <div class="ui-card p-4 mb-4">
                        <div class="section-header d-flex justify-content-between align-items-center mb-0 pb-0 border-0">
                            <div>
                                <h5 class="fw-bold m-0 text-uppercase" style="color: var(--ui-navy);">
                                    <i class="fas fa-box-open me-2"></i>My Order History
                                </h5>
                                <div class="small text-muted mt-1" style="font-size: 0.75rem;">View and manage your past order records</div>
                            </div>
                            <span class="btn-ui-outline py-1 px-3" style="font-size: 0.75rem;"><%= grouped.size() %> Order(s)</span>
                        </div>
                    </div>

                    <% for (Map.Entry<String, List<Book_Order>> entry : grouped.entrySet()) {
                        String orderNo = entry.getKey();
                        List<Book_Order> items = entry.getValue();
                        Book_Order first = items.get(0);
                        double orderTotal = 0;
                        for (Book_Order item : items) {
                            try { orderTotal += Double.parseDouble(item.getPrice()); } catch(Exception e2) {}
                        }
                    %>
                    <div class="ui-card p-4 mb-4">
                        
                        <!-- Order Header Bar -->
                        <div class="d-flex flex-wrap justify-content-between align-items-center pb-3 mb-3 border-bottom gap-2">
                            <div class="d-flex align-items-center gap-2">
                                <% if ("Cancelled".equals(first.getStatus())) { %>
                                    <span class="status-badge status-cancelled"><i class="fas fa-times-circle me-1"></i>Cancelled</span>
                                <% } else if ("Pending".equals(first.getStatus()) || "Processing".equals(first.getStatus())) { %>
                                    <span class="status-badge status-pending"><i class="fas fa-clock me-1"></i><%= first.getStatus() %></span>
                                <% } else { %>
                                    <span class="status-badge status-completed"><i class="fas fa-check-circle me-1"></i>Completed</span>
                                <% } %>
                                <span class="small text-muted fw-bold">(<%= items.size() %> Items)</span>
                            </div>
                            <div class="font-monospace small fw-bold" style="color: var(--ui-navy);">
                                ORDER ID: <span class="text-primary">#<%= orderNo %></span>
                            </div>
                        </div>

                        <!-- Delivery Info Block -->
                        <div class="info-box mb-3">
                            <div class="row g-2">
                                <div class="col-12 col-md-6"><strong>Recipient:</strong> <%= first.getName() %> (<%= first.getPhone() %>)</div>
                                <div class="col-12 col-md-6"><strong>Payment Method:</strong> <%= first.getPaymentType() %></div>
                                <div class="col-12"><strong>Shipping Address:</strong> <%= first.getAddress() %>, <%= first.getLandmark() %>, <%= first.getCity() %>, <%= first.getState() %> <%= first.getPincode() %></div>
                            </div>
                        </div>

                        <!-- Items Table -->
                        <div class="table-responsive mb-3">
                            <table class="table-custom">
                                <thead>
                                    <tr>
                                        <th style="width: 40px;">#</th>
                                        <th>Book Name</th>
                                        <th>Author</th>
                                        <th class="text-end">Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int i = 1; for (Book_Order item : items) {
                                        double p = 0;
                                        try { p = Double.parseDouble(item.getPrice()); } catch(Exception e3) {}
                                    %>
                                    <tr>
                                        <td class="text-muted fw-bold small"><%= i++ %></td>
                                        <td class="fw-bold" style="color: var(--ui-navy);"><%= item.getBookName() %></td>
                                        <td class="text-muted"><%= item.getAuthor() %></td>
                                        <td class="text-end fw-bold" style="color: var(--ui-navy);"><%= fmt.format(p) %> ៛</td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>

                        <!-- Footer / Actions -->
                        <div class="d-flex flex-wrap justify-content-between align-items-center pt-2">
                            <div>
                                <% if ("Pending".equals(first.getStatus()) || "Processing".equals(first.getStatus())) { %>
                                    <a href="${pageContext.request.contextPath}/cancel_order?orderNo=<%= orderNo %>" 
                                       class="btn-ui-danger"
                                       onclick="return confirm('Are you sure you want to cancel this order?')">
                                        <i class="fas fa-ban me-1"></i> Cancel Order
                                    </a>
                                <% } %>
                            </div>
                            <div class="text-end">
                                <span class="small text-uppercase text-muted fw-bold me-2">Total Amount:</span>
                                <span class="fw-bold fs-6" style="color: var(--ui-green);"><%= fmt.format(orderTotal) %> ៛</span>
                            </div>
                        </div>

                    </div>
                    <% } %>

                    <div class="text-center mt-4">
                        <a href="${pageContext.request.contextPath}/index.jsp" class="btn-ui-outline">
                            <i class="fas fa-arrow-left me-1"></i> Back to Store
                        </a>
                    </div>

                </div>
            </div>
        <% } %>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>