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
    <title>Admin — Edit Book Details</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">

    <%-- Security Check (Admin Only) --%>
    <c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <%-- Highlight "All Books" sub-menu in Admin Navbar --%>
    <c:set var="activePage" value="all_books" scope="request" />
    <%@include file="../component/navbar.jsp" %>

    <div class="container-fluid px-4 py-4">
        
        <!-- Header / Breadcrumb Navigation -->
        <div class="d-flex align-items-center justify-content-between mb-4 pb-2 border-bottom">
            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/allBook.jsp" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                    <i class="fas fa-arrow-left me-1"></i> Back to Books
                </a>
                <h4 class="fw-bold mb-0 text-dark">
                    <i class="fas fa-edit text-primary me-2"></i>Edit Book Details
                </h4>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                
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
                %>
                
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-dark text-white fw-bold py-3 d-flex align-items-center justify-content-between">
                        <div><i class="fas fa-book me-2"></i> Book Information (ID: <%= b.getBookId() %>)</div>
                        <a href="${pageContext.request.contextPath}/admin/edit_cover.jsp?id=<%= b.getBookId() %>" class="btn btn-sm btn-outline-light rounded-pill px-3">
                            <i class="fas fa-image me-1"></i> Update Cover Image
                        </a>
                    </div>
                    
                    <div class="card-body p-4 bg-white">
                        <form action="${pageContext.request.contextPath}/admin/updateBook" method="post">
                            <input type="hidden" name="id" value="<%= b.getBookId() %>">
                            
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold text-secondary small">Book Name</label>
                                    <input type="text" class="form-control" name="bname" value="<%= b.getBookName() %>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold text-secondary small">Author Name</label>
                                    <input type="text" class="form-control" name="author" value="<%= b.getAuthor() %>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold text-secondary small">Price (៛ Riel)</label>
                                    <div class="input-group">
                                        <input type="number" step="100" class="form-control" name="price" value="<%= b.getPrice() %>" placeholder="e.g. 10000" required>
                                        <span class="input-group-text bg-light text-muted">៛</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold text-secondary small">Book Status</label>
                                    <select class="form-select" name="status">
                                        <option value="Active" <%= "Active".equalsIgnoreCase(b.getStatus()) ? "selected" : "" %>>Active</option>
                                        <option value="Inactive" <%= "Inactive".equalsIgnoreCase(b.getStatus()) ? "selected" : "" %>>Inactive</option>
                                    </select>
                                </div>
                            </div>

                            <div class="d-flex gap-2 pt-2 border-top">
                                <a href="${pageContext.request.contextPath}/allBook.jsp" class="btn btn-outline-secondary rounded-2 w-50 py-2">
                                    <i class="fas fa-times me-1"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary rounded-2 w-50 py-2 fw-bold">
                                    <i class="fas fa-save me-1"></i> Update Book
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <% } else { %>
                    <div class="card border-0 shadow-sm rounded-3 text-center p-5">
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
</body>
</html>

