<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App - Admin Dashboard</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        .admin-card {
            transition: transform 0.2s, box-shadow 0.2s;
            border: 1px solid #e3e6f0 !important;
        }
        .admin-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.08) !important;
        }
        .icon-box {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px !important;
            margin: 0 auto 1rem auto;
        }
    </style>
</head>
<body class="bg-light">

    <%@include file="../component/navbar.jsp" %>

    <div class="container my-5">
        <h4 class="fw-bold text-dark mb-4 border-bottom pb-2">
            <i class="fas fa-th-large text-primary me-2"></i>Admin Dashboard
        </h4>

        <div class="row g-4">
            
            <!-- Add Books -->
            <div class="col-md-3">
                <div class="card h-100 text-center rounded-0 shadow-sm admin-card bg-white p-3">
                    <div class="card-body">
                        <div class="icon-box bg-primary text-white">
                            <i class="fas fa-plus-circle fa-2x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Add Books</h5>
                        <a href="addBook.jsp" class="btn btn-primary btn-sm rounded-0 w-100 mt-3 fw-semibold">
                            <i class="fas fa-plus me-1"></i> Open
                        </a>
                    </div>
                </div>
            </div>

            <!-- All Books -->
            <div class="col-md-3">
                <div class="card h-100 text-center rounded-0 shadow-sm admin-card bg-white p-3">
                    <div class="card-body">
                        <div class="icon-box bg-success text-white">
                            <i class="fas fa-book-open fa-2x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">All Books</h5>
                        <a href="allBook.jsp" class="btn btn-success btn-sm rounded-0 w-100 mt-3 fw-semibold text-white">
                            <i class="fas fa-list me-1"></i> View All
                        </a>
                    </div>
                </div>
            </div>

            <!-- Orders -->
            <div class="col-md-3">
                <div class="card h-100 text-center rounded-0 shadow-sm admin-card bg-white p-3">
                    <div class="card-body">
                        <div class="icon-box bg-warning text-dark">
                            <i class="fas fa-box-open fa-2x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Orders</h5>
                        <a href="orderBook.jsp" class="btn btn-warning btn-sm text-dark rounded-0 w-100 mt-3 fw-semibold">
                            <i class="fas fa-truck me-1"></i> View Orders
                        </a>
                    </div>
                </div>
            </div>

            <!-- Logout -->
            <div class="col-md-3">
                <div class="card h-100 text-center rounded-0 shadow-sm admin-card bg-white p-3">
                    <div class="card-body">
                        <div class="icon-box bg-danger text-white">
                            <i class="fas fa-sign-out-alt fa-2x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Logout</h5>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm rounded-0 w-100 mt-3 fw-semibold">
                            <i class="fas fa-power-off me-1"></i> Exit
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <%@include file="../component/footer.jsp" %>

</body>
</html>