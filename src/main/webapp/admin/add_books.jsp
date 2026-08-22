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
        .content-body {
            padding: 0 20px 20px 20px;
            max-width: 900px;
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
            padding: 20px 24px;
            margin-bottom: 15px;
        }
        
        .panel-section-title {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            margin-bottom: 16px;
            padding-bottom: 8px;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label {
            font-size: 12px;
            font-weight: 600;
            color: #444;
            margin-bottom: 4px;
        }

        .form-control, .form-select {
            font-size: 13px;
            border-radius: 3px;
            border: 1px solid #ccc;
        }

        .form-control:focus, .form-select:focus {
            border-color: #10b981;
            box-shadow: none;
        }

        /* Image Preview Box */
        .preview-box {
            width: 100px;
            height: 135px;
            border: 1px dashed #bdc3c7;
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

        /* Standard Buttons */
        .btn-classic-primary {
            background-color: #10b981;
            border-color: #10b981;
            color: #fff;
            font-weight: 600;
            font-size: 13px;
            padding: 6px 18px;
            border-radius: 4px;
        }

        .btn-classic-primary:hover {
            background-color: #0c9b6b;
            color: #fff;
        }
    </style>
</head>
<body>

<%@include file="navbar.jsp" %>

<main class="admin-main">
        <%-- Breadcrumbs --%>
        <div class="breadcrumb-bar bg-white px-4 py-2 border-bottom mb-3 text-muted" style="font-size: 11px;">
            Home &gt; Admin Console &gt; Management &gt; Add Book
        </div>

        <%-- Content Body --%>
        <div class="content-body">

            <%-- Flash Notifications --%>
            <c:if test="${not empty succMsg}">
                <div class="alert alert-success alert-dismissible fade show mb-3 py-2 px-3" style="font-size: 12px;" role="alert">
                    <i class="fas fa-check-circle me-1"></i> ${succMsg}
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="succMsg" scope="session"/>
            </c:if>

            <c:if test="${not empty failedMsg}">
                <div class="alert alert-danger alert-dismissible fade show mb-3 py-2 px-3" style="font-size: 12px;" role="alert">
                    <i class="fas fa-exclamation-triangle me-1"></i> ${failedMsg}
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="failedMsg" scope="session"/>
            </c:if>

            <%-- Page Header --%>
            <div class="page-title">
                <div>Add New Book to Inventory</div>
                <a href="${pageContext.request.contextPath}/admin/all_books.jsp" class="btn btn-outline-secondary btn-sm" style="font-size: 12px;">
                    &larr; Back to Catalog
                </a>
            </div>

            <%-- Form Card --%>
            <div class="cf-card">

                <%-- Client JS Validation Error Alert --%>
                <div id="errorMsg" class="alert alert-warning d-none mb-3 py-2 px-3" style="font-size: 12px;" role="alert"></div>

                <form id="addBookForm" action="${pageContext.request.contextPath}/admin/add_books" method="post" enctype="multipart/form-data" onsubmit="return validateBookForm()">

                    <%-- Section 1: Information --%>
                    <div class="panel-section-title">
                        <i class="fas fa-info-circle text-secondary"></i> Book Information
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label">Book Title <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-sm" name="bname" placeholder="Enter book title" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Author Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-sm" name="author" placeholder="Enter author name" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Price (USD) <span class="text-danger">*</span></label>
                            <div class="input-group input-group-sm">
                                <span class="input-group-text">$</span>
                                <input type="number" step="0.01" min="2.50" class="form-control" id="bookPrice" name="price" placeholder="2.50" required>
                            </div>
                            <div class="text-muted mt-1" style="font-size: 10px;">Min: $2.50</div>
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

                    <%-- Section 2: Image File --%>
                    <div class="panel-section-title">
                        <i class="fas fa-image text-secondary"></i> Cover Media
                    </div>

                    <div class="row align-items-center g-3 mb-4">
                        <div class="col-md-8">
                            <label class="form-label">Upload Book Cover Image <span class="text-danger">*</span></label>
                            <input type="file" class="form-control form-control-sm" id="bookImgInput" name="bimg" accept="image/*" onchange="previewImage(event)" required>
                            <div class="text-muted mt-1" style="font-size: 10px;">Formats: JPG, PNG, WEBP (Max 5MB)</div>
                        </div>
                        <div class="col-md-4 text-center">
                            <label class="form-label d-block mb-1">Preview</label>
                            <div class="preview-box mx-auto">
                                <div id="emptyPreview" class="text-muted small p-2 text-center">
                                    <i class="fas fa-image fa-2x d-block mb-1 text-secondary opacity-50"></i>
                                    No Image
                                </div>
                                <img id="imgPreview" src="" alt="Preview" class="d-none">
                            </div>
                        </div>
                    </div>

                    <%-- Action Buttons --%>
                    <div class="d-flex justify-content-end gap-2 border-top pt-3">
                        <a href="${pageContext.request.contextPath}/admin/all_books.jsp" class="btn btn-outline-secondary btn-sm px-3">
                            Cancel
                        </a>
                        <button type="submit" id="submitBtn" class="btn btn-classic-primary btn-sm px-4">
                            <i class="fas fa-plus me-1" id="submitIcon"></i>
                            <span class="spinner-border spinner-border-sm d-none" id="submitSpinner" role="status" aria-hidden="true"></span>
                            <span id="submitText">Save Book</span>
                        </button>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>

</main>

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

        if (isNaN(price) || price < 2.50) {
            errorBox.innerText = '⚠️ Price must be at least $2.50 USD!';
            errorBox.classList.remove('d-none');
            window.scrollTo({ top: 0, behavior: 'smooth' });
            return false;
        }
        if (imgInput.files.length === 0) {
            errorBox.innerText = '⚠️ Please select a book cover image!';
            errorBox.classList.remove('d-none');
            return false;
        }
        
        // Show loading spinner
        const submitBtn = document.getElementById('submitBtn');
        const submitIcon = document.getElementById('submitIcon');
        const submitSpinner = document.getElementById('submitSpinner');
        const submitText = document.getElementById('submitText');
        
        submitBtn.disabled = true;
        submitIcon.classList.add('d-none');
        submitSpinner.classList.remove('d-none');
        submitText.innerText = 'Saving...';

        return true;
    }
</script>

</body>
</html>
