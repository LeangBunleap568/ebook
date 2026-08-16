<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="com.ebook.db.DBconnect" %>
<%@ page import="com.ebook.dao.impl.BookDAOImpl" %>
<%@ page import="com.ebook.dao.impl.UserDAOImpl" %>
<%@ page import="com.ebook.dao.impl.BookOrderDAOImpl" %>

<%-- Security Check --%>
<c:if test="${empty userobj or userobj.email != 'admin@gmail.com'}">
    <c:redirect url="../login.jsp"/>
</c:if>

<%
    // Safe Data Fetching inside Try-Catch Block
    try {
        Connection conn = DBconnect.getConn();
        if (conn != null) {
            BookDAOImpl bookDAO = new BookDAOImpl(conn);
            UserDAOImpl userDAO = new UserDAOImpl(conn);
            BookOrderDAOImpl orderDAO = new BookOrderDAOImpl(conn);
            
            request.setAttribute("totalBooks", bookDAO.countBooks());
            request.setAttribute("totalUsers", userDAO.countUsers());
            request.setAttribute("totalOrders", orderDAO.countOrders());
            request.setAttribute("activeTransactions", orderDAO.countActiveTransactions());
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App — Admin Dashboard</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        :root {
            --primary: #4e73df;
            --success: #1cc88a;
            --info:    #36b9cc;
            --warning: #f6c23e;
            --danger:  #e74a3b;
        }

        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }

        /* ── Admin Header (White Navbar) ── */
        .admin-header {
            background: #ffffff;
            padding: 0 24px;
            height: 56px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            border-bottom: 1px solid #e3e6f0;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .admin-header .brand { color: #2e59d9; font-size: 1.15rem; font-weight: 700; }
        .logout-btn {
            background: var(--danger);
            color: #fff; border-radius: 50px; padding: 4px 14px;
            font-size: 12px; text-decoration: none; transition: all 0.2s;
        }
        .logout-btn:hover { background: #c0392b; color: #fff; }

        /* ── Stat Cards (Reduced Padding) ── */
        .stat-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
            transition: transform 0.2s;
            position: relative;
        }
        .stat-card:hover { transform: translateY(-3px); }
        .stat-card .card-body { padding: 14px 18px; }
        .stat-card .stat-label {
            font-size: 11px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.5px; opacity: 0.8; margin-bottom: 2px;
        }
        .stat-card .stat-value { font-size: 1.8rem; font-weight: 800; line-height: 1.1; }
        .stat-card .stat-bg-icon {
            position: absolute; right: 14px; top: 50%; transform: translateY(-50%);
            font-size: 2.8rem; opacity: 0.15;
        }
        .sc-primary { background: linear-gradient(135deg, #4e73df, #3a5fca); color: #fff; }
        .sc-success { background: linear-gradient(135deg, #1cc88a, #15a97a); color: #fff; }
        .sc-warning { background: linear-gradient(135deg, #f6c23e, #e0a800); color: #fff; }
        .sc-info    { background: linear-gradient(135deg, #36b9cc, #1da6b9); color: #fff; }

        /* ── Quick Action Cards (Compact Layout) ── */
        .action-card {
            border: 1px solid #e3e6f0;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            transition: transform 0.2s;
            text-align: center;
            background: #fff;
        }
        .action-card:hover { transform: translateY(-3px); box-shadow: 0 6px 14px rgba(0,0,0,0.08); }
        .action-card .icon-circle {
            width: 48px; height: 48px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px; margin: 0 auto 8px;
        }
        .action-card .card-body { padding: 16px 12px; }
        .action-card h6 { font-weight: 700; font-size: 0.95rem; margin-bottom: 2px; }
        .action-card p { font-size: 11px; color: #777; margin-bottom: 10px; }
        .action-card .action-btn {
            border-radius: 50px; padding: 4px 16px;
            font-weight: 600; font-size: 12px; text-decoration: none; display: inline-block;
        }

        /* ── Section Label (Compact Spacing) ── */
        .section-label {
            font-size: 11px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.5px; color: #666; margin-bottom: 8px;
        }
    </style>
</head>
<body>

    <%-- Admin Top Header --%>
    <c:set var="activePage" value="home" scope="request" />
    <%@include file="../component/navbar.jsp" %>
    
    <%-- Flash Messages --%>
    <c:if test="${not empty succMsg}">
        <div class="container-fluid px-3 pt-2">
            <div class="alert alert-success alert-dismissible fade show shadow-sm py-2 mb-0" role="alert">
                <i class="fas fa-check-circle me-1"></i> ${succMsg}
                <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
            </div>
        </div>
        <c:remove var="succMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty failedMsg}">
        <div class="container-fluid px-3 pt-2">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm py-2 mb-0" role="alert">
                <i class="fas fa-exclamation-triangle me-1"></i> ${failedMsg}
                <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
            </div>
        </div>
        <c:remove var="failedMsg" scope="session"/>
    </c:if>

    <%-- Page Body --%>
    <div class="container-fluid px-3 py-3">

        <%-- Page Title --%>
        <div class="mb-3">
            <h5 class="fw-bold text-dark mb-0">Dashboard Overview</h5>
        </div>

        <%-- Section 1: Real-Time Stat Cards --%>
        <p class="section-label">Live Statistics</p>
        <div class="row g-2 mb-3">

            <div class="col-xl-3 col-sm-6">
                <div class="card stat-card sc-primary">
                    <div class="card-body">
                        <div class="stat-label">Total Books</div>
                        <div class="stat-value">
                            <c:out value="${not empty totalBooks ? totalBooks : '0'}"/>
                        </div>
                        <div class="mt-1" style="font-size:11px; opacity:0.85;">
                            <i class="fas fa-arrow-up me-1"></i> In catalog
                        </div>
                    </div>
                    <i class="fas fa-book stat-bg-icon"></i>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="card stat-card sc-success">
                    <div class="card-body">
                        <div class="stat-label">Total Users</div>
                        <div class="stat-value">
                            <c:out value="${not empty totalUsers ? totalUsers : '0'}"/>
                        </div>
                        <div class="mt-1" style="font-size:11px; opacity:0.85;">
                            <i class="fas fa-users me-1"></i> Registered
                        </div>
                    </div>
                    <i class="fas fa-users stat-bg-icon"></i>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="card stat-card sc-warning">
                    <div class="card-body">
                        <div class="stat-label">Total Orders</div>
                        <div class="stat-value">
                            <c:out value="${not empty totalOrders ? totalOrders : '0'}"/>
                        </div>
                        <div class="mt-1" style="font-size:11px; opacity:0.85;">
                            <i class="fas fa-shopping-bag me-1"></i> All time
                        </div>
                    </div>
                    <i class="fas fa-box-open stat-bg-icon"></i>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="card stat-card sc-info">
                    <div class="card-body">
                        <div class="stat-label">Active Transactions</div>
                        <div class="stat-value">
                            <c:out value="${not empty activeTransactions ? activeTransactions : '0'}"/>
                        </div>
                        <div class="mt-1" style="font-size:11px; opacity:0.85;">
                            <i class="fas fa-exchange-alt me-1"></i> Processing
                        </div>
                    </div>
                    <i class="fas fa-exchange-alt stat-bg-icon"></i>
                </div>
            </div>

        </div>

        <%-- Section 2: Quick Action Cards --%>
        <p class="section-label">Quick Navigation</p>
        <div class="row g-2 mb-3">

            <%-- Add Books --%>
            <div class="col-xl-3 col-sm-6">
                <div class="card action-card">
                    <div class="card-body">
                        <div class="icon-circle bg-primary bg-opacity-10">
                            <i class="fas fa-plus-circle text-primary"></i>
                        </div>
                        <h6 class="text-dark">Add Books</h6>
                        <p>Create new book listings</p>
                        <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="action-btn btn btn-primary">
                            <i class="fas fa-plus me-1"></i> Open Form
                        </a>
                    </div>
                </div>
            </div>

            <%-- All Books --%>
            <div class="col-xl-3 col-sm-6">
                <div class="card action-card">
                    <div class="card-body">
                        <div class="icon-circle bg-success bg-opacity-10">
                            <i class="fas fa-book-open text-success"></i>
                        </div>
                        <h6 class="text-dark">All Books</h6>
                        <p>Manage, update & delete books</p>
                        <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="action-btn btn btn-success">
                            <i class="fas fa-list me-1"></i> View All
                        </a>
                    </div>
                </div>
            </div>

            <%-- Orders --%>
            <div class="col-xl-3 col-sm-6">
                <div class="card action-card">
                    <div class="card-body">
                        <div class="icon-circle bg-warning bg-opacity-10">
                            <i class="fas fa-box-open text-warning"></i>
                        </div>
                        <h6 class="text-dark">Orders</h6>
                        <p>View all customer orders</p>
                        <a href="${pageContext.request.contextPath}/admin/all_order.jsp" class="action-btn btn btn-warning text-dark">
                            <i class="fas fa-truck me-1"></i> View Orders
                        </a>
                    </div>
                </div>
            </div>

            <%-- Logout --%>
            <div class="col-xl-3 col-sm-6">
                <div class="card action-card">
                    <div class="card-body">
                        <div class="icon-circle bg-danger bg-opacity-10">
                            <i class="fas fa-sign-out-alt text-danger"></i>
                        </div>
                        <h6 class="text-dark">Logout</h6>
                        <p>End the current admin session</p>
                        <a href="${pageContext.request.contextPath}/logout" class="action-btn btn btn-danger">
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

