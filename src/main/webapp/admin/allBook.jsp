<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.dao.impl.BookDAOImpl" %>
<%@ page import="com.ebook.db.DBconnect" %>
<%@ page import="com.ebook.entity.BookDtls" %>
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
    <title>Admin — Book Inventory</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .admin-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            padding: 0 28px; height: 64px;
            display: flex; align-items: center; justify-content: space-between;
            box-shadow: 0 4px 16px rgba(0,0,0,0.18);
            position: sticky; top: 0; z-index: 100;
        }
        .admin-header .brand { color: #fff; font-size: 1.15rem; font-weight: 700; }
        .admin-header .brand span { opacity: 0.65; font-weight: 400; font-size: 0.88rem; }
        .nav-link-pill {
            background: rgba(255,255,255,0.12); border: 1px solid rgba(255,255,255,0.2);
            color: #fff; padding: 5px 15px; border-radius: 50px;
            font-size: 12px; font-weight: 500; text-decoration: none; transition: all 0.2s;
        }
        .nav-link-pill:hover { background: rgba(255,255,255,0.25); color: #fff; }
        .nav-link-pill.active { background: rgba(255,255,255,0.3); font-weight: 700; }
        .logout-btn {
            background: rgba(231,74,59,0.8); border: 1px solid rgba(255,255,255,0.2);
            color: #fff; border-radius: 50px; padding: 5px 16px;
            font-size: 12px; text-decoration: none; transition: all 0.2s;
        }
        .logout-btn:hover { background: #e74a3b; color: #fff; }
        .avatar {
            width: 36px; height: 36px; border-radius: 50%;
            background: rgba(255,255,255,0.2); display: flex;
            align-items: center; justify-content: center; color: #fff; font-size: 15px;
            border: 2px solid rgba(255,255,255,0.3);
        }
        .inventory-card { border: none; border-radius: 16px; box-shadow: 0 4px 18px rgba(0,0,0,0.07); }
        .book-thumb { width: 44px; height: 58px; object-fit: cover; border-radius: 6px; box-shadow: 0 2px 6px rgba(0,0,0,0.12); }
        .badge-category { font-size: 11px; padding: 4px 10px; border-radius: 50px; font-weight: 600; }
        .btn-action { padding: 4px 12px; font-size: 12px; border-radius: 50px !important; font-weight: 500; }
        .search-bar { border-radius: 50px; border: 1px solid #dee2e6; padding-left: 16px; }
    </style>
</head>
<body>

   <c:set var="activePage" value="all_books" scope="request" />
<%@include file="../component/navbar.jsp" %>

    <%-- Flash Messages --%>
    <%
        String succMsg = (String) session.getAttribute("succMsg");
        String failedMsg = (String) session.getAttribute("failedMsg");
    %>
    <% if (succMsg != null) { %>
        <div class="container-fluid px-4 pt-3">
            <div class="alert alert-success alert-dismissible fade show shadow-sm">
                <i class="fas fa-check-circle me-1"></i> <%= succMsg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
        <% session.removeAttribute("succMsg"); %>
    <% } %>
    <% if (failedMsg != null) { %>
        <div class="container-fluid px-4 pt-3">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm">
                <i class="fas fa-exclamation-triangle me-1"></i> <%= failedMsg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
        <% session.removeAttribute("failedMsg"); %>
    <% } %>

    <div class="container-fluid px-4 py-4">

        <%-- Header Row --%>
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-0">
                    <i class="fas fa-book-open text-success me-2"></i>Book Inventory
                </h4>
                <%
                    BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
                    List<BookDtls> list = dao.getAllBooks();
                %>
                <small class="text-muted"><%= list.size() %> book(s) in catalog</small>
            </div>
            <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="btn btn-primary rounded-pill px-4 fw-semibold">
                <i class="fas fa-plus me-1"></i> Add New Book
            </a>
        </div>

        <%-- Table Card --%>
        <div class="card inventory-card">
            <div class="card-header bg-white border-bottom d-flex align-items-center justify-content-between py-3">
                <span class="fw-bold text-dark"><i class="fas fa-table text-primary me-2"></i>All Books</span>
                <input type="text" id="searchInput" class="form-control form-control-sm search-bar"
                       style="max-width:240px;" placeholder="🔍  Search books…" onkeyup="filterTable()">
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="bookTable">
                    <thead class="table-light">
                        <tr class="text-muted small text-uppercase fw-bold">
                            <th class="ps-4">#</th>
                            <th>Cover</th>
                            <th>Title &amp; Author</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th class="text-center pe-4">Actions</th>
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
                            <td class="ps-4 text-muted small"><%= rowIdx++ %></td>
                            <td>
                                <img src="<%= imgSrc %>" class="book-thumb" alt="<%= b.getBookName() %>"
                                     onerror="this.src='https://placehold.co/44x58?text=No+Img'">
                            </td>
                            <td>
                                <div class="fw-bold text-dark"><%= b.getBookName() %></div>
                                <div class="text-muted small"><i class="fas fa-user-edit me-1 opacity-50"></i><%= b.getAuthor() %></div>
                            </td>
                            <td>
                                <%
                                    String cat = b.getBookCategory();
                                    String catColor = "Recent".equals(cat) ? "bg-primary-subtle text-primary"
                                                    : "New".equals(cat)    ? "bg-success-subtle text-success"
                                                    : "bg-secondary-subtle text-secondary";
                                %>
                                <span class="badge badge-category <%= catColor %>"><%= cat %></span>
                            </td>
                            <td class="fw-bold text-dark"><%= priceFormatted %> ៛</td>
                            <td>
                                <span class="badge rounded-pill <%= isActive ? "bg-success" : "bg-secondary" %> px-3 py-1">
                                    <i class="fas fa-circle me-1" style="font-size:7px;"></i><%= b.getStatus() %>
                                </span>
                            </td>
                            <td class="text-center pe-4">
                                <a href="${pageContext.request.contextPath}/admin/edit_books.jsp?id=<%= b.getBookId() %>"
                                   class="btn btn-sm btn-outline-info btn-action me-1" title="Update Cover Image">
                                    <i class="fas fa-image me-1"></i>Cover
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/updateBook.jsp?id=<%= b.getBookId() %>"
                                   class="btn btn-sm btn-outline-primary btn-action me-1">
                                    <i class="fas fa-edit me-1"></i>Edit
                                </a>
                                <button type="button" class="btn btn-sm btn-outline-danger btn-action"
                                        onclick="showDeleteModal(<%= b.getBookId() %>)">
                                    <i class="fas fa-trash-alt me-1"></i>Delete
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% if (list.isEmpty()) { %>
                <div class="text-center py-5 text-muted">
                    <i class="fas fa-inbox fa-3x mb-3"></i>
                    <p class="fw-semibold">No books found in the catalog.</p>
                    <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="btn btn-primary btn-sm rounded-pill px-4">
                        <i class="fas fa-plus me-1"></i> Add First Book
                    </a>
                </div>
            <% } %>
        </div>
    </div>

    <%-- Delete Modal --%>
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="modal-body p-5 text-center">
                    <div class="d-inline-flex align-items-center justify-content-center bg-danger-subtle text-danger rounded-circle mb-4"
                         style="width:72px;height:72px;">
                        <i class="fas fa-exclamation-triangle fa-2x"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Delete this book?</h5>
                    <p class="text-muted mb-4">This action is permanent and cannot be undone.</p>
                    <div class="d-flex justify-content-center gap-3">
                        <button class="btn btn-light px-4 fw-semibold rounded-pill" data-bs-dismiss="modal">Cancel</button>
                        <a href="#" id="confirmDeleteBtn" class="btn btn-danger px-4 fw-semibold rounded-pill">
                            <i class="fas fa-trash-alt me-1"></i> Yes, Delete
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

    <%@include file="../component/footer.jsp" %>
</body>
</html>

