<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.app.dao.impl.BookDAOImpl"%>
<%@ page import="com.app.db.DBconnect"%>
<%@ page import="com.app.entity.BookDtls"%>

<%-- Data Retrieval --%>
<%
    String idParam = request.getParameter("id");
    BookDtls book = null;
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);
            java.sql.Connection conn = DBconnect.getConn();
            if (conn == null) {
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            BookDAOImpl dao = new BookDAOImpl(conn);
            book = dao.getBookById(id);
        } catch (Exception e) {
            book = null;
        }
    }
    request.setAttribute("book", book);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — Edit Book</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        .content-body {
            padding: 0 20px 20px 20px;
        }

        .page-title {
            font-size: 1.6rem;
            color: #2c3e50;
            font-weight: 400;
        }
        /* Card Containers */
        .ui-card {
            background: #ffffff;
            border: 1px solid #dcdcdc;
            border-radius: 3px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        .ui-card-header {
            padding: 12px 15px;
            border-bottom: 1px solid #eeeeee;
            font-weight: 600;
            font-size: 1rem;
            color: #333;
        }
        .counter-badge {
            background-color: #777;
            color: #fff;
            font-size: 0.75rem;
            padding: 2px 6px;
            border-radius: 3px;
            margin-left: 6px;
        }
        .status-pill {
            font-size: 0.75rem;
            font-weight: 600;
            padding: 3px 8px;
            border-radius: 3px;
            text-transform: lowercase;
        }
        .status-pill.active {
            background-color: #5cb85c;
            color: white;
        }
        .status-pill.inactive {
            background-color: #d9534f;
            color: white;
        }
    </style>
</head>
<body>

    <%-- Security Check --%>
    <c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
        <c:redirect url="../login.jsp" />
    </c:if>

<%@include file="navbar.jsp" %>

<main class="admin-main">
        <!-- Breadcrumb Navigation -->
        <div class="breadcrumb-text mb-2 bg-white px-4 py-2 border-bottom">
            Home &gt; Books &gt; Edit Details
        </div>
        <div class="content-body">

            <!-- Header Section -->
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h2 class="page-title mb-0">Book: ${not empty book ? book.bookName : 'Not Found'}</h2>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/admin/all_books.jsp" class="btn btn-sm btn-outline-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Catalog
                    </a>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty book}">
                    <div class="row">
                        
                        <!-- Main Left Column: Editable Details Form -->
                        <div class="col-lg-7">
                            <div class="ui-card">
                                <div class="ui-card-header d-flex align-items-center">
                                    <span>Edit Details</span>
                                    <span class="counter-badge">ID ${book.bookId}</span>
                                </div>
                                <div class="p-3">
                                    <form action="${pageContext.request.contextPath}/admin/updateBook" method="post" onsubmit="return validateEditBookForm()">
                                        <div id="editPriceError" class="alert alert-warning d-none mb-3 py-2 px-3" style="font-size: 12px;"></div>
                                        <input type="hidden" name="id" value="${book.bookId}">

                                        <div class="mb-3">
                                            <label class="form-label small fw-bold text-secondary">Book Title</label>
                                            <input type="text" class="form-control form-control-sm" name="bname" value="${book.bookName}" required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label small fw-bold text-secondary">Author</label>
                                            <input type="text" class="form-control form-control-sm" name="author" value="${book.author}" required>
                                        </div>

                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small fw-bold text-secondary">Price (USD)</label>
                                                <div class="input-group input-group-sm">
                                                    <span class="input-group-text">$</span>
                                                    <input type="number" step="0.01" min="2.50" id="editBookPrice" class="form-control" name="price" value="${book.price}" required>
                                                </div>
                                                <div class="text-muted mt-1" style="font-size: 10px;">Min: $2.50</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small fw-bold text-secondary">Status</label>
                                                <select class="form-select form-select-sm" name="status">
                                                    <option value="Active" ${book.status == 'Active' ? 'selected' : ''}>Active</option>
                                                    <option value="Inactive" ${book.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="pt-2 text-end">
                                            <button type="submit" class="btn btn-success btn-sm px-3 fw-bold">
                                                <i class="fas fa-check me-1"></i> Update Properties
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Right Column: Media & Actions Side Panel -->
                        <div class="col-lg-5">
                            
                            <!-- Cover Preview Card -->
                            <div class="ui-card">
                                <div class="ui-card-header d-flex justify-content-between align-items-center">
                                    <span>Cover Media</span>
                                    <a href="${pageContext.request.contextPath}/admin/edit_cover.jsp?id=${book.bookId}" class="btn btn-success btn-sm py-0 px-2 fs-7">
                                        + Change Image
                                    </a>
                                </div>
                                <div class="p-3 text-center">
                                    <c:choose>
                                        <c:when test="${not empty book.photoName}">
                                            <img src="${pageContext.request.contextPath}/book/${book.photoName}" class="img-fluid border rounded" style="max-height: 180px;" alt="Book Cover">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="p-4 bg-light text-muted border rounded">No image attached</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Attribute Table Card -->
                            <div class="ui-card">
                                <div class="ui-card-header">
                                    <span>System Meta</span>
                                </div>
                                <div class="p-0">
                                    <table class="table table-sm table-borderless mb-0 align-middle">
                                        <thead class="bg-light border-bottom">
                                            <tr class="text-secondary small">
                                                <th class="ps-3">Field</th>
                                                <th>Value</th>
                                                <th class="text-end pe-3">State</th>
                                            </tr>
                                        </thead>
                                        <tbody class="small">
                                            <tr class="border-bottom">
                                                <td class="ps-3 fw-bold">System ID</td>
                                                <td>#${book.bookId}</td>
                                                <td class="text-end pe-3"><i class="fas fa-eye text-muted"></i></td>
                                            </tr>
                                            <tr>
                                                <td class="ps-3 fw-bold">Visibility</td>
                                                <td>
                                                    <span class="status-pill ${book.status == 'Active' ? 'active' : 'inactive'}">
                                                        ${book.status}
                                                    </span>
                                                </td>
                                                <td class="text-end pe-3"><i class="fas fa-cog text-muted"></i></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>

                    </div>
                </c:when>

                <%-- Fallback State --%>
                <c:otherwise>
                    <div class="ui-card p-5 text-center">
                        <i class="fas fa-exclamation-circle fa-3x text-warning mb-3"></i>
                        <h5>Book Not Found</h5>
                        <p class="text-muted small">Could not retrieve book details for ID: <code>${param.id}</code></p>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

</main>

    <%@include file="footer.jsp" %>

<script>
    function validateEditBookForm() {
        const priceInput = document.getElementById('editBookPrice');
        const errorBox   = document.getElementById('editPriceError');
        if (!priceInput) return true;
        const price = parseFloat(priceInput.value);
        errorBox.classList.add('d-none');
        errorBox.innerText = '';
        if (isNaN(price) || price < 2.50) {
            errorBox.innerText = '⚠️ Price must be at least $2.50 USD!';
            errorBox.classList.remove('d-none');
            priceInput.focus();
            return false;
        }
        return true;
    }
</script>

</body>
</html>
