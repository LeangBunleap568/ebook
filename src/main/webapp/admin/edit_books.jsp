<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.ebook.dao.impl.BookDAOImpl"%>
<%@ page import="com.ebook.db.DBconnect"%>
<%@ page import="com.ebook.entity.BookDtls"%>

<%-- Data Retrieval --%>
<%
    String idParam = request.getParameter("id");
    BookDtls book = null;
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);
            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
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
        body {
            background-color: #eaeded;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }
        /* Top Navigation Header */
        .top-navbar {
            background-color: #343a40;
            color: #fff;
            height: 50px;
        }
        .brand-box {
            background-color: #f0ad4e;
            color: #fff;
            width: 220px;
            font-weight: bold;
            font-size: 1.1rem;
        }
        /* Sidebar Navigation */
        .sidebar {
            width: 220px;
            min-height: calc(100vh - 50px);
            background-color: #2c3e50;
        }
        .sidebar-section {
            color: #8a98a5;
            font-size: 0.8rem;
            text-transform: uppercase;
            padding: 12px 20px 4px;
        }
        .sidebar-link {
            color: #bdc3c7;
            padding: 10px 20px;
            display: block;
            text-decoration: none;
            font-size: 0.9rem;
        }
        .sidebar-link:hover, .sidebar-link.active {
            background-color: #1a252f;
            color: #fff;
        }
        /* Content Area */
        .main-content {
            flex: 1;
            padding: 20px 30px;
        }
        .breadcrumb-text {
            color: #7f8c8d;
            font-size: 0.85rem;
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

    <!-- Top Horizontal Navigation -->
    <div class="top-navbar d-flex align-items-center justify-content-between px-0">
        <div class="d-flex align-items-center h-100">
            <div class="brand-box d-flex align-items-center px-3 h-100">
                Ebook Admin
            </div>
            <button class="btn btn-link text-white ms-2"><i class="fas fa-bars"></i></button>
        </div>
        <div class="pe-3 text-white">
            <i class="fas fa-user-circle fa-lg"></i>
        </div>
    </div>

    <div class="d-flex">
        
        <!-- Left Sidebar -->
        <div class="sidebar">
            <div class="sidebar-section">Store Management</div>
            <a href="${pageContext.request.contextPath}/admin/home.jsp" class="sidebar-link">
                <i class="fas fa-tachometer-alt me-2"></i> Overview
            </a>
            <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="sidebar-link active">
                <i class="fas fa-book me-2"></i> Books Inventory
            </a>
            <a href="${pageContext.request.contextPath}/admin/addBook.jsp" class="sidebar-link">
                <i class="fas fa-plus-circle me-2"></i> Add Book
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="sidebar-link">
                <i class="fas fa-shopping-cart me-2"></i> Orders
            </a>
        </div>

        <!-- Main Workspace -->
        <div class="main-content">
            
            <!-- Breadcrumb Navigation -->
            <div class="breadcrumb-text mb-2">
                Home &gt; Books &gt; Edit Details
            </div>

            <!-- Header Section -->
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h2 class="page-title mb-0">Book: ${not empty book ? book.bookName : 'Not Found'}</h2>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="btn btn-sm btn-outline-secondary">
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
                                    <form action="${pageContext.request.contextPath}/admin/updateBook" method="post">
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
                                                <label class="form-label small fw-bold text-secondary">Price (៛ Riel)</label>
                                                <input type="number" step="100" class="form-control form-control-sm" name="price" value="${book.price}" required>
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

    <%@include file="../component/footer.jsp" %>
</body>
</html>