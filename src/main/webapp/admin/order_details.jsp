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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin — User Order Details</title>
<%@include file="../component/rootCss.jsp" %>
<style>
    .order-card { 
        border-left: 4px solid #198754 !important; 
    }
    .order-id-badge { 
        font-family: monospace; 
        font-size: 13px; 
    }
</style>
</head>
<body class="bg-light">
    <%-- Security Check --%>
    <c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%-- Set active nav header highlight --%>
    <c:set var="activePage" value="orders" scope="request" />
    <%@include file="../component/navbar.jsp" %>

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

    <div class="container-fluid px-4 py-4">

        <!-- Top Breadcrumb/Title Navigation -->
        <div class="d-flex align-items-center justify-content-between mb-4 pb-2 border-bottom">
            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                    <i class="fas fa-arrow-left me-1"></i> Back to Orders
                </a>
                <h4 class="fw-bold mb-0 text-dark">
                    <i class="fas fa-user-circle text-primary me-2"></i>
                    Orders for: <%= firstEver != null ? firstEver.getName() : (email != null ? email : "Customer") %>
                </h4>
            </div>
            <% if (list != null && !list.isEmpty()) { %>
                <span class="badge bg-primary fs-6 fw-normal px-3 py-2 rounded-pill">
                    Total <%= grouped.size() %> Order(s)
                </span>
            <% } %>
        </div>

        <% if (list == null || list.isEmpty()) { %>
            <!-- Empty State -->
            <div class="card border-0 shadow-sm text-center p-5 my-4">
                <div class="card-body">
                    <i class="fas fa-inbox fa-4x text-muted mb-3 opacity-50"></i>
                    <h5 class="fw-bold text-secondary">No orders found for this customer</h5>
                    <p class="text-muted small mb-4">This account hasn't placed any orders yet or the email address is invalid.</p>
                    <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="btn btn-primary btn-sm rounded-pill px-4">
                        <i class="fas fa-arrow-left me-1"></i> Back to All Orders
                    </a>
                </div>
            </div>
        <% } else { %>

            <!-- Customer Info Card -->
            <div class="card border-0 shadow-sm rounded-3 mb-4">
                <div class="card-header bg-dark text-white fw-bold py-3">
                    <i class="fas fa-id-card me-2"></i> Customer Details
                </div>
                <div class="card-body bg-white">
                    <div class="row g-3 text-secondary small">
                        <div class="col-md-4">
                            <i class="fas fa-user text-primary me-2"></i><strong>Name:</strong> 
                            <span class="text-dark fw-semibold"><%= firstEver.getName() %></span>
                        </div>
                        <div class="col-md-4">
                            <i class="fas fa-envelope text-primary me-2"></i><strong>Email:</strong> 
                            <span class="text-dark fw-semibold"><%= firstEver.getEmail() %></span>
                        </div>
                        <div class="col-md-4">
                            <i class="fas fa-phone text-primary me-2"></i><strong>Phone:</strong> 
                            <span class="text-dark fw-semibold"><%= firstEver.getPhone() %></span>
                        </div>
                        <div class="col-12">
                            <i class="fas fa-map-marker-alt text-danger me-2"></i><strong>Address:</strong>
                            <span class="text-dark">
                                <%= firstEver.getAddress() %>, <%= firstEver.getLandmark() %>, <%= firstEver.getCity() %>, <%= firstEver.getState() %> <%= firstEver.getPincode() %>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <p class="text-muted small mb-3 fw-semibold">
                Showing <%= grouped.size() %> order(s) containing <%= list.size() %> total book item(s)
            </p>

            <!-- Order Cards Loop -->
            <% for (Map.Entry<String, List<Book_Order>> entry : grouped.entrySet()) {
                String orderNo = entry.getKey();
                List<Book_Order> items = entry.getValue();
                Book_Order first = items.get(0);
                double orderTotal = 0;
                for (Book_Order item : items) {
                    try { orderTotal += Double.parseDouble(item.getPrice()); } catch(Exception ex) {}
                }
            %>
            <div class="card border-0 shadow-sm rounded-3 mb-4 order-card">
                <div class="card-header bg-white border-bottom d-flex flex-wrap justify-content-between align-items-center py-3">
                    <div class="d-flex align-items-center mb-2 mb-md-0">
                        <span class="badge bg-success-subtle text-success border border-success-subtle order-id-badge px-3 py-2 me-2">
                            <i class="fas fa-hashtag me-1"></i><%= orderNo %>
                        </span>
                        <span class="badge bg-success px-2 py-1"><i class="fas fa-check-circle me-1"></i>Completed</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="text-muted small"><%= items.size() %> book(s)</span>
                        <span class="text-muted small">|</span>
                        <span class="fw-bold text-danger fs-6"><%= fmt.format(orderTotal) %> ៛</span>
                        <span class="badge bg-light text-dark border ms-2"><%= first.getPaymentType() %></span>
                    </div>
                </div>

                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light text-muted small">
                                <tr>
                                    <th class="ps-4" style="width: 50px;">#</th>
                                    <th>Book Name</th>
                                    <th>Author</th>
                                    <th class="text-end pe-4">Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int i = 1; for (Book_Order item : items) {
                                    double p = 0;
                                    try { p = Double.parseDouble(item.getPrice()); } catch(Exception ex) {}
                                %>
                                <tr>
                                    <td class="ps-4 text-muted"><%= i++ %></td>
                                    <td class="fw-semibold text-dark"><%= item.getBookName() %></td>
                                    <td class="text-muted small"><%= item.getAuthor() %></td>
                                    <td class="text-end pe-4 text-danger fw-bold"><%= fmt.format(p) %> ៛</td>
                                </tr>
                                <% } %>
                                <tr class="table-light fw-bold">
                                    <td colspan="3" class="text-end pe-3 text-secondary">Order Total:</td>
                                    <td class="text-end pe-4 text-success fs-6"><%= fmt.format(orderTotal) %> ៛</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <% } %>

        <% } %>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>

