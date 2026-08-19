<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.ebook.dao.impl.BookDAOImpl"%>
<%@ page import="com.ebook.db.DBconnect"%>
<%@ page import="com.ebook.entity.BookDtls"%>

<%-- Security Check (Admin Only) --%>
<c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
    <c:redirect url="../login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ebook App — Update Book Cover Image</title>
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

    /* Main Container */
    .main-container {
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    /* Top Navbar */
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

    /* Content Body */
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

    /* CF Card Component */
    .cf-card {
        background: #fff;
        border-radius: 4px;
        border: 1px solid #dcdcdc;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        padding: 15px;
        margin-bottom: 15px;
    }
    .cf-card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 12px;
        border-bottom: 1px solid #eee;
        padding-bottom: 8px;
    }
    .cf-card-title {
        font-size: 13px;
        font-weight: 600;
        color: #333;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    /* Image Preview Section */
    .img-preview-wrapper {
        position: relative;
        width: 180px;
        height: 240px;
        border-radius: 4px;
        overflow: hidden;
        border: 1px solid #ccc;
        margin: 0 auto;
        background: #fafafa;
    }
    .img-preview-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .img-preview-badge {
        position: absolute;
        bottom: 8px;
        left: 50%;
        transform: translateX(-50%);
        background: rgba(0, 0, 0, 0.7);
        color: #fff;
        font-size: 10px;
        padding: 2px 10px;
        border-radius: 3px;
        white-space: nowrap;
    }

    /* File Drop Zone */
    .custom-file-zone {
        border: 2px dashed #bdc3c7;
        border-radius: 4px;
        padding: 20px;
        text-align: center;
        cursor: pointer;
        transition: all 0.2s;
        background: #fdfdfd;
    }
    .custom-file-zone:hover, .custom-file-zone.dragging {
        border-color: #3498db;
        background: #ebf5fb;
    }
    .custom-file-zone i {
        font-size: 1.8rem;
        color: #7f8c8d;
        margin-bottom: 6px;
    }

    .new-preview-container {
        display: none;
        margin-top: 12px;
    }

    /* Detail Table */
    .table-details {
        width: 100%;
        font-size: 12px;
    }
    .table-details td {
        padding: 4px 0;
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
            <a href="${pageContext.request.contextPath}/allBook.jsp" class="nav-link-custom active">Book Catalog</a>
            <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="nav-link-custom">Order Requests</a>
            <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="nav-link-custom">Management</a>
        </div>
    </div>

    <%-- Main Content Area --%>
    <div class="main-container">

        <%-- Top Bar --%>
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
            Home &gt; Catalog &gt; Update Book Cover
        </div>

        <%-- Content Body --%>
        <div class="content-body">

            <%-- Flash Messages --%>
            <%
                String succMsg = (String) session.getAttribute("succMsg");
                String failedMsg = (String) session.getAttribute("failedMsg");
            %>
            <% if (succMsg != null) { %>
                <div class="alert alert-success alert-dismissible fade show mb-3 py-2" role="alert" style="font-size: 12px;">
                    <i class="fas fa-check-circle me-1"></i> <%= succMsg %>
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("succMsg"); %>
            <% } %>
            <% if (failedMsg != null) { %>
                <div class="alert alert-danger alert-dismissible fade show mb-3 py-2" role="alert" style="font-size: 12px;">
                    <i class="fas fa-exclamation-triangle me-1"></i> <%= failedMsg %>
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("failedMsg"); %>
            <% } %>

            <div class="page-title">
                <div class="d-flex align-items-center gap-2">
                    <a href="${pageContext.request.contextPath}/allBook.jsp" class="btn btn-outline-secondary btn-sm py-0 px-2" style="font-size: 11px;">
                        <i class="fas fa-arrow-left me-1"></i> Back
                    </a>
                    <span>Update Cover Image</span>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-9">

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

                    <div class="cf-card">
                        <div class="cf-card-header">
                            <div class="cf-card-title">
                                <i class="fas fa-book text-secondary"></i>
                                <%= b.getBookName() %> <span class="text-muted font-monospace ms-1">(ID: <%= b.getBookId() %>)</span>
                            </div>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin/update_image"
                              method="post"
                              enctype="multipart/form-data"
                              id="imageUpdateForm">

                            <input type="hidden" name="id" value="<%= b.getBookId() %>">

                            <div class="row g-3 my-2">
                                <!-- Current Image Preview -->
                                <div class="col-md-5 text-center border-end">
                                    <label class="form-label text-muted fw-bold d-block mb-2" style="font-size: 11px;">
                                        CURRENT COVER IMAGE
                                    </label>
                                    <div class="img-preview-wrapper mb-2">
                                        <img src="<%= imgSrc %>" alt="<%= b.getBookName() %>"
                                             id="currentImage"
                                             onerror="this.src='https://placehold.co/180x240?text=No+Image'">
                                        <span class="img-preview-badge">Active Image</span>
                                    </div>
                                    <div class="text-muted" style="font-size: 11px;">
                                        <i class="fas fa-file-image me-1"></i>
                                        <%= (photo != null && !photo.isEmpty()) ? photo : "No image set" %>
                                    </div>
                                </div>

                                <!-- Upload New Image & Info -->
                                <div class="col-md-7 px-3">
                                    <label class="form-label text-muted fw-bold d-block mb-2" style="font-size: 11px;">
                                        UPLOAD NEW FILE
                                    </label>

                                    <!-- Drag & Drop Zone -->
                                    <div class="custom-file-zone" id="dropZone" onclick="document.getElementById('fileInput').click()">
                                        <i class="fas fa-cloud-upload-alt d-block"></i>
                                        <span class="fw-bold d-block text-dark" style="font-size: 12px;">Click or drop image file here</span>
                                        <span class="text-muted" style="font-size: 10px;">Supports JPG, PNG, GIF, WEBP</span>
                                    </div>

                                    <input type="file" name="bimg" id="fileInput"
                                           accept="image/*" required
                                           class="d-none"
                                           onchange="previewNewImage(this)">

                                    <!-- New Image Preview -->
                                    <div class="new-preview-container" id="newPreviewContainer">
                                        <div class="d-flex align-items-center gap-2 p-2 bg-light border rounded">
                                            <img src="" id="newImagePreview" alt="New preview" class="rounded"
                                                 style="width: 50px; height: 65px; object-fit: cover;">
                                            <div class="flex-grow-1 overflow-hidden">
                                                <div class="fw-bold text-truncate" style="font-size: 12px;" id="newFileName">—</div>
                                                <div class="text-muted" style="font-size: 10px;" id="newFileSize">—</div>
                                                <span class="badge bg-success" style="font-size: 9px;">Ready to update</span>
                                            </div>
                                            <button type="button" class="btn btn-sm btn-link text-danger p-0 px-1"
                                                    onclick="clearFileSelection()" title="Remove file">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Metadata Summary -->
                                    <div class="mt-3 p-2 bg-light border rounded">
                                        <div class="fw-bold text-secondary mb-1" style="font-size: 11px;">Target Book Information</div>
                                        <table class="table-details text-muted">
                                            <tr>
                                                <td style="width: 70px;">Title:</td>
                                                <td class="text-dark fw-medium"><%= b.getBookName() %></td>
                                            </tr>
                                            <tr>
                                                <td>Author:</td>
                                                <td class="text-dark"><%= b.getAuthor() %></td>
                                            </tr>
                                            <tr>
                                                <td>Category:</td>
                                                <td><span class="badge bg-info text-dark" style="font-size: 9px;"><%= b.getBookCategory() %></span></td>
                                            </tr>
                                            <tr>
                                                <td>Status:</td>
                                                <td>
                                                    <span class="badge <%= "Active".equalsIgnoreCase(b.getStatus()) ? "bg-success" : "bg-secondary" %>" style="font-size: 9px;">
                                                        <%= b.getStatus() %>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Form Actions -->
                            <div class="d-flex justify-content-end gap-2 pt-3 border-top mt-2">
                                <a href="${pageContext.request.contextPath}/allBook.jsp" class="btn btn-light btn-sm border" style="font-size: 12px;">
                                    Cancel
                                </a>
                                <button type="submit" class="btn btn-primary btn-sm px-3" style="font-size: 12px;" id="submitBtn">
                                    <i class="fas fa-upload me-1"></i> Update Cover Image
                                </button>
                            </div>
                        </form>
                    </div>

                    <% } else { %>
                        <div class="cf-card text-center py-5">
                            <i class="fas fa-exclamation-triangle fa-2x text-warning mb-2"></i>
                            <h6 class="fw-bold text-dark">Book Record Not Found</h6>
                            <p class="text-muted mb-3" style="font-size: 11px;">Could not retrieve details for ID: <%= idParam != null ? idParam : "N/A" %></p>
                            <a href="${pageContext.request.contextPath}/allBook.jsp" class="btn btn-primary btn-sm px-3" style="font-size: 12px;">
                                Return to Book Catalog
                            </a>
                        </div>
                    <% } %>

                </div>
            </div>

        </div>
    </div>
</div>

<script>
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

    function clearFileSelection() {
        const fileInput = document.getElementById('fileInput');
        const container = document.getElementById('newPreviewContainer');
        const dropZone = document.getElementById('dropZone');

        fileInput.value = '';
        container.style.display = 'none';
        dropZone.style.display = 'block';
    }

    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(1024));
        return parseFloat((bytes / Math.pow(1024, i)).toFixed(2)) + ' ' + sizes[i];
    }

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