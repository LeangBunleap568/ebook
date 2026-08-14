<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.ebook.dao.impl.BookOrderDAOImpl" %>
<%@ page import="com.entity.Book_Order" %>
<%@ page import="java.util.List" %>
<%@ page import="com.db.DBconnect" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - User Orders</title>
<%@include file="../component/rootCss.jsp"%>
</head>
<body class="bg-light">
    <%-- Restrict Access --%>
    <c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%@include file="../component/navbar.jsp"%>

    <div class="container p-3">
        <%
            String email = request.getParameter("email");
            BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
            List<Book_Order> list = dao.getBookOrder(email);
            
            if (list != null && !list.isEmpty()) {
                Book_Order firstOrder = list.get(0);
        %>
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="text-success m-0">Orders for <%=firstOrder.getName()%></h3>
            <a href="all_order.jsp" class="btn btn-secondary">Back to All Users</a>
        </div>

        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-primary text-white">
                Customer Information
            </div>
            <div class="card-body">
                <p class="mb-1"><strong>Name:</strong> <%=firstOrder.getName()%></p>
                <p class="mb-1"><strong>Email:</strong> <%=firstOrder.getEmail()%></p>
                <p class="mb-1"><strong>Phone:</strong> <%=firstOrder.getPhone()%></p>
                <p class="mb-0"><strong>Address:</strong> <%=firstOrder.getAddress()%>, <%=firstOrder.getLandmark()%>, <%=firstOrder.getCity()%>, <%=firstOrder.getState()%>, <%=firstOrder.getPincode()%></p>
            </div>
        </div>

        <table class="table table-striped">
            <thead class="bg-dark text-white">
                <tr>
                    <th scope="col">Order ID</th>
                    <th scope="col">Book Name</th>
                    <th scope="col">Price</th>
                    <th scope="col">Payment Type</th>
                </tr>
            </thead>
            <tbody>
                <%
                for (Book_Order b : list) {
                %>
                <tr>
                    <td><%=b.getOrderNo()%></td>
                    <td><%=b.getBookName()%></td>
                    <td><%=b.getPrice()%></td>
                    <td><%=b.getPaymentType()%></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
        
        <% } else { %>
            <div class="text-center mt-5">
                <h4 class="text-danger">No orders found for this user.</h4>
                <a href="all_order.jsp" class="btn btn-primary mt-3">Back to All Users</a>
            </div>
        <% } %>
    </div>
    
    <%@include file="../component/footer.jsp" %>
</body>
</html>
