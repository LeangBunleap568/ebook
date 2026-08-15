<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.dao.impl.BookDAOImpl" %>
<%@ page import="com.ebook.db.DBconnect" %>
<%@ page import="com.ebook.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <%@include file="component/rootCss.jsp" %>
</head>
<body class="bg-light">
    <%@include file="component/navbar.jsp" %>

    <div class="container p-4 my-4">
        <%
            String ch = request.getParameter("ch");
            if (ch == null) ch = "";
        %>
        <h4 class="fw-bold text-primary mb-4">
            <i class="fas fa-search me-2"></i> Search Results for: "<%= ch %>"
        </h4>

        <%
            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
            List<BookDtls> books = dao.getBookBySearch(ch);
        %>

        <% if (books.isEmpty()) { %>
            <div class="alert alert-warning text-center my-5">
                <h5><i class="fas fa-exclamation-circle me-2"></i> No books found for "<%= ch %>".</h5>
                <a href="index.jsp" class="btn btn-primary mt-3">Back to Home</a>
            </div>
        <% } else { %>
            <div class="row g-4">
                <% for (BookDtls b : books) { %>
                <div class="col-md-3">
                    <div class="card h-100 shadow-sm border-0">
                        <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>"
                             class="card-img-top" style="height:220px;object-fit:cover;"
                             alt="<%= b.getBookName() %>">
                        <div class="card-body d-flex flex-column">
                            <h6 class="fw-bold mb-1"><%= b.getBookName() %></h6>
                            <p class="text-muted small mb-1"><%= b.getAuthor() %></p>
                            <span class="badge bg-warning text-dark mb-2"><%= b.getBookCategory() %></span>
                            <p class="text-danger fw-bold mb-3"><%= new java.text.DecimalFormat("#,###").format(Double.parseDouble(b.getPrice())) %> ៛</p>
                            <div class="mt-auto d-flex gap-2">
                                <a href="books/view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-sm btn-outline-primary flex-fill">View</a>
                                <a href="cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-sm btn-warning flex-fill">
                                    <i class="fas fa-cart-plus me-1"></i>Cart
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>
    </div>

    <%@include file="component/footer.jsp" %>
</body>
</html>
