<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.dao.impl.BookOrderDAOImpl" %>
<%@ page import="com.db.DBconnect" %>
<%@ page import="com.entity.Book_Order" %>
<%@ page import="com.entity.user" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <%@include file="component/rootCss.jsp" %>
</head>
<body class="bg-light">
    <%@include file="component/navbar.jsp" %>
    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>

    <div class="container p-4 my-4">
        <div class="card shadow-sm border-0">
            <div class="card-body">
                <h4 class="text-primary fw-bold mb-4"><i class="fas fa-box-open me-2"></i> My Orders</h4>

                <%
                    user u = (user) session.getAttribute("userobj");
                    BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
                    List<Book_Order> orders = dao.getBookOrder(u.getEmail());
                %>

                <% if (orders.isEmpty()) { %>
                    <div class="alert alert-warning text-center my-4">
                        <h5><i class="fas fa-exclamation-circle me-2"></i> You have no orders yet.</h5>
                        <a href="index.jsp" class="btn btn-primary mt-3">Start Shopping</a>
                    </div>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover align-middle text-center">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Order No</th>
                                    <th>Book Name</th>
                                    <th>Author</th>
                                    <th>Price</th>
                                    <th>Payment</th>
                                    <th>City</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int i = 1; for (Book_Order bo : orders) { %>
                                <tr>
                                    <td><%= i++ %></td>
                                    <td><span class="badge bg-info text-dark"><%= bo.getOrderNo() %></span></td>
                                    <td><%= bo.getBookName() %></td>
                                    <td><%= bo.getAuthor() %></td>
                                    <td class="text-danger fw-bold"><%= bo.getPrice() %> ៛</td>
                                    <td><span class="badge bg-success"><%= bo.getPaymentType() %></span></td>
                                    <td><%= bo.getCity() %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <%@include file="component/footer.jsp" %>
</body>
</html>
