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
    <style>
        .page-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            padding: 14px 24px; display: flex; align-items: center; gap: 16px;
        }
        .page-header .back-btn {
            background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.3);
            color: white; padding: 6px 14px; border-radius: 50px; text-decoration: none;
            font-size: 13px; font-weight: 500; transition: all 0.2s;
        }
        .page-header .back-btn:hover { background: rgba(255,255,255,0.3); color: white; }
        .page-header h5 { color: white; margin: 0; font-weight: 700; }
        .order-card { border-left: 4px solid #0d6efd; transition: all 0.2s; }
        .order-card:hover { box-shadow: 0 6px 20px rgba(0,0,0,0.1) !important; transform: translateY(-2px); }
        .order-id-badge { font-family: monospace; font-size: 12px; }
    </style>
</head>
<body class="bg-light">

    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%-- Clean Header --%>
    <div class="page-header shadow">
        <a href="${pageContext.request.contextPath}/setting.jsp" class="back-btn">
            <i class="fas fa-arrow-left me-1"></i> Go Back
        </a>
        <h5><i class="fas fa-box-open me-2"></i> My Order History</h5>
    </div>

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

    <div class="container py-4">

        <% if (grouped.isEmpty()) { %>
            <div class="card border-0 shadow-sm text-center p-5">
                <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                <p class="fw-semibold text-muted mb-3">You have no orders yet.</p>
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary btn-sm rounded-pill px-4">
                    <i class="fas fa-store me-1"></i> Start Shopping
                </a>
            </div>
        <% } else { %>
            <p class="text-muted mb-3 small">Showing <strong><%= grouped.size() %></strong> order(s)</p>

            <% for (Map.Entry<String, List<Book_Order>> entry : grouped.entrySet()) {
                String orderNo = entry.getKey();
                List<Book_Order> items = entry.getValue();
                Book_Order first = items.get(0);
                double orderTotal = 0;
                for (Book_Order item : items) {
                    try { orderTotal += Double.parseDouble(item.getPrice()); } catch(Exception e2) {}
                }
            %>
            <div class="card shadow-sm border-0 rounded-3 mb-4 order-card">
                <%-- Order Header --%>
                <div class="card-header bg-white border-bottom d-flex justify-content-between align-items-center flex-wrap gap-2 py-3">
                    <div>
                        <span class="badge bg-primary-subtle text-primary order-id-badge me-2">
                            <i class="fas fa-hashtag me-1"></i><%= orderNo %>
                        </span>
                        <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>Completed</span>
                    </div>
                    <div class="text-end">
                        <span class="text-muted small"><%= items.size() %> book(s) &nbsp;|&nbsp;</span>
                        <span class="fw-bold text-danger"><%= fmt.format(orderTotal) %> ៛</span>
                    </div>
                </div>

                <%-- Delivery Info --%>
                <div class="card-body border-bottom pb-3">
                    <div class="row g-2 text-muted small">
                        <div class="col-md-4">
                            <i class="fas fa-user text-primary me-1"></i>
                            <strong>Recipient:</strong> <%= first.getName() %>
                        </div>
                        <div class="col-md-4">
                            <i class="fas fa-phone text-primary me-1"></i>
                            <strong>Phone:</strong> <%= first.getPhone() %>
                        </div>
                        <div class="col-md-4">
                            <i class="fas fa-credit-card text-primary me-1"></i>
                            <strong>Payment:</strong>
                            <span class="badge bg-light text-dark border"><%= first.getPaymentType() %></span>
                        </div>
                        <div class="col-12">
                            <i class="fas fa-map-marker-alt text-danger me-1"></i>
                            <strong>Address:</strong>
                            <%= first.getAddress() %>, <%= first.getLandmark() %>, <%= first.getCity() %>, <%= first.getState() %> <%= first.getPincode() %>
                        </div>
                    </div>
                </div>

                <%-- Books in this Order --%>
                <div class="card-body p-0">
                    <table class="table table-sm table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3">#</th>
                                <th>Book Name</th>
                                <th>Author</th>
                                <th class="text-end pe-3">Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% int i = 1; for (Book_Order item : items) {
                                double p = 0;
                                try { p = Double.parseDouble(item.getPrice()); } catch(Exception e3) {}
                            %>
                            <tr>
                                <td class="ps-3 text-muted"><%= i++ %></td>
                                <td class="fw-semibold"><%= item.getBookName() %></td>
                                <td class="text-muted small"><%= item.getAuthor() %></td>
                                <td class="text-end pe-3 text-danger fw-bold"><%= fmt.format(p) %> ៛</td>
                            </tr>
                            <% } %>
                            <tr class="table-light fw-bold">
                                <td colspan="3" class="text-end pe-3">Order Total:</td>
                                <td class="text-end pe-3 text-success fs-6"><%= fmt.format(orderTotal) %> ៛</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <% } %>
        <% } %>

    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>