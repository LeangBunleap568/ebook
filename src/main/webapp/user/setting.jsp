<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Settings & Dashboard</title>
    <%@include file="../component/rootCss.jsp" %>
    
    <style>
        :root {
            --cf-bg: #f4f6f8;
            --cf-header: #1e293b;
            --cf-orange: #f5a623;
            --cf-green: #27ae60;
            --cf-border: #cbd5e1;
            --cf-card-bg: #ffffff;
        }

        *, *::before, *::after {
            border-radius: 0px !important;
            backdrop-filter: none !important;
            -webkit-backdrop-filter: none !important;
        }

        body {
            background-color: var(--cf-bg) !important;
            color: var(--cf-header);
            font-family: system-ui, -apple-system, sans-serif;
        }

        .setting-card {
            transition: all 0.2s ease;
            border: 2px solid var(--cf-border);
            background-color: var(--cf-card-bg);
        }

        .setting-card:hover {
            border-color: var(--cf-header);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05) !important;
        }

        .setting-icon-box {
            width: 42px;
            height: 42px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 8px;
            color: #ffffff !important;
        }

        .icon-slate { background-color: var(--cf-header); }
        .icon-green { background-color: var(--cf-green); }
        .icon-orange { background-color: var(--cf-orange); }
        .icon-muted { background-color: #64748b; }
        .icon-danger { background-color: #d9534f; }

        .text-slate {
            color: var(--cf-header) !important;
        }

        .text-danger-custom {
            color: #d9534f !important;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <%@include file="../component/navbar.jsp" %>

    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <div class="container py-4 flex-grow-1" style="max-width: 800px;">
        <!-- Section Header -->
        <div class="mb-3 pb-2 border-bottom" style="border-color: var(--cf-border) !important;">
            <h4 class="fw-bold text-slate mb-0 text-uppercase" style="font-size: 1.2rem;">User Settings</h4>
            <p class="text-muted small mb-0">Manage your account, view orders, and manage listings</p>
        </div>

        <div class="row g-2">
            <!-- Edit Profile -->
            <div class="col-6 col-sm-4 col-md-3">
                <a href="${pageContext.request.contextPath}/user/edit_profile.jsp" class="card text-center text-decoration-none setting-card h-100 p-2">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center p-1">
                        <div class="setting-icon-box icon-slate">
                            <i class="fas fa-user-edit"></i>
                        </div>
                        <h6 class="card-title fw-bold text-slate mb-0 small">Edit Profile</h6>
                    </div>
                </a>
            </div>

            <!-- My Orders -->
            <div class="col-6 col-sm-4 col-md-3">
                <a href="${pageContext.request.contextPath}/user/order.jsp" class="card text-center text-decoration-none setting-card h-100 p-2">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center p-1">
                        <div class="setting-icon-box icon-green">
                            <i class="fas fa-box-open"></i>
                        </div>
                        <h6 class="card-title fw-bold text-slate mb-0 small">My Orders</h6>
                    </div>
                </a>
            </div>

            <!-- Sell Old Book -->
            <div class="col-6 col-sm-4 col-md-3">
                <a href="${pageContext.request.contextPath}/user/sell_book.jsp" class="card text-center text-decoration-none setting-card h-100 p-2">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center p-1">
                        <div class="setting-icon-box icon-orange">
                            <i class="fas fa-book"></i>
                        </div>
                        <h6 class="card-title fw-bold text-slate mb-0 small">Sell Old Book</h6>
                    </div>
                </a>
            </div>

            <!-- My Old Books -->
            <div class="col-6 col-sm-4 col-md-3">
                <a href="${pageContext.request.contextPath}/user/old_book.jsp" class="card text-center text-decoration-none setting-card h-100 p-2">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center p-1">
                        <div class="setting-icon-box icon-muted">
                            <i class="fas fa-book-open"></i>
                        </div>
                        <h6 class="card-title fw-bold text-slate mb-0 small">My Old Books</h6>
                    </div>
                </a>
            </div>

            <!-- Logout -->
            <div class="col-6 col-sm-4 col-md-3">
                <a href="${pageContext.request.contextPath}/logout" class="card text-center text-decoration-none setting-card h-100 p-2">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center p-1">
                        <div class="setting-icon-box icon-danger">
                            <i class="fas fa-sign-out-alt"></i>
                        </div>
                        <h6 class="card-title fw-bold text-danger-custom mb-0 small">Logout</h6>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>