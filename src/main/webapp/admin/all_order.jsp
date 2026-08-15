<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.ebook.dao.impl.BookOrderDAOImpl" %>
<%@ page import="com.ebook.entity.Book_Order" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ebook.db.DBconnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin — All Customer Orders</title>
<%@include file="../component/rootCss.jsp"%>
<style>
    .page-header {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        padding: 14px 24px; display: flex; align-items: center; gap: 16px;
    }
    .page-header .back-btn {
        background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.3);
        color: white; padding: 6px 14px; border-radius: 50px; text-decoration: none;
        font-size: 13px; font-weight: 500;
    }
    .page-header .back-btn:hover { background: rgba(255,255,255,0.3); color: white; }
    .page-header h5 { color: white; margin: 0; font-weight: 700; }
</style>
</head>
<body class="bg-light">
    <%-- Restrict Access --%>
    <c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <div class="page-header shadow">
        <a href="${pageContext.request.contextPath}/admin/home.jsp" class="back-btn">
            <i class="fas fa-arrow-left me-1"></i> Admin Home
        </a>
        <h5><i class="fas fa-clipboard-list me-2"></i> All Customer Orders</h5>
    </div>

    <div class="container py-4">
        <%
            BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
            List<Book_Order> list = dao.getAllOrder();

            // Group by email to show one row per customer
            Map<String, List<Book_Order>> byEmail = new LinkedHashMap<>();
            for (Book_Order b : list) {
                byEmail.computeIfAbsent(b.getEmail(), k -> new ArrayList<>()).add(b);
            }

            // Count unique orders per customer by orderNo
        %>

        <div class="card shadow-sm border-0 rounded-3">
            <div class="card-header bg-white border-bottom fw-bold py-3">
                <i class="fas fa-users text-primary me-2"></i>
                Customers with Orders
                <span class="badge bg-primary ms-2"><%= byEmail.size() %></span>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th class="ps-3">#</th>
                            <th>Customer Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th class="text-center">Total Orders</th>
                            <th class="text-center">Total Books</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        int rowIdx = 1;
                        for (Map.Entry<String, List<Book_Order>> entry : byEmail.entrySet()) {
                            List<Book_Order> userOrders = entry.getValue();
                            Book_Order first = userOrders.get(0);
                            // Count unique orderNos for this customer
                            Set<String> uniqueOrderNos = new LinkedHashSet<>();
                            for (Book_Order bo : userOrders) uniqueOrderNos.add(bo.getOrderNo());
                        %>
                        <tr>
                            <td class="ps-3 text-muted"><%= rowIdx++ %></td>
                            <td class="fw-semibold"><%= first.getName() %></td>
                            <td class="text-muted small"><%= first.getEmail() %></td>
                            <td><%= first.getPhone() %></td>
                            <td class="text-center">
                                <span class="badge bg-primary-subtle text-primary"><%= uniqueOrderNos.size() %> order(s)</span>
                            </td>
                            <td class="text-center">
                                <span class="badge bg-secondary-subtle text-secondary"><%= userOrders.size() %> book(s)</span>
                            </td>
                            <td class="text-center">
                                <a href="user_orders.jsp?email=<%= first.getEmail() %>" class="btn btn-sm btn-warning rounded-pill px-3">
                                    <i class="fas fa-eye me-1"></i> View Orders
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>
