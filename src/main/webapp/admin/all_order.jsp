<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.ebook.dao.impl.BookOrderDAOImpl" %>
<%@ page import="com.ebook.entity.Book_Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="com.ebook.db.DBconnect" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - All Users Orders</title>
<%@include file="../component/rootCss.jsp"%>
</head>
<body class="bg-light">
    <%-- Restrict Access --%>
    <c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%@include file="../component/navbar.jsp"%>

    <div class="container p-3">
        <h3 class="text-center text-success">All Customers with Orders</h3>
        <table class="table table-striped mt-3">
            <thead class="bg-primary text-white">
                <tr>
                    <th scope="col">Customer Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Total Orders</th>
                    <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
                List<Book_Order> list = dao.getAllOrder();
                Map<String, List<Book_Order>> grouped = new LinkedHashMap<>();
                for (Book_Order b : list) {
                    if (!grouped.containsKey(b.getEmail())) {
                        grouped.put(b.getEmail(), new ArrayList<>());
                    }
                    grouped.get(b.getEmail()).add(b);
                }

                for (Map.Entry<String, List<Book_Order>> entry : grouped.entrySet()) {
                    List<Book_Order> userOrders = entry.getValue();
                    Book_Order firstOrder = userOrders.get(0);
                %>
                <tr>
                    <td><%=firstOrder.getName()%></td>
                    <td><%=firstOrder.getEmail()%></td>
                    <td><%=firstOrder.getPhone()%></td>
                    <td><%=userOrders.size()%></td>
                    <td>
                        <a href="user_orders.jsp?email=<%=firstOrder.getEmail()%>" class="btn btn-sm btn-warning">View Orders</a>
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
    
    <%@include file="../component/footer.jsp" %>
</body>
</html>
