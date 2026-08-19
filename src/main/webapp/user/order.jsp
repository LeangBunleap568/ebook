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
    <title>My Orders</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">
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

    <div class="container my-5">
        <% if (grouped.isEmpty()) { %>
            <div class="row justify-content-center">
                <div class="col-md-6 text-center">
                    <div class="card shadow border-0 p-5">
                        <div style="width:100px;height:100px;border-radius:50%;background:rgba(108,117,125,0.1);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                            <i class="fas fa-inbox fa-4x text-secondary"></i>
                        </div>
                        <h3 class="fw-bold text-secondary">No Orders Yet!</h3>
                        <p class="text-muted mt-2">You haven't placed any orders yet. Start exploring our catalog!</p>
                        <div class="d-flex justify-content-center mt-4">
                            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">
                                <i class="fas fa-shopping-bag me-1"></i> Start Shopping
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        <% } else { %>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="fw-bold text-dark mb-0"><i class="fas fa-box-open text-primary me-2"></i>My Order History</h4>
                        <span class="badge bg-primary rounded-pill px-3 py-2"><%= grouped.size() %> Order(s)</span>
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
                    <div class="card shadow border-0 p-4 mb-4">
                        <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                            <div class="d-flex align-items-center gap-2">
                                <% if ("Cancelled".equals(first.getStatus())) { %>
                                    <div style="width:40px;height:40px;border-radius:50%;background:rgba(220,53,69,0.1);display:flex;align-items:center;justify-content:center;">
                                        <i class="fas fa-times-circle text-danger"></i>
                                    </div>
                                    <div>
                                        <h6 class="fw-bold mb-0 text-danger">Order Cancelled</h6>
                                        <small class="text-muted"><%= items.size() %> item(s)</small>
                                    </div>
                                <% } else if ("Pending".equals(first.getStatus()) || "Processing".equals(first.getStatus())) { %>
                                    <div style="width:40px;height:40px;border-radius:50%;background:rgba(255,193,7,0.1);display:flex;align-items:center;justify-content:center;">
                                        <i class="fas fa-clock text-warning"></i>
                                    </div>
                                    <div>
                                        <h6 class="fw-bold mb-0 text-warning">Order <%= first.getStatus() %></h6>
                                        <small class="text-muted"><%= items.size() %> item(s)</small>
                                    </div>
                                <% } else { %>
                                    <div style="width:40px;height:40px;border-radius:50%;background:rgba(25,135,84,0.1);display:flex;align-items:center;justify-content:center;">
                                        <i class="fas fa-check-circle text-success"></i>
                                    </div>
                                    <div>
                                        <h6 class="fw-bold mb-0 text-success">Order Completed</h6>
                                        <small class="text-muted"><%= items.size() %> item(s)</small>
                                    </div>
                                <% } %>
                            </div>
                            <span class="badge bg-info text-dark font-monospace">ID: <%= orderNo %></span>
                        </div>

                        <%-- Delivery Details --%>
                        <div class="alert alert-info py-2 px-3 mb-3 small">
                            <div class="row g-1">
                                <div class="col-md-6"><strong>Recipient:</strong> <%= first.getName() %> (<%= first.getPhone() %>)</div>
                                <div class="col-md-6"><strong>Payment:</strong> <%= first.getPaymentType() %></div>
                                <div class="col-12"><strong>Address:</strong> <%= first.getAddress() %>, <%= first.getLandmark() %>, <%= first.getCity() %>, <%= first.getState() %> <%= first.getPincode() %></div>
                            </div>
                        </div>

                        <%-- Items Table --%>
                        <div class="table-responsive">
                            <table class="table table-sm align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
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
                                        <td class="text-muted"><%= i++ %></td>
                                        <td class="fw-semibold"><%= item.getBookName() %></td>
                                        <td class="text-muted small"><%= item.getAuthor() %></td>
                                        <td class="text-end text-danger fw-bold"><%= fmt.format(p) %> ៛</td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>

                        <div class="d-flex justify-content-between align-items-center pt-3 mt-2 border-top">
                            <div>
                                <% if ("Pending".equals(first.getStatus()) || "Processing".equals(first.getStatus())) { %>
                                    <a href="${pageContext.request.contextPath}/cancel_order?orderNo=<%= orderNo %>" class="btn btn-sm btn-outline-danger">Cancel Order</a>
                                <% } %>
                            </div>
                            <div>
                                <span class="fw-bold text-muted me-2">Total Paid</span>
                                <span class="fw-bold text-success fs-5"><%= fmt.format(orderTotal) %> ៛</span>
                            </div>
                        </div>
                    </div>
                    <% } %>

                    <div class="text-center mt-4">
                        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-secondary">
                            <i class="fas fa-home me-1"></i> Back to Shopping
                        </a>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>