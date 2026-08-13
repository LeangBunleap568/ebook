<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOImpl" %>
<%@ page import="com.db.DBconnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App - All Books Inventory</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        .custom-card {
            border: 1px solid rgba(0, 0, 0, 0.08) !important;
            border-radius: 8px !important;
        }
        .table img {
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .btn-action {
            padding: 4px 10px;
            font-size: 13px;
            border-radius: 4px !important;
        }
    </style>
</head>
<body class="bg-light">

    <%@include file="../component/navbar.jsp" %>

    <div class="container my-5">
        
        <!-- Header Banner -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fas fa-books text-primary me-2"></i>Book Inventory
                </h3>
                <p class="text-muted small mb-0">Manage catalog records, prices, stock statuses, and publications.</p>
            </div>
            <a href="addBook.jsp" class="btn btn-primary btn-sm rounded-1 px-3 py-2 fw-semibold">
                <i class="fas fa-plus me-1"></i> Add New Book
            </a>
        </div>

        <!-- Inventory Table Card -->
        <div class="card custom-card shadow-sm p-4 bg-white">
            <div class="table-responsive">
                <table class="table align-middle table-hover mb-0">
                    <thead class="table-light">
                        <tr class="text-secondary small text-uppercase fw-bold">
                            <th scope="col" style="width: 70px;">Cover</th>
                            <th scope="col">Title</th>
                            <th scope="col">Author</th>
                            <th scope="col">Category</th>
                            <th scope="col">Price</th>
                            <th scope="col">Status</th>
                            <th scope="col" class="text-center" style="width: 140px;">Action</th>
                        </tr>
                   <tbody>
    <%
    BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
    List<BookDtls> list = dao.getAllBooks();
    for (BookDtls b : list) {
        String photoName = b.getPhotoName();
        String imageSrc = "";
        if (photoName != null && (photoName.startsWith("http://") || photoName.startsWith("https://"))) {
            imageSrc = photoName;
        } else {
            imageSrc = request.getContextPath() + "/img/" + photoName;
        }
    %>
    <tr>
        <td>
            <img src="<%= imageSrc %>" 
                 style="width: 42px; height: 56px; object-fit: cover;" 
                 alt="<%= b.getBookName() %>"
                 onerror="this.onerror=null; this.src='https://via.placeholder.com/42x56?text=No+Cover';" />
        </td>
        <td>
            <span class="fw-bold text-dark d-block"><%= b.getBookName() %></span>
        </td>
        <td class="text-secondary"><%= b.getAuthor() %></td>
        <td>
            <span class="badge bg-info-subtle text-info-emphasis border border-info-subtle rounded-1 px-2 py-1">
                <%= b.getBookCategory() %>
            </span>
        </td>
        <td class="fw-bold text-dark"><%= b.getPrice() %> ៛</td>
        <td>
            <span class="badge bg-success-subtle text-success border border-success-subtle rounded-1">
                <i class="fas fa-circle fa-xs me-1"></i><%= b.getStatus() %>
            </span>
        </td>
        <td class="text-center">
            <a href="editBook.jsp?id=<%= b.getBookId() %>" class="btn btn-sm btn-outline-primary btn-action me-1">
                <i class="fas fa-edit"></i> Edit
            </a>
            <a href="../delete_book?id=<%= b.getBookId() %>" class="btn btn-sm btn-outline-danger btn-action">
                <i class="fas fa-trash-alt"></i>
            </a>
        </td>
    </tr>
    <%
    }
    %>
</tbody>
                </table>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>