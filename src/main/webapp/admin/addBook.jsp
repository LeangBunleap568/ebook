<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App - Add Book</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        .custom-card {
            border: 1px solid rgba(0, 0, 0, 0.08) !important;
            border-radius: 8px !important;
        }
        .preview-box {
            width: 100px;
            height: 130px;
            border: 2px dashed #dee2e6;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
            overflow: hidden;
            position: relative;
        }
        .preview-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>
<body class="bg-light">

    <%@include file="../component/navbar.jsp" %>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card custom-card shadow-sm p-4 bg-white">
                    <h3 class="text-center fw-bold text-dark mb-4">
                        <i class="fas fa-plus-circle text-primary me-2"></i>Add New Book
                    </h3>

                    <!-- Dynamic Session Notifications -->
                    <c:if test="${not empty succMsg}">
                        <div class="alert alert-success alert-dismissible fade show rounded-1 text-center fw-semibold mb-3" role="alert">
                            <i class="fas fa-check-circle me-1"></i> ${succMsg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="succMsg" scope="session"/>
                    </c:if>

                    <c:if test="${not empty failedMsg}">
                        <div class="alert alert-danger alert-dismissible fade show rounded-1 text-center fw-semibold mb-3" role="alert">
                            <i class="fas fa-exclamation-triangle me-1"></i> ${failedMsg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="failedMsg" scope="session"/>
                    </c:if>

                    <!-- Client-Side JavaScript Validation Alert -->
                    <div id="errorMsg" class="alert alert-warning rounded-1 d-none text-center fw-semibold py-2 mb-3" role="alert"></div>

                    <form action="../addBooks" method="post" enctype="multipart/form-data" onsubmit="return validateBookForm()">
                        
                        <!-- 1. Book Details -->
                        <div class="mb-4">
                            <h5 class="fw-bold text-secondary border-bottom pb-2 mb-3">1. Book Information</h5>
                            
                            <div class="row">
                                <!-- Book Name -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Book Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control rounded-1" name="bname" placeholder="Enter book title" required>
                                </div>

                                <!-- Author Name -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Author Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control rounded-1" name="author" placeholder="Enter author name" required>
                                </div>
                            </div>

                            <div class="row">
                                <!-- Price -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Price (៛ Riel) <span class="text-danger">*</span></label>
                                    <input type="number" step="100" min="10000" class="form-control rounded-1" id="bookPrice" name="price" placeholder="e.g. 10000" required>
                                </div>

                                <!-- Book Categories -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Book Category <span class="text-danger">*</span></label>
                                    <select class="form-select rounded-1" name="categories" required>
                                        <option value="" selected disabled>-- Select Category --</option>
                                        <option value="New">New Book</option>
                                        <option value="Recent">Recent Book</option>
                                        <option value="Old">Old Book</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <!-- Book Status -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Book Status <span class="text-danger">*</span></label>
                                    <select class="form-select rounded-1" name="status" required>
                                        <option value="" selected disabled>-- Select Status --</option>
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- 2. Image Upload -->
                        <div class="mb-4">
                            <h5 class="fw-bold text-secondary border-bottom pb-2 mb-3">2. Book Cover Image</h5>
                            
                            <div class="row align-items-center">
                                <div class="col-md-8 mb-3">
                                    <label class="form-label fw-bold small">Upload Cover Photo <span class="text-danger">*</span></label>
                                    <input type="file" class="form-control rounded-1" id="bookImgInput" name="bimg" accept="image/*" onchange="previewImage(event)" required>
                                    <div class="form-text small">Accepted formats: JPG, PNG, WEBP.</div>
                                </div>
                                <div class="col-md-4 text-center mb-3">
                                    <label class="form-label fw-bold small d-block mb-2">Preview</label>
                                    <div class="preview-box mx-auto">
                                        <div id="emptyPreview" class="text-muted small text-center p-2">
                                            <i class="fas fa-image fa-2x d-block mb-1 text-secondary opacity-50"></i>
                                            <span>No Cover Selected</span>
                                        </div>
                                        <img id="imgPreview" src="" alt="Book Cover Preview" class="d-none">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-end gap-2">
                            <a href="allBook.jsp" class="btn btn-outline-secondary rounded-1 px-4 fw-semibold">Cancel</a>
                            <button type="submit" class="btn btn-primary rounded-1 px-4 fw-semibold">
                                <i class="fas fa-plus me-1"></i> Add Book
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function previewImage(event) {
            var reader = new FileReader();
            var output = document.getElementById('imgPreview');
            var emptyBox = document.getElementById('emptyPreview');

            reader.onload = function(){
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
            var priceInput = document.getElementById("bookPrice").value;
            var price = parseFloat(priceInput);
            var imgInput = document.getElementById("bookImgInput");
            var errorBox = document.getElementById("errorMsg");

            errorBox.classList.add("d-none");
            errorBox.innerText = "";

            if (isNaN(price) || price < 10000) {
                errorBox.innerText = "Price must be at least 10,000 Riel!";
                errorBox.classList.remove("d-none");
                return false;
            }

            if (imgInput.files.length === 0) {
                errorBox.innerText = "Please select a book cover image!";
                errorBox.classList.remove("d-none");
                return false;
            }

            return true;
        }
    </script>

    <%@include file="../component/footer.jsp" %>

</body>
</html>