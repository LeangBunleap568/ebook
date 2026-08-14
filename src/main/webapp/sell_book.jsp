<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sell Old Book</title>
    <%@include file="component/rootCss.jsp" %>
</head>
<body class="bg-light">
    <%@include file="component/navbar.jsp" %>
    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>

    <div class="container p-4 my-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <h4 class="text-center text-primary fw-bold mb-4">Sell Your Old Book</h4>
                        
                        <c:if test="${not empty succMsg}">
                            <div class="alert alert-success text-center">${succMsg}</div>
                            <c:remove var="succMsg" scope="session"/>
                        </c:if>
                        <c:if test="${not empty failedMsg}">
                            <div class="alert alert-danger text-center">${failedMsg}</div>
                            <c:remove var="failedMsg" scope="session"/>
                        </c:if>

                        <form action="add_old_book" method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="email" value="${userobj.email}">
                            <input type="hidden" name="categories" value="Old">
                            <input type="hidden" name="status" value="Active">

                            <div class="mb-3">
                                <label class="form-label">Book Name*</label>
                                <input type="text" name="bname" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Author Name*</label>
                                <input type="text" name="author" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Price*</label>
                                <input type="number" name="price" class="form-control" required>
                            </div>
                            
                            <div class="mb-4">
                                <label class="form-label">Upload Book Image*</label>
                                <input type="file" name="bimg" class="form-control" accept="image/*" required>
                            </div>
                            
                            <button type="submit" class="btn btn-warning w-100 fw-bold">Sell Book</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@include file="component/footer.jsp" %>
</body>
</html>
