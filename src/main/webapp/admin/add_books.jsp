<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Security Check: ធានាថាមានតែ Admin ប៉ុណ្ណោះដែលអាចចូលមើលបាន --%>
<c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
    <c:redirect url="../login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin — Add Book</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        body { 
            background: #f0f2f5; 
            font-family: 'Segoe UI', sans-serif; 
        }

        .form-card {
            border: none; 
            border-radius: 16px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.07); 
            background: #fff;
        }

        .preview-box {
            width: 110px; 
            height: 145px; 
            border: 2px dashed #dee2e6;
            border-radius: 10px; 
            display: flex; 
            align-items: center;
            justify-content: center; 
            background: #f8f9fa; 
            overflow: hidden;
        }

        .preview-box img { 
            width: 100%; 
            height: 100%; 
            object-fit: cover; 
        }

        .section-title {
            font-size: 12px; 
            font-weight: 700; 
            text-transform: uppercase;
            letter-spacing: 0.8px; 
            color: #888; 
            border-bottom: 2px solid #f0f2f5;
            padding-bottom: 8px; 
            margin-bottom: 18px;
        }
    </style>
</head>
<body>

    <%-- កំណត់ activePage សម្រាប់ Highlight Link "Add Book" លើ Navbar --%>
    <c:set var="activePage" value="addBook" scope="request" />
    <%@include file="../component/navbar.jsp" %>

    <%-- Flash Messages (Success / Failed Alerts) --%>
    <c:if test="${not empty succMsg}">
        <div class="container-fluid px-4 pt-3">
            <div class="alert alert-success alert-dismissible fade show shadow-sm mb-0" role="alert">
                <i class="fas fa-check-circle me-1"></i> ${succMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
        <c:remove var="succMsg" scope="session"/>
    </c:if>

    <c:if test="${not empty failedMsg}">
        <div class="container-fluid px-4 pt-3">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-0" role="alert">
                <i class="fas fa-exclamation-triangle me-1"></i> ${failedMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
        <c:remove var="failedMsg" scope="session"/>
    </c:if>

    <div class="container py-4" style="max-width: 780px;">

        <%-- Page Header --%>
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-0">
                    <i class="fas fa-plus-circle text-primary me-2"></i>Add New Book
                </h4>
                <small class="text-muted">Fill in the details below to add a book to the catalog</small>
            </div>
            <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="btn btn-sm btn-outline-secondary rounded-pill px-3">
                <i class="fas fa-arrow-left me-1"></i> Back to Inventory
            </a>
        </div>

        <%-- Form Card --%>
        <div class="card form-card p-4">

            <%-- Client validation error box --%>
            <div id="errorMsg" class="alert alert-warning d-none mb-3" role="alert"></div>

            <form action="${pageContext.request.contextPath}/addBooks" method="post" enctype="multipart/form-data" onsubmit="return validateBookForm()">

                <%-- Section 1: Book Information --%>
                <p class="section-title">1 &nbsp; Book Information</p>
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Book Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control rounded-2" name="bname" placeholder="Enter book title" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Author Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control rounded-2" name="author" placeholder="Enter author name" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Price (៛ Riel) <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text">៛</span>
                            <input type="number" step="100" min="10000" class="form-control rounded-2" id="bookPrice"
                                   name="price" placeholder="e.g. 10000" required>
                        </div>
                        <div class="form-text">Minimum 10,000 ៛</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Book Category <span class="text-danger">*</span></label>
                        <select class="form-select rounded-2" name="categories" required>
                            <option value="" selected disabled>— Select Category —</option>
                            <option value="New">New Book</option>
                            <option value="Recent">Recent Book</option>
                            <option value="Old">Old Book</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Book Status <span class="text-danger">*</span></label>
                        <select class="form-select rounded-2" name="status" required>
                            <option value="" selected disabled>— Select Status —</option>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div>

                <%-- Section 2: Book Cover Image --%>
                <p class="section-title">2 &nbsp; Book Cover Image</p>
                <div class="row align-items-center g-3 mb-4">
                    <div class="col-md-8">
                        <label class="form-label fw-semibold small">Upload Cover Photo <span class="text-danger">*</span></label>
                        <input type="file" class="form-control rounded-2" id="bookImgInput" name="bimg"
                               accept="image/*" onchange="previewImage(event)" required>
                        <div class="form-text">Accepted: JPG, PNG, WEBP — max 5MB</div>
                    </div>
                    <div class="col-md-4 text-center">
                        <label class="form-label fw-semibold small d-block mb-2">Preview</label>
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
                    <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="btn btn-outline-secondary rounded-pill px-4">
                        Cancel
                    </a>
                    <button type="submit" class="btn btn-primary rounded-pill px-4 fw-semibold">
                        <i class="fas fa-plus me-1"></i> Add Book
                    </button>
                </div>

            </form>
        </div>
    </div>

    <%-- JavaScript Validations & Image Preview --%>
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

    <%@include file="../component/footer.jsp" %>
</body>
</html>

