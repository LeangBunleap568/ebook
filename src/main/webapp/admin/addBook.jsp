<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App - Add Book</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">

    <%@include file="../component/navbar.jsp" %>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-0 rounded-0 shadow-sm p-4 bg-white">
                    <h3 class="text-center fw-bold mb-4">Add New Book</h3>

                    <!-- Red error text container for validation -->
                    <div id="errorMsg" class="alert alert-danger rounded-0 d-none text-center fw-bold py-2 mb-3" role="alert"></div>

                    <form action="../addBooks" method="post" enctype="multipart/form-data" onsubmit="return validateBookForm()">
                        
                        <!-- 1. Book Details -->
                        <div class="mb-4">
                            <h5 class="fw-bold text-secondary border-bottom pb-2 mb-3">1. Book Information</h5>
                            
                            <div class="row">
                                <!-- Book Name -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Book Name</label>
                                    <input type="text" class="form-control rounded-0" name="bname" required>
                                </div>

                                <!-- Author Name -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Author Name</label>
                                    <input type="text" class="form-control rounded-0" name="author" required>
                                </div>
                            </div>

                            <div class="row">
                                <!-- Price -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Price (៛ Riel)</label>
                                    <input type="number" step="100" min="10000" class="form-control rounded-0" id="bookPrice" name="price" placeholder="e.g. 10000" required>
                                </div>

                                <!-- Book Categories -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Book Category</label>
                                    <select class="form-select rounded-0" name="categories" required>
                                        <option value="" selected disabled>--Select Category--</option>
                                        <option value="New">New Book</option>
                                        <option value="Recent">Recent Book</option>
                                        <option value="Old">Old Book</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <!-- Book Status -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Book Status</label>
                                    <select class="form-select rounded-0" name="status" required>
                                        <option value="" selected disabled>--Select Status--</option>
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
                                    <label class="form-label fw-bold small">Upload Cover Photo</label>
                                    <input type="file" class="form-control rounded-0" id="bookImgInput" name="bimg" accept="image/*" onchange="previewImage(event)" required>
                                </div>
                                <div class="col-md-4 text-center mb-3">
                                    <div class="border p-1 bg-light d-inline-block">
                                        <img id="imgPreview" src="https://via.placeholder.com/100x130?text=Preview" alt="Book Cover Preview" style="width: 90px; height: 120px; object-fit: cover;">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-dark rounded-0 py-2 fw-bold">Add Book</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function(){
                var output = document.getElementById('imgPreview');
                output.src = reader.result;
            };
            if(event.target.files[0]) {
                reader.readAsDataURL(event.target.files[0]);
            }
        }

        function validateBookForm() {
            var priceInput = document.getElementById("bookPrice").value;
            var price = parseFloat(priceInput);
            var imgInput = document.getElementById("bookImgInput");
            var errorBox = document.getElementById("errorMsg");

            // Hide error message initially
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