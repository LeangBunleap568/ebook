<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sell Old Book</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">

    <%@include file="../component/navbar.jsp" %>

    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp" />
    </c:if>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-5">

                <%-- Main Card --%>
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4 p-md-5">

                        <%-- Header Section --%>
                        <div class="text-center mb-4">
                            <div class="d-inline-block bg-primary bg-opacity-10 text-primary p-3 rounded-circle mb-3">
                                <i class="fas fa-book-open fa-2x"></i>
                            </div>
                            <h4 class="fw-bold text-dark m-0">Sell Your Book</h4>
                            <p class="text-muted small mt-1">Fill in the details to list your old book for sale</p>
                        </div>

                        <%-- Flash Messages --%>
                        <c:if test="${not empty succMsg}">
                            <div class="alert alert-success border-0 shadow-sm text-center small py-2 mb-3" role="alert">
                                <i class="fas fa-check-circle me-1"></i> ${succMsg}
                            </div>
                            <c:remove var="succMsg" scope="session"/>
                        </c:if>
                        
                        <c:if test="${not empty failedMsg}">
                            <div class="alert alert-danger border-0 shadow-sm text-center small py-2 mb-3" role="alert">
                                <i class="fas fa-exclamation-circle me-1"></i> ${failedMsg}
                            </div>
                            <c:remove var="failedMsg" scope="session"/>
                        </c:if>

                        <%-- Form --%>
                        <form action="${pageContext.request.contextPath}/add_old_book" method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="email" value="${userobj.email}">
                            <input type="hidden" name="categories" value="Old">
                            <input type="hidden" name="status" value="Active">

                            <%-- Book Name --%>
                            <div class="mb-3">
                                <label class="form-label small fw-semibold text-secondary">Book Title <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0 text-muted"><i class="fas fa-book"></i></span>
                                    <input type="text" name="bname" class="form-control bg-light border-start-0 ps-0" placeholder="e.g. Java Programming" required>
                                </div>
                            </div>

                            <%-- Author Name --%>
                            <div class="mb-3">
                                <label class="form-label small fw-semibold text-secondary">Author Name <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0 text-muted"><i class="fas fa-user-edit"></i></span>
                                    <input type="text" name="author" class="form-control bg-light border-start-0 ps-0" placeholder="e.g. John Doe" required>
                                </div>
                            </div>

                            <%-- Price in KHR --%>
                            <div class="mb-3">
                                <label class="form-label small fw-semibold text-secondary">Price <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-muted fw-bold">?</span>
                                    <input type="number" name="price" class="form-control bg-light" placeholder="e.g. 20000" required>
                                </div>
                            </div>

                            <%-- Image Upload --%>
                            <div class="mb-4">
                                <label class="form-label small fw-semibold text-secondary">Book Cover Photo <span class="text-danger">*</span></label>
                                <input type="file" name="bimg" class="form-control bg-light" accept="image/*" required>
                            </div>

                            <%-- Submit Button --%>
                            <button type="submit" class="btn btn-warning w-100 fw-bold py-2 shadow-sm rounded-3">
                                <i class="fas fa-plus-circle me-1"></i> Post Book for Sale
                            </button>
                        </form>

                    </div>
                </div>

            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>

