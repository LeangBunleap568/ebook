<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.app.dao.impl.BookDAOImpl" %>
<%@ page import="com.app.db.DBconnect" %>
<%@ page import="com.app.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Security Check --%>
<c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
    <c:redirect url="../login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App — Book Inventory</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
            margin: 0;
            padding: 0;
            font-size: 13px;
            color: #333;
        }

        .content-body {
            padding: 0 20px 20px 20px;
        }

        .page-title {
            font-size: 20px;
            font-weight: 400;
            margin-bottom: 20px;
            color: #2c3e50;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        /* CF Dashboard Card */
        .cf-card {
            background: #fff;
            border-radius: 4px;
            border: 1px solid #dcdcdc;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            padding: 15px;
            margin-bottom: 15px;
        }
        .cf-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .cf-card-title {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .badge-count {
            background: #7f8c8d;
            color: #fff;
            font-size: 10px;
            padding: 2px 6px;
            border-radius: 3px;
        }

        /* Tables Inside Panels */
        .table-cf {
            width: 100%;
            border-collapse: collapse;
        }
        .table-cf th {
            text-align: left;
            font-size: 11px;
            color: #7f8c8d;
            padding: 8px 6px;
            border-bottom: 1px solid #eee;
            font-weight: 600;
        }
        .table-cf td {
            padding: 8px 6px;
            border-bottom: 1px solid #f5f5f5;
            vertical-align: middle;
        }

        .book-thumb {
            width: 32px;
            height: 42px;
            object-fit: cover;
            border-radius: 3px;
            border: 1px solid #ddd;
        }

        .badge-status-running {
            background-color: #5cb85c;
            color: white;
            padding: 2px 5px;
            border-radius: 3px;
            font-size: 10px;
            font-weight: 600;
        }
        .badge-status-stopped {
            background-color: #777;
            color: white;
            padding: 2px 5px;
            border-radius: 3px;
            font-size: 10px;
            font-weight: 600;
        }

        .action-icon {
            color: #333;
            text-decoration: none;
            font-size: 12px;
            cursor: pointer;
            border: none;
            background: none;
            padding: 0 3px;
        }
        .action-icon:hover {
            color: #3498db;
        }
        .action-icon.text-danger:hover {
            color: #d9534f !important;
        }

        .search-input-cf {
            border: 1px solid #ccc;
            border-radius: 3px;
            padding: 3px 8px;
            font-size: 12px;
            outline: none;
        }
    </style>
</head>
<body>

<%@include file="navbar.jsp" %>
        <%-- Breadcrumbs --%>
        <div class="breadcrumb-bar bg-white px-4 py-2 border-bottom mb-3 text-muted" style="font-size: 11px;">
            Home &gt; Admin Console &gt; Book Catalog Overview
        </div>

        <%-- Flash Messages --%>
        <%
            String succMsg = (String) session.getAttribute("succMsg");
            String failedMsg = (String) session.getAttribute("failedMsg");
        %>
        <% if (succMsg != null) { %>
            <div class="px-4 pt-2">
                <div class="alert alert-success alert-dismissible fade show py-2" role="alert">
                    <i class="fas fa-check-circle me-1"></i> <%= succMsg %>
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
            </div>
            <% session.removeAttribute("succMsg"); %>
        <% } %>
        <% if (failedMsg != null) { %>
            <div class="px-4 pt-2">
                <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                    <i class="fas fa-exclamation-triangle me-1"></i> <%= failedMsg %>
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
            </div>
            <% session.removeAttribute("failedMsg"); %>
        <% } %>

        <%-- Data Processing --%>
        <%
            java.sql.Connection conn = DBconnect.getConn();
            if (conn == null) {
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            BookDAOImpl dao = new BookDAOImpl(conn);
            List<BookDtls> list = dao.getAllBooks();
        %>

        <%-- Content Body --%>
        <div class="content-body">
            
            <div class="page-title">
                <div>Catalog: Books Overview</div>
                <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="btn btn-success btn-sm text-white text-decoration-none" style="font-size: 11px;">
                    + Add New Book
                </a>
            </div>

            <%-- Main Table Panel --%>
            <div class="cf-card">
                <div class="cf-card-header">
                    <div class="cf-card-title">
                        Books Catalog <span class="badge-count"><%= list.size() %></span>
                    </div>
                    <div>
                        <input type="text" id="searchInput" class="search-input-cf" placeholder="Filter books..." onkeyup="filterTable()">
                    </div>
                </div>

                <table class="table-cf" id="bookTable">
                    <thead>
                        <tr>
                            <th style="width: 30px;">#</th>
                            <th style="width: 50px;">Cover</th>
                            <th>Book Title &amp; Author</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th style="text-align: right; padding-right: 12px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        int rowIdx = 1;
                        java.text.DecimalFormat fmt = new java.text.DecimalFormat("#,###");
                        for (BookDtls b : list) {
                            String photo = b.getPhotoName();
                            String imgSrc = (photo != null && (photo.startsWith("http://") || photo.startsWith("https://")))
                                ? photo
                                : request.getContextPath() + "/book/" + photo;
                            boolean isActive = "Active".equalsIgnoreCase(b.getStatus());
                            String priceFormatted;
                            try { priceFormatted = fmt.format(Double.parseDouble(b.getPrice())); }
                            catch(Exception e2) { priceFormatted = b.getPrice(); }
                        %>
                        <tr>
                            <td class="text-muted"><%= rowIdx++ %></td>
                            <td>
                                <img src="<%= imgSrc %>" class="book-thumb" alt="<%= b.getBookName() %>"
                                     onerror="this.src='https://placehold.co/32x42?text=No+Img'">
                            </td>
                            <td>
                                <div class="fw-bold" style="color: #2c3e50;"><%= b.getBookName() %></div>
                                <div class="text-muted" style="font-size: 10px;"><%= b.getAuthor() %></div>
                            </td>
                            <td>
                                <span class="text-secondary" style="font-size: 11px;"><%= b.getBookCategory() %></span>
                            </td>
                            <td class="fw-bold">$<%= priceFormatted %></td>
                            <td>
                                <% if (isActive) { %>
                                    <span class="badge-status-running">Active</span>
                                <% } else { %>
                                    <span class="badge-status-stopped"><%= b.getStatus() %></span>
                                <% } %>
                            </td>
                            <td style="text-align: right; padding-right: 12px;">
                                <a href="${pageContext.request.contextPath}/admin/edit_books.jsp?id=<%= b.getBookId() %>" 
                                   class="action-icon me-2" title="Update Cover/Edit">
                                    <i class="fas fa-pencil-alt"></i>
                                </a>
                                <button type="button" class="action-icon text-danger" 
                                        onclick="showDeleteModal(<%= b.getBookId() %>)" title="Delete Book">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <% if (list.isEmpty()) { %>
                    <div class="text-center py-4">
                        <p class="text-muted mb-2">No books found in the catalog.</p>
                        <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="btn btn-outline-primary btn-sm py-1 px-3" style="font-size: 11px;">
                            Add First Book
                        </a>
                    </div>
                <% } %>
            </div>

        </div>
    </div>
</div>

<%-- Delete Confirmation Modal --%>
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
            <div class="modal-body text-center p-3">
                <i class="fas fa-exclamation-circle text-danger mb-2" style="font-size: 2rem;"></i>
                <h6 class="fw-bold">Delete this book?</h6>
                <p class="text-muted" style="font-size: 11px;">This record will be permanently deleted.</p>
                <div class="d-flex justify-content-center gap-2 mt-3">
                    <button class="btn btn-light btn-sm px-3" data-bs-dismiss="modal" style="font-size: 11px;">Cancel</button>
                    <a href="#" id="confirmDeleteBtn" class="btn btn-danger btn-sm px-3" style="font-size: 11px;">
                        Delete
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function showDeleteModal(bookId) {
        document.getElementById('confirmDeleteBtn').href =
            '${pageContext.request.contextPath}/admin/deleteBook?id=' + bookId;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }

    function filterTable() {
        const query = document.getElementById('searchInput').value.toLowerCase();
        document.querySelectorAll('#bookTable tbody tr').forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(query) ? '' : 'none';
        });
    }
</script>

</body>
</html>
