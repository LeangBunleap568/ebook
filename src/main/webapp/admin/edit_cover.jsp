<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="com.app.dao.impl.BookDAOImpl"%>
<%@ page import="com.app.db.DBconnect"%>
<%@ page import="com.app.entity.BookDtls"%>

<%-- Security Check --%>
<c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
    <c:redirect url="../login.jsp" />
</c:if>

<%
    String idParam = request.getParameter("id");
    BookDtls book = null;
    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            int id = Integer.parseInt(idParam.trim());
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
    <title>Admin Dashboard — Update Book Cover</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        .content-body {
            padding: 0 20px 20px 20px;
        }
        .page-title {
            font-size: 1.4rem;
            color: #2c3e50;
            font-weight: 500;
        }
        .ui-card {
            background: #ffffff;
            border: 1px solid #dcdcdc;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        .ui-card-header {
            padding: 12px 15px;
            border-bottom: 1px solid #eeeeee;
            font-weight: 600;
            font-size: 0.95rem;
            color: #333;
        }
        .preview-box {
            border: 2px dashed #cbd5e1;
            border-radius: 6px;
            padding: 20px;
            text-align: center;
            background: #f8fafc;
            min-height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }
        .preview-img {
            max-height: 220px;
            max-width: 100%;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<%@include file="navbar.jsp" %>

<main class="admin-main">
    <!-- Breadcrumb Navigation -->
    <div class="breadcrumb-text mb-2 bg-white px-4 py-2 border-bottom" style="font-size: 11px;">
        <a href="${pageContext.request.contextPath}/admin/home.jsp" class="text-decoration-none text-muted">Home</a> &gt; 
        <a href="${pageContext.request.contextPath}/admin/all_books.jsp" class="text-decoration-none text-muted">Books</a> &gt; 
        <c:if test="${not empty book}">
            <a href="${pageContext.request.contextPath}/admin/edit_books.jsp?id=${book.bookId}" class="text-decoration-none text-muted">${book.bookName}</a> &gt; 
        </c:if>
        <span>Change Cover Image</span>
    </div>

    <div class="content-body">
        <%-- Flash Messages --%>
        <c:if test="${not empty succMsg}">
            <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                <i class="fas fa-check-circle me-1"></i> ${succMsg}
                <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="succMsg" scope="session"/>
        </c:if>
        <c:if test="${not empty failedMsg}">
            <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                <i class="fas fa-exclamation-triangle me-1"></i> ${failedMsg}
                <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="failedMsg" scope="session"/>
        </c:if>
        <c:if test="${not empty warnMsg}">
            <div class="alert alert-warning alert-dismissible fade show mb-3" role="alert">
                <i class="fas fa-info-circle me-1"></i> ${warnMsg}
                <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="warnMsg" scope="session"/>
        </c:if>

        <c:choose>
            <c:when test="${not empty book}">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h2 class="page-title mb-0">Update Cover: <span class="text-primary">${book.bookName}</span></h2>
                    <a href="${pageContext.request.contextPath}/admin/edit_books.jsp?id=${book.bookId}" class="btn btn-sm btn-outline-secondary">
                        <i class="fas fa-arrow-left me-1"></i> Back to Edit Details
                    </a>
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="ui-card">
                            <div class="ui-card-header d-flex justify-content-between align-items-center">
                                <span>Upload New Cover Image</span>
                                <span class="badge bg-secondary">Book #UID-${book.bookId}</span>
                            </div>
                            <div class="p-4">
                                <form action="${pageContext.request.contextPath}/admin/update_image" method="post" enctype="multipart/form-data" onsubmit="return validateImageUpload();">
                                    <input type="hidden" name="id" value="${book.bookId}">

                                    <div id="imageUploadError" class="alert alert-danger d-none mb-3 py-2" style="font-size: 12px;"></div>

                                    <div class="row g-3 mb-4">
                                        <!-- Current Cover -->
                                        <div class="col-md-6 text-center">
                                            <label class="form-label small fw-bold text-secondary mb-2">Current Cover</label>
                                            <div class="preview-box">
                                                <c:choose>
                                                    <c:when test="${not empty book.photoName}">
                                                        <img src="${pageContext.request.contextPath}/book/${book.photoName}" class="preview-img" alt="Current Cover">
                                                        <div class="small text-muted mt-2">${book.photoName}</div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-image fa-3x text-muted mb-2"></i>
                                                        <span class="text-muted small">No cover currently uploaded</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <!-- New Cover Preview -->
                                        <div class="col-md-6 text-center">
                                            <label class="form-label small fw-bold text-secondary mb-2">New Preview</label>
                                            <div class="preview-box" id="newPreviewBox">
                                                <i class="fas fa-cloud-upload-alt fa-3x text-secondary opacity-50 mb-2" id="previewPlaceholderIcon"></i>
                                                <span class="text-muted small" id="previewPlaceholderText">Selected image will preview here</span>
                                                <img id="imagePreview" class="preview-img d-none" alt="New Cover Preview">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label for="bimg" class="form-label small fw-bold text-secondary">Select Image File</label>
                                        <input class="form-control" type="file" id="bimg" name="bimg" accept="image/jpeg,image/png,image/jpg,image/webp" onchange="handleFileSelect(event)">
                                        <div class="form-text small">Accepted formats: JPG, JPEG, PNG, WEBP. Max file size: 5MB.</div>
                                    </div>

                                    <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                                        <a href="${pageContext.request.contextPath}/admin/edit_books.jsp?id=${book.bookId}" class="btn btn-sm btn-outline-secondary">
                                            Cancel
                                        </a>
                                        <button type="submit" class="btn btn-sm btn-success px-4 fw-bold">
                                            <i class="fas fa-upload me-1"></i> Save New Cover
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="ui-card p-5 text-center">
                    <i class="fas fa-exclamation-circle fa-3x text-warning mb-3"></i>
                    <h5>Book Not Found</h5>
                    <p class="text-muted small">Could not retrieve book details for ID: <code>${param.id}</code></p>
                    <a href="${pageContext.request.contextPath}/admin/all_books.jsp" class="btn btn-sm btn-primary">
                        Return to Catalog
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<%@include file="footer.jsp" %>

<script>
    function handleFileSelect(event) {
        const file = event.target.files[0];
        const preview = document.getElementById('imagePreview');
        const icon = document.getElementById('previewPlaceholderIcon');
        const text = document.getElementById('previewPlaceholderText');
        const errorBox = document.getElementById('imageUploadError');

        errorBox.classList.add('d-none');
        errorBox.innerText = '';

        if (file) {
            if (file.size > 5 * 1024 * 1024) {
                errorBox.innerText = '⚠️ Image size exceeds 5MB limit. Please choose a smaller image.';
                errorBox.classList.remove('d-none');
                event.target.value = '';
                preview.classList.add('d-none');
                icon.classList.remove('d-none');
                text.classList.remove('d-none');
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.classList.remove('d-none');
                icon.classList.add('d-none');
                text.classList.add('d-none');
            };
            reader.readAsDataURL(file);
        } else {
            preview.classList.add('d-none');
            icon.classList.remove('d-none');
            text.classList.remove('d-none');
        }
    }

    function validateImageUpload() {
        // Form submits safely even if no new image selected (servlet retains old image)
        return true;
    }
</script>

</body>
</html>
