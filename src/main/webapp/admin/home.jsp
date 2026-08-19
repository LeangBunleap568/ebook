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

            // Total Sales in USD and KHR (1 USD = 4000 KHR)
            double totalUSD = orderDAO.getTotalSalesUSD();
            long totalKHR = Math.round(totalUSD * 4000);
            request.setAttribute("totalSalesUSD", String.format("%.2f", totalUSD));
            request.setAttribute("totalSalesKHR", String.format("%,d", totalKHR));
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
    <title>Ebook App — Admin Console</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        :root {
            --sidebar-bg: #2c3846;
            --sidebar-active: #232d38;
            --brand-bg: #f39c12;
            --topbar-bg: #34495e;
            --body-bg: #eaedf1;
        }

        body {
            background-color: var(--body-bg);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
            margin: 0;
            padding: 0;
            font-size: 13px;
            color: #333;
        }

        /* App Wrapper Layout */
        .app-wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styling */
        .sidebar {
            width: 220px;
            background-color: var(--sidebar-bg);
            color: #95a5a6;
            flex-shrink: 0;
        }
        .sidebar .brand-header {
            background-color: var(--brand-bg);
            color: #fff;
            padding: 14px 20px;
            font-size: 16px;
            font-weight: 600;
        }
        .sidebar .nav-section {
            padding: 10px 0;
        }
        .sidebar .nav-item-title {
            padding: 8px 20px;
            color: #bdc3c7;
            font-weight: 500;
        }
        .sidebar .nav-link-custom {
            display: block;
            padding: 8px 20px 8px 30px;
            color: #95a5a6;
            text-decoration: none;
            transition: all 0.2s;
        }
        .sidebar .nav-link-custom:hover {
            color: #fff;
            background: rgba(255,255,255,0.05);
        }
        .sidebar .nav-link-custom.active {
            color: #fff;
            background-color: var(--sidebar-active);
        }

        /* Main Content Container */
        .main-container {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        /* Top Navigation Header */
        .top-navbar {
            height: 48px;
            background-color: var(--topbar-bg);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            color: #fff;
        }

        /* Breadcrumb Bar */
        .breadcrumb-bar {
            padding: 10px 20px;
            font-size: 11px;
            color: #7f8c8d;
        }

        /* Content Area */
        .content-body {
            padding: 0 20px 20px 20px;
        }

        .page-title {
            font-size: 20px;
            font-weight: 400;
            margin-bottom: 20px;
            color: #2c3e50;
        }

        /* Panel Cards Matching Image Layout */
        .cf-card {
            background: #fff;
            border-radius: 4px;
            border: 1px solid #dcdcdc;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            padding: 15px;
            margin-bottom: 15px;
        }
        .cf-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .cf-card-title {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .badge-count {
            background: #7f8c8d;
            color: #fff;
            font-size: 10px;
            padding: 2px 6px;
            border-radius: 3px;
        }

        /* Tables Inside Cards */
        .table-cf {
            width: 100%;
            border-collapse: collapse;
        }
        .table-cf th {
            text-align: left;
            font-size: 11px;
            color: #7f8c8d;
            padding: 8px 6px;
            border-bottom: 1px solid #eee;
            font-weight: 600;
        }
        .table-cf td {
            padding: 10px 6px;
            border-bottom: 1px solid #f5f5f5;
            vertical-align: middle;
        }
        
        .badge-status-running {
            background-color: #5cb85c;
            color: white;
            padding: 3px 6px;
            border-radius: 3px;
            font-size: 10px;
            font-weight: 600;
        }

        .action-link {
            color: #333;
            text-decoration: none;
            font-size: 12px;
        }
        .action-link:hover {
            color: #3498db;
        }
    </style>
</head>
<body>

<div class="app-wrapper">

    <%-- Sidebar Navigation --%>
    <div class="sidebar">
        <div class="brand-header">
            Ebook Admin
        </div>
        <div class="nav-section">
            <div class="nav-item-title">System Overview</div>
            <a href="#" class="nav-link-custom active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="nav-link-custom">Book Catalog</a>
            <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="nav-link-custom">Order Requests</a>
            <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="nav-link-custom">Management</a>
        </div>
    </div>

    <%-- Main Content Container --%>
    <div class="main-container">

        <%-- Top Bar Header --%>
        <div class="top-navbar">
            <div><i class="fas fa-bars cursor-pointer"></i></div>
            <div>
                <a href="${pageContext.request.contextPath}/logout" class="text-white text-decoration-none" title="Logout">
                    <i class="fas fa-user me-1"></i> Admin Exit
                </a>
            </div>
        </div>

        <%-- Breadcrumbs --%>
        <div class="breadcrumb-bar">
            Home &gt; Admin Console &gt; Dashboard
        </div>

        <%-- Flash Messages --%>
        <c:if test="${not empty succMsg}">
            <div class="px-4">
                <div class="alert alert-success alert-dismissible fade show py-2" role="alert">
                    <i class="fas fa-check-circle me-1"></i> ${succMsg}
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
            </div>
            <c:remove var="succMsg" scope="session"/>
        </c:if>
        <c:if test="${not empty failedMsg}">
            <div class="px-4">
                <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                    <i class="fas fa-exclamation-triangle me-1"></i> ${failedMsg}
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
            </div>
            <c:remove var="failedMsg" scope="session"/>
        </c:if>

        <%-- Content Body --%>
        <div class="content-body">
            <div class="page-title">
                Overview Status
            </div>

            <div class="row">
                <%-- Left Column Panels --%>
                <div class="col-lg-7">
                    
                    <%-- System Catalog Panel --%>
                    <div class="cf-card">
                        <div class="cf-card-header">
                            <div class="cf-card-title">
                                System Metrics <span class="badge-count">2</span>
                            </div>
                        </div>
                        <table class="table-cf">
                            <thead>
                                <tr>
                                    <th>Status</th>
                                    <th>Metric Category</th>
                                    <th>Total Records</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><span class="badge-status-running">active</span></td>
                                    <td>
                                        <div class="fw-bold">Total Books Catalog</div>
                                        <div class="text-muted" style="font-size:10px;">book_order & inventory database</div>
                                    </td>
                                    <td>
                                        <c:out value="${not empty totalBooks ? totalBooks : '0'}"/> Items
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="action-link me-2" title="View"><i class="fas fa-eye"></i></a>
                                        <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="action-link" title="Add Book"><i class="fas fa-plus-circle"></i></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span class="badge-status-running">active</span></td>
                                    <td>
                                        <div class="fw-bold">Registered Users</div>
                                        <div class="text-muted" style="font-size:10px;">user_dtls database</div>
                                    </td>
                                    <td>
                                        <c:out value="${not empty totalUsers ? totalUsers : '0'}"/> Accounts
                                    </td>
                                    <td>
                                        <a href="#" class="action-link" title="User Details"><i class="fas fa-eye"></i></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <%-- Orders Summary Panel --%>
                    <div class="cf-card">
                        <div class="cf-card-header">
                            <div class="cf-card-title">
                                Order Activity <span class="badge-count">2</span>
                            </div>
                        </div>
                        <table class="table-cf">
                            <thead>
                                <tr>
                                    <th>Type</th>
                                    <th>Count</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>Total Book Orders</strong></td>
                                    <td><c:out value="${not empty totalOrders ? totalOrders : '0'}"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="action-link"><i class="fas fa-list-alt"></i> Manage</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Active Transactions</strong></td>
                                    <td><c:out value="${not empty activeTransactions ? activeTransactions : '0'}"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/orders.jsp" class="action-link"><i class="fas fa-exchange-alt"></i> Review</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>

                <%-- Right Column Panels --%>
                <div class="col-lg-5">
                    
                    <%-- Revenue Financial Panel --%>
                    <div class="cf-card">
                        <div class="cf-card-header">
                            <div class="cf-card-title">
                                Sales Revenue Summary
                            </div>
                            <a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="btn btn-success btn-sm text-white text-decoration-none px-2 py-1" style="font-size:11px;">
                                + Add Book
                            </a>
                        </div>
                        <table class="table-cf">
                            <thead>
                                <tr>
                                    <th>Currency</th>
                                    <th>Total Generated</th>
                                    <th>Exchange Context</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>USD Revenue</strong></td>
                                    <td><span class="text-success fw-bold">$<c:out value="${not empty totalSalesUSD ? totalSalesUSD : '0.00'}"/></span></td>
                                    <td>Cumulative</td>
                                </tr>
                                <tr>
                                    <td><strong>KHR Revenue</strong></td>
                                    <td><span class="text-warning fw-bold"><c:out value="${not empty totalSalesKHR ? totalSalesKHR : '0'}"/> ៛</span></td>
                                    <td>1 USD = 4,000 ៛</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <%-- Management Quick Links Panel --%>
                    <div class="cf-card">
                        <div class="cf-card-header">
                            <div class="cf-card-title">
                                Quick Administrative Actions
                            </div>
                        </div>
                        <table class="table-cf">
                            <thead>
                                <tr>
                                    <th>Module</th>
                                    <th>Shortcut</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Create New Book Item</td>
                                    <td><a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="btn btn-outline-primary btn-sm py-0" style="font-size:11px;">Form</a></td>
                                </tr>
                                <tr>
                                    <td>Manage All Books</td>
                                    <td><a href="${pageContext.request.contextPath}/admin/allBook.jsp" class="btn btn-outline-secondary btn-sm py-0" style="font-size:11px;">Open Catalog</a></td>
                                </tr>
                                <tr>
                                    <td>View Orders Log</td>
                                    <td><a href="${pageContext.request.contextPath}/admin/orders.jsp" class="btn btn-outline-info btn-sm py-0" style="font-size:11px;">Orders</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>