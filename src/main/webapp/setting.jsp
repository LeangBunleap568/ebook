<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Settings & Dashboard</title>
    <%@include file="component/rootCss.jsp" %>
    <style>
        .setting-card {
            transition: all 0.3s ease;
            text-decoration: none;
            color: #333;
            border-radius: 12px;
            border: 1px solid rgba(0,0,0,0.05);
        }
        .setting-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
            color: #303f9f;
        }
        .icon-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            background-color: rgba(48, 63, 159, 0.1);
            color: #303f9f;
        }
        .icon-circle.danger {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        .icon-circle.success {
            background-color: rgba(25, 135, 84, 0.1);
            color: #198754;
        }
        .icon-circle.info {
            background-color: rgba(13, 202, 240, 0.1);
            color: #0dcaf0;
        }
    </style>
</head>
<body class="bg-light">

    <%@include file="component/navbar.jsp" %>

    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>

    <div class="container p-5 my-5">
        <h2 class="text-center fw-bold mb-4 text-primary">Hello, ${userobj.name}!</h2>
        <p class="text-center text-muted mb-5">Welcome to your dashboard. Manage your account settings and orders below.</p>

        <div class="row g-4 justify-content-center">
            
            <!-- Edit Profile Card -->
            <div class="col-md-6 col-lg-3">
                <a href="edit_profile.jsp" class="card text-center shadow-sm h-100 setting-card p-4">
                    <div class="card-body">
                        <div class="icon-circle mb-3">
                            <i class="fas fa-user-edit fa-3x"></i>
                        </div>
                        <h5 class="fw-bold m-0">Edit Profile</h5>
                    </div>
                </a>
            </div>

            <!-- My Orders Card -->
            <div class="col-md-6 col-lg-3">
                <a href="order.jsp" class="card text-center shadow-sm h-100 setting-card p-4">
                    <div class="card-body">
                        <div class="icon-circle success mb-3">
                            <i class="fas fa-box-open fa-3x"></i>
                        </div>
                        <h5 class="fw-bold m-0">My Orders</h5>
                    </div>
                </a>
            </div>

            <!-- Help Center Card -->
            <div class="col-md-6 col-lg-3">
                <a href="helpline.jsp" class="card text-center shadow-sm h-100 setting-card p-4">
                    <div class="card-body">
                        <div class="icon-circle info mb-3">
                            <i class="fas fa-headset fa-3x"></i>
                        </div>
                        <h5 class="fw-bold m-0">Help Center</h5>
                    </div>
                </a>
            </div>

            <!-- Logout Card -->
            <div class="col-md-6 col-lg-3">
                <a href="logout" class="card text-center shadow-sm h-100 setting-card p-4">
                    <div class="card-body">
                        <div class="icon-circle danger mb-3">
                            <i class="fas fa-sign-out-alt fa-3x"></i>
                        </div>
                        <h5 class="fw-bold m-0 text-danger">Logout</h5>
                    </div>
                </a>
            </div>

            <!-- Sell Old Book Card -->
            <div class="col-md-6 col-lg-3">
                <a href="sell_book.jsp" class="card text-center shadow-sm h-100 setting-card p-4">
                    <div class="card-body">
                        <div class="icon-circle mb-3" style="color: #ff9800; background-color: rgba(255,152,0,0.1);">
                            <i class="fas fa-book fa-3x"></i>
                        </div>
                        <h5 class="fw-bold m-0" style="color: #ff9800;">Sell Old Book</h5>
                    </div>
                </a>
            </div>

            <!-- My Old Books Card -->
            <div class="col-md-6 col-lg-3">
                <a href="old_book.jsp" class="card text-center shadow-sm h-100 setting-card p-4">
                    <div class="card-body">
                        <div class="icon-circle mb-3" style="color: #6f42c1; background-color: rgba(111,66,193,0.1);">
                            <i class="fas fa-book-open fa-3x"></i>
                        </div>
                        <h5 class="fw-bold m-0" style="color: #6f42c1;">My Old Books</h5>
                    </div>
                </a>
            </div>

        </div>
    </div>

    <%@include file="component/footer.jsp" %>
</body>
</html>
