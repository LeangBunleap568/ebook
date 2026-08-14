<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.db.DBconnect" %>
<%@ page import="com.ebook.dao.impl.BookDAOImpl" %>
<%@ page import="com.ebook.entity.BookDtls" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Book Details</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">
    <%@include file="../component/navbar.jsp" %>

    <%
        int id = Integer.parseInt(request.getParameter("id"));
        BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
        BookDtls b = dao.getBookById(id);
    %>

    <div class="container p-3 my-5">
        <div class="row g-4">
            <div class="col-md-6 text-center p-5 border bg-white rounded shadow-sm">
                <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" style="height: 300px; width: 200px; object-fit: cover;" class="rounded"><br>
                <h4 class="mt-4">Book Name: <span class="text-success"><%= b.getBookName() %></span></h4>
                <h4>Author Name: <span class="text-success"><%= b.getAuthor() %></span></h4>
                <h4>Category: <span class="text-success"><%= b.getBookCategory() %></span></h4>
            </div>

            <div class="col-md-6 text-center p-5 border bg-white rounded shadow-sm">
                <h2 class="fw-bold mb-4"><%= b.getBookName() %></h2>
                
                <% if("Old".equals(b.getBookCategory())) { %>
                <h5 class="text-primary mt-4">Contact Seller</h5>
                <h5 class="text-primary"><i class="fas fa-envelope me-2"></i>Email: <%= b.getEmail() %></h5>
                <% } %>
                
                <div class="row mt-5 mb-5">
                    <div class="col-md-4 text-danger text-center p-2">
                        <i class="fas fa-money-bill-wave fa-2x mb-2"></i>
                        <p class="fw-bold">Cash On Delivery</p>
                    </div>
                    <div class="col-md-4 text-danger text-center p-2">
                        <i class="fas fa-undo-alt fa-2x mb-2"></i>
                        <p class="fw-bold">Return Available</p>
                    </div>
                    <div class="col-md-4 text-danger text-center p-2">
                        <i class="fas fa-truck-moving fa-2x mb-2"></i>
                        <p class="fw-bold">Free Shipping</p>
                    </div>
                </div>

                <div class="text-center p-3 mt-4">
                    <% if("Old".equals(b.getBookCategory())) { %>
                        <a href="../index.jsp" class="btn btn-success btn-lg me-2"><i class="fas fa-cart-plus me-1"></i> Continue Shopping</a>
                        <span class="btn btn-danger btn-lg disabled"><%= b.getPrice() %> áŸ›</span>
                    <% } else { %>
                        <a href="../cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-primary btn-lg me-2"><i class="fas fa-cart-plus me-1"></i> Add to Cart</a>
                        <span class="btn btn-danger btn-lg disabled"><%= b.getPrice() %> áŸ›</span>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    
    <%@include file="../component/footer.jsp" %>
</body>
</html>
