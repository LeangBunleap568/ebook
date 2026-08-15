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
<title>Admin — User Order Details</title>
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
    .order-card { border-left: 4px solid #198754; }
    .order-id-badge { font-family: monospace; font-size: 12px; }
</style>
</head>
<body class="bg-light">
    <c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%
        String email = request.getParameter("email");
        BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
        List<Book_Order> list = dao.getBookOrder(email);

        // Group by orderNo
        Map<String, List<Book_Order>> grouped = new LinkedHashMap<>();
        for (Book_Order bo : list) {
            grouped.computeIfAbsent(bo.getOrderNo(), k -> new ArrayList<>()).add(bo);
        }
        java.text.DecimalFormat fmt = new java.text.DecimalFormat("#,###");
        Book_Order firstEver = list.isEmpty() ? null : list.get(0);
    %>

    <div class="page-header shadow">
        <a href="all_order.jsp" class="back-btn">
            <i class="fas fa-arrow-left me-1"></i> All Customers
        </a>
        <h5>
            <i class="fas fa-user-circle me-2"></i>
            Orders for: <%= firstEver != null ? firstEver.getName() : email %>
        </h5>
    </div>

    <div class="container py-4">

        <% if (list.isEmpty()) { %>
            <div class="card border-0 shadow-sm text-center p-5">
                <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                <p class="text-muted fw-semibold">No orders found for this customer.</p>
                <a href="all_order.jsp" class="btn btn-primary btn-sm rounded-pill px-4">Back to All Customers</a>
            </div>
        <% } else { %>

            <%-- Customer Info Card --%>
            <div class="card border-0 shadow-sm rounded-3 mb-4">
                <div class="card-header bg-primary text-white fw-bold py-3 rounded-top-3">
                    <i class="fas fa-id-card me-2"></i> Customer Information
                </div>
                <div class="card-body">
                    <div class="row g-2 text-muted small">
                        <div class="col-md-4"><i class="fas fa-user text-primary me-1"></i> <strong>Name:</strong> <%= firstEver.getName() %></div>
                        <div class="col-md-4"><i class="fas fa-envelope text-primary me-1"></i> <strong>Email:</strong> <%= firstEver.getEmail() %></div>
                        <div class="col-md-4"><i class="fas fa-phone text-primary me-1"></i> <strong>Phone:</strong> <%= firstEver.getPhone() %></div>
                        <div class="col-12"><i class="fas fa-map-marker-alt text-danger me-1"></i> <strong>Last Address:</strong>
                            <%= firstEver.getAddress() %>, <%= firstEver.getLandmark() %>, <%= firstEver.getCity() %>, <%= firstEver.getState() %> <%= firstEver.getPincode() %>
                        </div>
                    </div>
                </div>
            </div>

            <p class="text-muted small mb-3">
                <strong><%= grouped.size() %></strong> order(s) &nbsp;|&nbsp;
                <strong><%= list.size() %></strong> total book(s)
            </p>

            <%-- One card per orderNo --%>
            <% for (Map.Entry<String, List<Book_Order>> entry : grouped.entrySet()) {
                String orderNo = entry.getKey();
                List<Book_Order> items = entry.getValue();
                Book_Order first = items.get(0);
                double orderTotal = 0;
                for (Book_Order item : items) {
                    try { orderTotal += Double.parseDouble(item.getPrice()); } catch(Exception ex) {}
                }
            %>
            <div class="card border-0 shadow-sm rounded-3 mb-3 order-card">
                <div class="card-header bg-white border-bottom d-flex justify-content-between align-items-center py-3">
                    <div>
                        <span class="badge bg-success-subtle text-success order-id-badge me-2">
                            <i class="fas fa-hashtag me-1"></i><%= orderNo %>
                        </span>
                        <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>Completed</span>
                    </div>
                    <div>
                        <span class="text-muted small"><%= items.size() %> book(s) &nbsp;|&nbsp;</span>
                        <span class="fw-bold text-danger"><%= fmt.format(orderTotal) %> ៛</span>
                        &nbsp;
                        <span class="badge bg-light text-dark border"><%= first.getPaymentType() %></span>
                    </div>
                </div>
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
                                try { p = Double.parseDouble(item.getPrice()); } catch(Exception ex) {}
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
