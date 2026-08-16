<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.ebook.dao.impl.BookOrderDAOImpl" %>
<%@ page import="com.ebook.entity.Book_Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="com.ebook.db.DBconnect" %>
<c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
    <c:redirect url="../login.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin — Customer Orders</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        body { 
            background: #f0f2f5; 
            font-family: 'Segoe UI', sans-serif; 
        }
        .orders-card { 
            border: none; 
            border-radius: 16px; 
            box-shadow: 0 4px 18px rgba(0,0,0,0.07); 
            background: #fff;
        }
        .avatar-circle {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #495057;
            font-weight: 600;
            font-size: 14px;
        }
        .badge-orders { 
            font-size: 12px; 
            padding: 5px 12px; 
            border-radius: 50px; 
            font-weight: 600; 
        }
        .btn-action { 
            padding: 5px 14px; 
            font-size: 12px; 
            border-radius: 50px !important; 
            font-weight: 500; 
        }
        .search-bar { 
            border-radius: 50px; 
            border: 1px solid #dee2e6; 
            padding-left: 16px; 
        }
    </style>
</head>
<body>

    <c:set var="activePage" value="orders" scope="request" />
    <%@include file="../component/navbar.jsp" %>

    <%
        BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
        List<Book_Order> list = dao.getAllOrder();
        Map<String, List<Book_Order>> grouped = new LinkedHashMap<>();
        
        if (list != null) {
            for (Book_Order b : list) {
                if (!grouped.containsKey(b.getEmail())) {
                    grouped.put(b.getEmail(), new ArrayList<>());
                }
                grouped.get(b.getEmail()).add(b);
            }
        }
    %>

    <div class="container-fluid px-4 py-4">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-0">
                    <i class="fas fa-shopping-bag text-primary me-2"></i>Customer Orders Overview
                </h4>
                <small class="text-muted"><%= grouped.size() %> customer(s) with active order histories</small>
            </div>
        </div>

        <div class="card orders-card">
            <div class="card-header bg-white border-bottom d-flex align-items-center justify-content-between py-3">
                <span class="fw-bold text-dark"><i class="fas fa-users text-primary me-2"></i>Customers List</span>
                <input type="text" id="searchInput" class="form-control form-control-sm search-bar"
                       style="max-width:260px;" placeholder="🔍 Search customers or emails…" onkeyup="filterTable()">
            </div>
            
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="ordersTable">
                    <thead class="table-light">
                        <tr class="text-muted small text-uppercase fw-bold">
                            <th class="ps-4">Customer</th>
                            <th>Email Address</th>
                            <th>Phone Number</th>
                            <th>Total Orders</th>
                            <th class="text-center pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        for (Map.Entry<String, List<Book_Order>> entry : grouped.entrySet()) {
                            List<Book_Order> userOrders = entry.getValue();
                            Book_Order firstOrder = userOrders.get(0);
                            String initials = firstOrder.getName() != null && !firstOrder.getName().isEmpty() 
                                ? firstOrder.getName().substring(0, 1).toUpperCase() 
                                : "U";
                        %>
                        <tr>
                            <td class="ps-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-circle me-3">
                                        <%= initials %>
                                    </div>
                                    <div class="fw-bold text-dark"><%= firstOrder.getName() %></div>
                                </div>
                            </td>
                            <td class="text-muted">
                                <i class="fas fa-envelope me-1 opacity-50"></i><%= firstOrder.getEmail() %>
                            </td>
                            <td class="text-muted">
                                <i class="fas fa-phone me-1 opacity-50"></i><%= firstOrder.getPhone() %>
                            </td>
                            <td>
                                <span class="badge badge-orders bg-primary-subtle text-primary">
                                    <i class="fas fa-box me-1"></i><%= userOrders.size() %> Order(s)
                                </span>
                            </td>
                            <td class="text-center pe-4">
                                <a href="${pageContext.request.contextPath}/admin/order_details.jsp?email=<%= firstOrder.getEmail() %>" 
                                   class="btn btn-sm btn-outline-primary btn-action">
                                    <i class="fas fa-eye me-1"></i>View Details
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <% if (grouped.isEmpty()) { %>
                <div class="text-center py-5 text-muted">
                    <i class="fas fa-box-open fa-3x mb-3 text-secondary opacity-50"></i>
                    <p class="fw-semibold mb-0">No customer orders found.</p>
                    <small>When customers place orders, they will appear here.</small>
                </div>
            <% } %>
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

    <%@include file="../component/footer.jsp" %>
</body>
</html>

