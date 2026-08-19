<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%-- Security Check --%>
<c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
    <c:redirect url="../login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ebook App — Add New Book</title>
<%@include file="../component/rootCss.jsp" %>
<style>
    :root {
        --sidebar-bg: #2c3846;
        --sidebar-active: #232d38;
        --brand-bg: #f39c12;
        --topbar-bg: #34495e;
        --body-bg: #eaedf1;
    }

    body {
        background-color: var(--body-bg);
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
        margin: 0;
        padding: 0;
        font-size: 13px;
        color: #333;
    }

    /* Layout Structure */
    .app-wrapper {
        display: flex;
        min-height: 100vh;
    }

    /* Sidebar Navigation */
    .sidebar {
        width: 220px;
        background-color: var(--sidebar-bg);
        color: #95a5a6;
        flex-shrink: 0;
    }
    .sidebar .brand-header {
        background-color: var(--brand-bg);
        color: #fff;
        padding: 14px 20px;
        font-size: 16px;
        font-weight: 600;
    }
    .sidebar .nav-section {
        padding: 10px 0;
    }
    .sidebar .nav-item-title {
        padding: 8px 20px;
        color: #bdc3c7;
        font-weight: 500;
    }
    .sidebar .nav-link-custom {
        display: block;
        padding: 8px 20px 8px 30px;
        color: #95a5a6;
        text-decoration: none;
        transition: all 0.2s;
    }
    .sidebar .nav-link-custom:hover {
        color: #fff;
        background: rgba(255,255,255,0.05);
    }
    .sidebar .nav-link-custom.active {
        color: #fff;
        background-color: var(--sidebar-active);
    }

    /* Main Content Area */
    .main-container {
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    /* Top Bar */
    .top-navbar {
        height: 48px;
        background-color: var(--topbar-bg);
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 20px;
        color: #fff;
    }

    /* Breadcrumbs */
    .breadcrumb-bar {
        padding: 10px 20px;
        font-size: 11px;
        color: #7f8c8d;
    }

    /* Inner Content */
    .content-body {
        padding: 0 20px 20px 20px;
    }

    .page-title {
        font-size: 18px;
        font-weight: 500;
        margin-bottom: 15px;
        color: #2c3e50;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    /* CF Cards & Panels */
    .cf-card {
        background: #fff;
        border-radius: 4px;
        border: 1px solid #dcdcdc;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        padding: 20px;
        margin-bottom: 15px;
    }
    .cf-card-title {
        font-size: 13px;
        font-weight: 600;
        color: #2c3e50;
        border-bottom: 1px solid #eee;
        padding-bottom: 8px;
        margin-bottom: 16px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    /* Image Preview Frame */
    .preview-box {
        width: 110px;
        height: 145px;
        border: 2px dashed #bdc3c7;
        border-radius: 4px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #fafafa;
        overflow: hidden;
    }
    .preview-box img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .form-label {
        font-size: 12px;
        font-weight: 600;
        color: #444;
        margin-bottom: 4px;
    }
    .form-control, .form-select {
        font-size: 12px;
        border-radius: 3px;
    }
</style>
</head>
<body>

<div class="app-wrapper">

    <%-- Sidebar Navigation --%>
    <div class="sidebar">
        <div class="brand-header">
            Ebook Admin
        </div>
        <div class="nav-section">
            <div class="nav-item-title">System Overview</div>
            <a href="${pageContext.request.contextPath}/admin/home.jsp" class="nav-link-custom">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="nav-link-custom">Book Catalog</a>
            <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="nav-link-custom">Order Requests</a>
            <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="nav-link-custom active">Management</a>
        </div>
    </div>

    <%-- Main Content Container --%>
    <div class="main-container">

        <%-- Top Navbar --%>
        <div class="top-navbar">
            <div><i class="fas fa-bars cursor-pointer"></i></div>
            <div>
                <a href="${pageContext.request.contextPath}/logout" class="text-white text-decoration-none" title="Logout">
                    <i class="fas fa-user me-1"></i> Admin Exit
                </a>
            </div>
        </div>

        <%-- Breadcrumbs --%>
        <div class="breadcrumb-bar">
            Home &gt; Admin Console &gt; Management &gt; Add Book
        </div>

        <%-- Content Body --%>
        <div class="content-body">

            <%-- Flash Notifications --%>
            <c:if test="${not empty succMsg}">
                <div class="alert alert-success alert-dismissible fade show mb-3 py-2 px-3 style="font-size: 12px;" role="alert">
                    <i class="fas fa-check-circle me-1"></i> ${succMsg}
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="succMsg" scope="session"/>
            </c:if>

            <c:if test="${not empty failedMsg}">
                <div class="alert alert-danger alert-dismissible fade show mb-3 py-2 px-3 style="font-size: 12px;" role="alert">
                    <i class="fas fa-exclamation-triangle me-1"></i> ${failedMsg}
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="failedMsg" scope="session"/>
            </c:if>

            <%-- Page Header --%>
            <div class="page-title">
                <div class="d-flex align-items-center gap-2">
                    <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="btn btn-outline-secondary btn-sm py-1 px-2" style="font-size: 11px;">
                        &larr; Back
                    </a>
                    <span>Add New Catalog Entry</span>
                </div>
            </div>

            <%-- Form Container --%>
            <div class="cf-card" style="max-width: 800px;">

                <%-- Client JS Validation Error Alert --%>
                <div id="errorMsg" class="alert alert-warning d-none mb-3 py-2 px-3" style="font-size: 12px;" role="alert"></div>

                <form action="${pageContext.request.contextPath}/addBooks" method="post" enctype="multipart/form-data" onsubmit="return validateBookForm()">

                    <%-- Section 1: Book Info --%>
                    <div class="cf-card-title">
                        <i class="fas fa-book text-secondary"></i> 1. Book Details
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label">Book Title <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="bname" placeholder="Enter book title" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Author Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="author" placeholder="Enter author name" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Price (៛ Riel) <span class="text-danger">*</span></label>
                            <div class="input-group input-group-sm">
                                <span class="input-group-text">៛</span>
                                <input type="number" step="100" min="10000" class="form-control" id="bookPrice"
                                       name="price" placeholder="e.g. 10000" required>
                            </div>
                            <div class="text-muted mt-1" style="font-size: 10px;">Minimum 10,000 ៛</div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Category <span class="text-danger">*</span></label>
                            <select class="form-select form-select-sm" name="categories" required>
                                <option value="" selected disabled>— Select Category —</option>
                                <option value="New">New Book</option>
                                <option value="Recent">Recent Book</option>
                                <option value="Old">Old Book</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Catalog Status <span class="text-danger">*</span></label>
                            <select class="form-select form-select-sm" name="status" required>
                                <option value="" selected disabled>— Select Status —</option>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </div>

                    <%-- Section 2: Cover Image --%>
                    <div class="cf-card-title">
                        <i class="fas fa-image text-secondary"></i> 2. Media & Assets
                    </div>

                    <div class="row align-items-center g-3 mb-4">
                        <div class="col-md-8">
                            <label class="form-label">Upload Cover Image <span class="text-danger">*</span></label>
                            <input type="file" class="form-control form-control-sm" id="bookImgInput" name="bimg"
                                   accept="image/*" onchange="previewImage(event)" required>
                            <div class="text-muted mt-1" style="font-size: 10px;">Supported formats: JPG, PNG, WEBP — Max 5MB</div>
                        </div>
                        <div class="col-md-4 text-center">
                            <label class="form-label d-block mb-1">Asset Preview</label>
                            <div class="preview-box mx-auto">
                                <div id="emptyPreview" class="text-muted small p-2 text-center">
                                    <i class="fas fa-image fa-2x d-block mb-1 text-secondary opacity-50"></i>
                                    No Image
                                </div>
                                <img id="imgPreview" src="" alt="Preview" class="d-none">
                            </div>
                        </div>
                    </div>

                    <%-- Actions --%>
                    <div class="d-flex justify-content-end gap-2 border-top pt-3">
                        <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="btn btn-outline-secondary btn-sm px-3">
                            Cancel
                        </a>
                        <button type="submit" class="btn btn-primary btn-sm px-4 fw-bold" style="background-color: var(--brand-bg); border-color: var(--brand-bg);">
                            <i class="fas fa-plus me-1"></i> Save to Inventory
                        </button>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>

<script>
    function previewImage(event) {
        const reader = new FileReader();
        const output = document.getElementById('imgPreview');
        const emptyBox = document.getElementById('emptyPreview');
        reader.onload = function() {
            output.src = reader.result;
            output.classList.remove('d-none');
            emptyBox.classList.add('d-none');
        };
        if (event.target.files && event.target.files[0]) {
            reader.readAsDataURL(event.target.files[0]);
        } else {
            output.classList.add('d-none');
            emptyBox.classList.remove('d-none');
        }
    }

    function validateBookForm() {
        const price = parseFloat(document.getElementById('bookPrice').value);
        const imgInput = document.getElementById('bookImgInput');
        const errorBox = document.getElementById('errorMsg');
        errorBox.classList.add('d-none');
        errorBox.innerText = '';

        if (isNaN(price) || price < 10000) {
            errorBox.innerText = '⚠️ Price must be at least 10,000 ៛ Riel!';
            errorBox.classList.remove('d-none');
            window.scrollTo({ top: 0, behavior: 'smooth' });
            return false;
        }
        if (imgInput.files.length === 0) {
            errorBox.innerText = '⚠️ Please select a book cover image!';
            errorBox.classList.remove('d-none');
            return false;
        }
        return true;
    }
</script>

</body>
</html>