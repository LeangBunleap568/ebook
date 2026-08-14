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

        <!-- Display Success Message -->
        <% 
            String succMsg = (String) session.getAttribute("succMsg");
            if (succMsg != null) {
        %>
            <div class="alert alert-success alert-dismissible fade show text-center mb-4" role="alert">
                <i class="fas fa-check-circle me-2"></i><%= succMsg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% 
                session.removeAttribute("succMsg");
            } 
        %>

        <!-- Display Error/Failed Message -->
        <% 
            String failedMsg = (String) session.getAttribute("failedMsg");
            if (failedMsg != null) {
        %>
            <div class="alert alert-danger alert-dismissible fade show text-center mb-4" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i><%= failedMsg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% 
                session.removeAttribute("failedMsg");
            } 
        %>

        <!-- Header Banner -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fas fa-books text-primary me-2"></i>Book Inventory
                </h3>
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
                    </thead>
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
                                <a href="updateBook.jsp?id=<%= b.getBookId() %>" class="btn btn-sm btn-outline-primary btn-action me-1">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <button type="button" class="btn btn-sm btn-outline-danger btn-action" onclick="showDeleteModal(<%= b.getBookId() %>)">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </button>
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

    <!-- Premium Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg" style="border-radius: 12px; overflow: hidden;">
                <div class="modal-body p-5 text-center">
                    <div class="mb-4">
                        <div class="d-inline-flex align-items-center justify-content-center bg-danger-subtle text-danger rounded-circle" style="width: 72px; height: 72px;">
                            <i class="fas fa-exclamation-triangle fa-2x"></i>
                        </div>
                    </div>
                    <h4 class="fw-bold mb-3" id="deleteConfirmModalLabel">Delete this book?</h4>
                    <p class="text-secondary mb-4 px-2">
                        Are you sure you want to permanently delete this book from your inventory? This action cannot be undone.
                    </p>
                    <div class="d-flex justify-content-center gap-3 mt-4">
                        <button type="button" class="btn btn-light px-4 py-2 fw-semibold" data-bs-dismiss="modal" style="border-radius: 8px;">Cancel</button>
                        <a href="#" id="confirmDeleteBtn" class="btn btn-danger px-4 py-2 fw-semibold" style="border-radius: 8px;">
                            <i class="fas fa-trash-alt me-2"></i>Yes, Delete
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showDeleteModal(bookId) {
            // Set the dynamic link for deletion
            const deleteBtn = document.getElementById('confirmDeleteBtn');
            deleteBtn.href = '${pageContext.request.contextPath}/admin/deleteBook?id=' + bookId;
            
            // Show the modal
            const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            deleteModal.show();
        }
    </script>

    <%@include file="../component/footer.jsp" %>
</body>
</html>