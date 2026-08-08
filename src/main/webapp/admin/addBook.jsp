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

                    <form action="../addBooks" method="post" enctype="multipart/form-data">
                        
                        <!-- ផ្នែកទី១៖ ព័ត៌មានទូទៅរបស់សៀវភៅ (General Book Details) -->
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
                                <!-- Price in Riel -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Price (៛ Riel)</label>
                                    <input type="number" step="100" class="form-control rounded-0" name="price" placeholder="e.g. 10000" required>
                                </div>

                                <!-- Book Categories -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Book Category</label>
                                    <select class="form-select rounded-0" name="categories">
                                        <option selected disabled>--Select Category--</option>
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
                                    <select class="form-select rounded-0" name="status">
                                        <option selected disabled>--Select Status--</option>
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- ផ្នែកទី២៖ អప్‌ឡូដរូបភាពមាន ONCHANGE Input (Image Upload with Preview) -->
                        <div class="mb-4">
                            <h5 class="fw-bold text-secondary border-bottom pb-2 mb-3">2. Book Cover Image</h5>
                            
                            <div class="row align-items-center">
                                <div class="col-md-8 mb-3">
                                    <label class="form-label fw-bold small">Upload Cover Photo</label>
                                    <!-- ដាក់ព្រឹត្តិការណ៍ onchange ដើម្បីបង្ហាញរូបភាពភ្លាមៗ -->
                                    <input type="file" class="form-control rounded-0" id="bookImgInput" name="bimg" onchange="previewImage(event)">
                                </div>
                                <div class="col-md-4 text-center mb-3">
                                    <!-- ប្រអប់បង្ហាញរូបភាពមើលជាមុន (Preview Box) -->
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

    <!-- JavaScript សម្រាប់ដំណើរការ Onchange Preview រូបភាព -->
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
    </script>

    <%@include file="../component/footer.jsp" %>

</body>
</html>