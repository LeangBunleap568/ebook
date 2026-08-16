<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.ebook.dao.impl.BookDAOImpl"%>
<%@ page import="com.ebook.db.DBconnect"%>
<%@ page import="com.ebook.entity.BookDtls"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin — Update Book Cover Image</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }

        /* Image preview area */
        .img-preview-wrapper {
            position: relative;
            width: 220px;
            height: 300px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 28px rgba(0,0,0,0.15);
            border: 3px solid #e9ecef;
            transition: border-color 0.3s, box-shadow 0.3s;
            margin: 0 auto;
        }
        .img-preview-wrapper:hover {
            border-color: #0d6efd;
            box-shadow: 0 12px 36px rgba(13,110,253,0.2);
        }
        .img-preview-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }
        .img-preview-wrapper:hover img {
            transform: scale(1.05);
        }
        .img-preview-badge {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0,0,0,0.65);
            color: #fff;
            font-size: 11px;
            padding: 4px 14px;
            border-radius: 50px;
            backdrop-filter: blur(4px);
        }

        /* Custom file input styling */
        .custom-file-zone {
            border: 2px dashed #ced4da;
            border-radius: 12px;
            padding: 28px 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: #fafbfc;
        }
        .custom-file-zone:hover {
            border-color: #0d6efd;
            background: #f0f4ff;
        }
        .custom-file-zone.dragging {
            border-color: #0d6efd;
            background: #e8f0fe;
        }
        .custom-file-zone i {
            font-size: 2rem;
            color: #adb5bd;
            margin-bottom: 8px;
            transition: color 0.3s;
        }
        .custom-file-zone:hover i {
            color: #0d6efd;
        }

        /* New image preview (after file select) */
        .new-preview-container {
            display: none;
            margin-top: 16px;
        }
        .new-preview-container img {
            max-height: 200px;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.12);
        }
    </style>
</head>
<body class="bg-light">

    <%-- Security Check (Admin Only) --%>
    <c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%-- Highlight "All Books" sub-menu in Admin Navbar --%>
    <c:set var="activePage" value="allBooks" scope="request" />
    <%@include file="../component/navbar.jsp" %>

    <%-- Flash Messages --%>
    <%
        String succMsg = (String) session.getAttribute("succMsg");
        String failedMsg = (String) session.getAttribute("failedMsg");
    %>
    <% if (succMsg != null) { %>
        <div class="container-fluid px-4 pt-3">
            <div class="alert alert-success alert-dismissible fade show shadow-sm rounded-3">
                <i class="fas fa-check-circle me-1"></i> <%= succMsg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
        <% session.removeAttribute("succMsg"); %>
    <% } %>
    <% if (failedMsg != null) { %>
        <div class="container-fluid px-4 pt-3">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm rounded-3">
                <i class="fas fa-exclamation-triangle me-1"></i> <%= failedMsg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
        <% session.removeAttribute("failedMsg"); %>
    <% } %>

    <div class="container-fluid px-4 py-4">

        <!-- Header / Breadcrumb Navigation -->
        <div class="d-flex align-items-center justify-content-between mb-4 pb-2 border-bottom">
            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/allBook.jsp" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                    <i class="fas fa-arrow-left me-1"></i> Back to Books
                </a>
                <h4 class="fw-bold mb-0 text-dark">
                    <i class="fas fa-image text-primary me-2"></i>Update Book Cover
                </h4>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">

                <%
                    String idParam = request.getParameter("id");
                    BookDtls b = null;
                    int id = 0;
                    if (idParam != null && !idParam.isEmpty()) {
                        try {
                            id = Integer.parseInt(idParam);
                            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
                            b = dao.getBookById(id);
                        } catch (Exception e) {
                            b = null;
                        }
                    }

                    if (b != null) {
                        String photo = b.getPhotoName();
                        String imgSrc = (photo != null && (photo.startsWith("http://") || photo.startsWith("https://")))
                            ? photo
                            : request.getContextPath() + "/book/" + photo;
                %>

                <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                    <div class="card-header bg-dark text-white fw-bold py-3 px-4">
                        <i class="fas fa-book me-2"></i>
                        <%= b.getBookName() %>
                        <span class="opacity-50 ms-2 fw-normal" style="font-size:0.85rem;">(ID: <%= b.getBookId() %>)</span>
                    </div>

                    <div class="card-body p-4 bg-white">
                        <form action="${pageContext.request.contextPath}/admin/update_image"
                              method="post"
                              enctype="multipart/form-data"
                              id="imageUpdateForm">

                            <input type="hidden" name="id" value="<%= b.getBookId() %>">

                            <div class="row g-4">
                                <!-- Current Image Preview -->
                                <div class="col-md-5 text-center">
                                    <label class="form-label fw-semibold text-secondary small d-block mb-3">
                                        <i class="fas fa-image me-1"></i> Current Cover Image
                                    </label>
                                    <div class="img-preview-wrapper">
                                        <img src="<%= imgSrc %>" alt="<%= b.getBookName() %>"
                                             id="currentImage"
                                             onerror="this.src='https://placehold.co/220x300?text=No+Image'">
                                        <span class="img-preview-badge">
                                            <i class="fas fa-check-circle me-1"></i>Current
                                        </span>
                                    </div>
                                    <p class="text-muted small mt-2 mb-0">
                                        <i class="fas fa-file-image me-1"></i>
                                        <%= (photo != null && !photo.isEmpty()) ? photo : "No image set" %>
                                    </p>
                                </div>

                                <!-- Upload New Image -->
                                <div class="col-md-7">
                                    <label class="form-label fw-semibold text-secondary small d-block mb-3">
                                        <i class="fas fa-upload me-1"></i> Upload New Cover Image
                                    </label>

                                    <!-- Drag & Drop / Click Zone -->
                                    <div class="custom-file-zone" id="dropZone" onclick="document.getElementById('fileInput').click()">
                                        <i class="fas fa-cloud-upload-alt d-block"></i>
                                        <p class="fw-semibold text-dark mb-1">Click or drag image here</p>
                                        <p class="text-muted small mb-0">Supports JPG, PNG, GIF, WEBP</p>
                                    </div>

                                    <input type="file" name="bimg" id="fileInput"
                                           accept="image/*" required
                                           class="d-none"
                                           onchange="previewNewImage(this)">

                                    <!-- New Image Preview (shown after selection) -->
                                    <div class="new-preview-container" id="newPreviewContainer">
                                        <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3 border">
                                            <img src="" id="newImagePreview" alt="New preview" class="rounded"
                                                 style="width:80px; height:100px; object-fit:cover;">
                                            <div class="flex-grow-1">
                                                <p class="fw-semibold text-dark mb-1 small" id="newFileName">—</p>
                                                <p class="text-muted mb-0" style="font-size:11px;" id="newFileSize">—</p>
                                                <span class="badge bg-success-subtle text-success mt-1">
                                                    <i class="fas fa-check me-1"></i>Ready to upload
                                                </span>
                                            </div>
                                            <button type="button" class="btn btn-sm btn-outline-danger rounded-circle"
                                                    onclick="clearFileSelection()" title="Remove">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Book Info Summary -->
                                    <div class="mt-4 p-3 bg-light rounded-3 border">
                                        <h6 class="fw-bold text-dark mb-2">
                                            <i class="fas fa-info-circle text-primary me-1"></i>Book Details
                                        </h6>
                                        <table class="table table-sm table-borderless mb-0 small">
                                            <tr>
                                                <td class="text-muted fw-semibold" style="width:90px;">Title</td>
                                                <td class="text-dark"><%= b.getBookName() %></td>
                                            </tr>
                                            <tr>
                                                <td class="text-muted fw-semibold">Author</td>
                                                <td class="text-dark"><%= b.getAuthor() %></td>
                                            </tr>
                                            <tr>
                                                <td class="text-muted fw-semibold">Category</td>
                                                <td><span class="badge bg-primary-subtle text-primary"><%= b.getBookCategory() %></span></td>
                                            </tr>
                                            <tr>
                                                <td class="text-muted fw-semibold">Status</td>
                                                <td>
                                                    <span class="badge rounded-pill <%= "Active".equalsIgnoreCase(b.getStatus()) ? "bg-success" : "bg-secondary" %> px-3">
                                                        <i class="fas fa-circle me-1" style="font-size:7px;"></i><%= b.getStatus() %>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex gap-2 pt-4 mt-4 border-top">
                                <a href="${pageContext.request.contextPath}/allBook.jsp" class="btn btn-outline-secondary rounded-2 w-50 py-2">
                                    <i class="fas fa-times me-1"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary rounded-2 w-50 py-2 fw-bold" id="submitBtn">
                                    <i class="fas fa-cloud-upload-alt me-1"></i> Update Cover Image
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <% } else { %>
                    <div class="card border-0 shadow-sm rounded-4 text-center p-5">
                        <div class="card-body">
                            <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                            <h5 class="fw-bold text-secondary">Book Not Found</h5>
                            <p class="text-muted small mb-4">Could not find any book details for ID: <%= idParam != null ? idParam : "N/A" %></p>
                            <a href="${pageContext.request.contextPath}/allBook.jsp" class="btn btn-primary btn-sm rounded-pill px-4">
                                <i class="fas fa-arrow-left me-1"></i> Back to All Books
                            </a>
                        </div>
                    </div>
                <% } %>

            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>

    <script>
        // Instant image preview function
        function previewFile(input) {
            previewNewImage(input);
        }

        function previewNewImage(input) {
            const container = document.getElementById('newPreviewContainer');
            const preview = document.getElementById('newImagePreview');
            const nameEl = document.getElementById('newFileName');
            const sizeEl = document.getElementById('newFileSize');
            const dropZone = document.getElementById('dropZone');

            if (input.files && input.files[0]) {
                const file = input.files[0];
                const reader = new FileReader();

                reader.onload = function (e) {
                    preview.src = e.target.result;
                    nameEl.textContent = file.name;
                    sizeEl.textContent = formatFileSize(file.size);
                    container.style.display = 'block';
                    dropZone.style.display = 'none';
                };

                reader.readAsDataURL(file);
            }
        }

        // Clear file selection and reset preview
        function clearFileSelection() {
            const fileInput = document.getElementById('fileInput');
            const container = document.getElementById('newPreviewContainer');
            const dropZone = document.getElementById('dropZone');

            fileInput.value = '';
            container.style.display = 'none';
            dropZone.style.display = 'block';
        }

        // Format file size into human-readable string
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 Bytes';
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(1024));
            return parseFloat((bytes / Math.pow(1024, i)).toFixed(2)) + ' ' + sizes[i];
        }

        // Drag & Drop support
        const dropZone = document.getElementById('dropZone');
        const fileInput = document.getElementById('fileInput');

        if (dropZone) {
            ['dragenter', 'dragover'].forEach(event => {
                dropZone.addEventListener(event, function (e) {
                    e.preventDefault();
                    dropZone.classList.add('dragging');
                });
            });

            ['dragleave', 'drop'].forEach(event => {
                dropZone.addEventListener(event, function (e) {
                    e.preventDefault();
                    dropZone.classList.remove('dragging');
                });
            });

            dropZone.addEventListener('drop', function (e) {
                e.preventDefault();
                if (e.dataTransfer.files.length > 0) {
                    fileInput.files = e.dataTransfer.files;
                    previewNewImage(fileInput);
                }
            });
        }
    </script>
</body>
</html>


