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
        :root {
            --admin-primary: #4e73df;
            --admin-success: #1cc88a;
            --admin-info: #36b9cc;
            --admin-warning: #f6c23e;
            --admin-danger: #e74a3b;
        }

        body {
            background-color: #f8f9fc;
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }

        .admin-header {
            background: #ffffff;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }

        .stat-card {
            border-left: 0.25rem solid !important;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
        }

        .border-left-primary { border-left-color: var(--admin-primary) !important; }
        .border-left-success { border-left-color: var(--admin-success) !important; }
        .border-left-info { border-left-color: var(--admin-info) !important; }
        .border-left-warning { border-left-color: var(--admin-warning) !important; }

        .admin-card {
            transition: transform 0.2s, box-shadow 0.2s;
            border: 1px solid #e3e6f0 !important;
        }

        .admin-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.08) !important;
        }

        .icon-box {
            width: 55px;
            height: 55px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px !important;
            margin: 0 auto 1rem auto;
        }

        .stat-icon {
            font-size: 2rem;
            opacity: 0.3;
        }
    </style>
</head>
<body class="bg-light">

    <!-- Top Navigation Header (Replaces General User Navbar) -->
    <header class="admin-header py-3 px-4 mb-4 border-bottom">
        <div class="container-fluid d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center">
                <i class="fas fa-book-reader fa-2x text-primary me-2"></i>
                <span class="fs-4 fw-bold text-dark">Ebook Store <small class="fs-6 text-muted fw-normal">| Admin Panel</small></span>
            </div>

            <div class="d-flex align-items-center gap-3">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-2" style="width: 38px; height: 38px;">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <div class="d-none d-md-block text-end">
                        <div class="fw-bold fs-7 lh-1">Administrator</div>
                        <small class="text-muted" style="font-size: 0.75rem;">admin@ebook.com</small>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm rounded-2 ms-2">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </header>

    <div class="container-fluid px-4 mb-5">
        
        <!-- Page Title & Real-time Indicator -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h4 class="fw-bold text-dark mb-0">
                <i class="fas fa-tachometer-alt text-primary me-2"></i>Dashboard Overview
            </h4>
            <span class="badge bg-white text-dark shadow-sm border px-3 py-2 rounded-pill mt-2 mt-sm-0">
                <i class="fas fa-circle text-success fs-8 me-1"></i> Live Status Updated
            </span>
        </div>

        <!-- 📊 REAL-TIME COUNTS / STATS CARDS -->
        <div class="row g-3 mb-4">
            
            <!-- Total Books Count -->
            <div class="col-xl-3 col-md-6">
                <div class="card stat-card border-left-primary shadow-sm h-100 py-2 bg-white">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col me-2">
                                <div class="text-xs fw-bold text-primary text-uppercase mb-1">Total Books</div>
                                <div class="h3 mb-0 fw-bold text-gray-800">
                                    <c:out value="${totalBooks != null ? totalBooks : '0'}" />
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-book stat-icon text-primary"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Total Users Count -->
            <div class="col-xl-3 col-md-6">
                <div class="card stat-card border-left-success shadow-sm h-100 py-2 bg-white">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col me-2">
                                <div class="text-xs fw-bold text-success text-uppercase mb-1">Total Users</div>
                                <div class="h3 mb-0 fw-bold text-gray-800">
                                    <c:out value="${totalUsers != null ? totalUsers : '0'}" />
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-users stat-icon text-success"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Total Orders Count -->
            <div class="col-xl-3 col-md-6">
                <div class="card stat-card border-left-warning shadow-sm h-100 py-2 bg-white">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col me-2">
                                <div class="text-xs fw-bold text-warning text-uppercase mb-1">Total Orders</div>
                                <div class="h3 mb-0 fw-bold text-gray-800">
                                    <c:out value="${totalOrders != null ? totalOrders : '0'}" />
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-shopping-bag stat-icon text-warning"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pending / Processing -->
            <div class="col-xl-3 col-md-6">
                <div class="card stat-card border-left-info shadow-sm h-100 py-2 bg-white">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col me-2">
                                <div class="text-xs fw-bold text-info text-uppercase mb-1">Active Transactions</div>
                                <div class="h3 mb-0 fw-bold text-gray-800">
                                    <c:out value="${activeTransactions != null ? activeTransactions : '0'}" />
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-exchange-alt stat-icon text-info"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- 🚀 QUICK ACTION CARDS (YOUR ORIGINAL NAVIGATION LINKS) -->
        <h5 class="fw-bold text-dark mb-3">Quick Navigation</h5>
        <div class="row g-4 mb-5">
            
            <!-- Add Books -->
            <div class="col-md-3">
                <div class="card h-100 text-center rounded-2 shadow-sm admin-card bg-white p-3">
                    <div class="card-body">
                        <div class="icon-box bg-primary text-white">
                            <i class="fas fa-plus-circle fa-2x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Add Books</h5>
                        <p class="text-muted small mb-0">Create new book listings</p>
                        <a href="addBook.jsp" class="btn btn-primary btn-sm rounded-2 w-100 mt-3 fw-semibold">
                            <i class="fas fa-plus me-1"></i> Open Form
                        </a>
                    </div>
                </div>
            </div>

            <!-- All Books -->
            <div class="col-md-3">
                <div class="card h-100 text-center rounded-2 shadow-sm admin-card bg-white p-3">
                    <div class="card-body">
                        <div class="icon-box bg-success text-white">
                            <i class="fas fa-book-open fa-2x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">All Books</h5>
                        <p class="text-muted small mb-0">Manage, Update & Delete</p>
                        <a href="allBook.jsp" class="btn btn-success btn-sm rounded-2 w-100 mt-3 fw-semibold text-white">
                            <i class="fas fa-list me-1"></i> View All
                        </a>
                    </div>
                </div>
            </div>

            <!-- Orders -->
            <div class="col-md-3">
                <div class="card h-100 text-center rounded-2 shadow-sm admin-card bg-white p-3">
                    <div class="card-body">
                        <div class="icon-box bg-warning text-dark">
                            <i class="fas fa-box-open fa-2x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Orders</h5>
                        <p class="text-muted small mb-0">View customer orders</p>
                        <a href="all_order.jsp" class="btn btn-warning btn-sm text-dark rounded-2 w-100 mt-3 fw-semibold">
                            <i class="fas fa-truck me-1"></i> View Orders
                        </a>
                    </div>
                </div>
            </div>

            <!-- Logout -->
            <div class="col-md-3">
                <div class="card h-100 text-center rounded-2 shadow-sm admin-card bg-white p-3">
                    <div class="card-body">
                        <div class="icon-box bg-danger text-white">
                            <i class="fas fa-sign-out-alt fa-2x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Logout</h5>
                        <p class="text-muted small mb-0">End admin session</p>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm rounded-2 w-100 mt-3 fw-semibold">
                            <i class="fas fa-power-off me-1"></i> Exit Admin
                        </a>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <%@include file="../component/footer.jsp" %>

</body>
</html>