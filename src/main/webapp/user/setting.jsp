<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Settings & Dashboard</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">

    <%@include file="../component/navbar.jsp" %>

    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp" />
    </c:if>

    <div class="container py-5">
        <h3 class="text-center mb-4">User Setting</h3>

        <div class="row g-3">
            <!-- Edit Profile -->
            <div class="col-6 col-md-4">
                <a href="${pageContext.request.contextPath}/user/edit_profile.jsp" class="card text-center text-decoration-none shadow-sm h-100 py-4">
                    <div class="card-body">
                        <i class="fas fa-user-edit fa-2x text-primary mb-2"></i>
                        <h6 class="card-title text-dark mb-0">Edit Profile</h6>
                    </div>
                </a>
            </div>

            <!-- My Orders -->
            <div class="col-6 col-md-4">
                <a href="${pageContext.request.contextPath}/user/order.jsp" class="card text-center text-decoration-none shadow-sm h-100 py-4">
                    <div class="card-body">
                        <i class="fas fa-box-open fa-2x text-success mb-2"></i>
                        <h6 class="card-title text-dark mb-0">My Orders</h6>
                    </div>
                </a>
            </div>

            <!-- Sell Old Book -->
            <div class="col-6 col-md-4">
                <a href="${pageContext.request.contextPath}/user/sell_book.jsp" class="card text-center text-decoration-none shadow-sm h-100 py-4">
                    <div class="card-body">
                        <i class="fas fa-book fa-2x text-warning mb-2"></i>
                        <h6 class="card-title text-dark mb-0">Sell Old Book</h6>
                    </div>
                </a>
            </div>

            <!-- My Old Books -->
            <div class="col-6 col-md-4">
                <a href="${pageContext.request.contextPath}/user/old_book.jsp" class="card text-center text-decoration-none shadow-sm h-100 py-4">
                    <div class="card-body">
                        <i class="fas fa-book-open fa-2x text-info mb-2"></i>
                        <h6 class="card-title text-dark mb-0">My Old Books</h6>
                    </div>
                </a>
            </div>

       
            <!-- Logout -->
            <div class="col-6 col-md-4">
                <a href="${pageContext.request.contextPath}/logout" class="card text-center text-decoration-none shadow-sm h-100 py-4">
                    <div class="card-body">
                        <i class="fas fa-sign-out-alt fa-2x text-danger mb-2"></i>
                        <h6 class="card-title text-danger mb-0">Logout</h6>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>

