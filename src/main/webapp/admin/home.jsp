<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="com.app.db.DBconnect" %>
<%@ page import="com.app.dao.impl.BookDAOImpl" %>
<%@ page import="com.app.dao.impl.UserDAOImpl" %>
<%@ page import="com.app.dao.impl.BookOrderDAOImpl" %>

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

            // Total Sales in USD
            double totalUSD = orderDAO.getTotalSalesUSD();
            request.setAttribute("totalSalesUSD", String.format("%.2f", totalUSD));
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
            --sidebar-bg: #0f5132;
            --sidebar-active: #0c4128;
            --brand-bg: #10b981;
            --topbar-bg: #0f5132;
            --body-bg: #f8f9fa;
        }

        body {
            background-color: var(--body-bg);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
            margin: 0;
            padding: 0;
            font-size: 13px;
            color: #333;
        }

        /* Layout Structure */
        .app-wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* Main Container */
        .main-container {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        /* Content Body */
        .content-body {
            padding: 0 20px 20px 20px;
        }

        .page-title {
            font-size: 20px;
            font-weight: 400;
            margin-bottom: 20px;
            color: #2c3e50;
        }

        /* CF Dashboard Card */
        .cf-card {
            background: #fff;
            border-radius: 4px;
            border: 1px solid #dcdcdc;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            padding: 15px;
            margin-bottom: 15px;
        }
        .cf-card-title {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 6px;
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 8px;
        }

        /* Clean Classic Table */
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
            padding: 8px 6px;
            border-bottom: 1px solid #f5f5f5;
            vertical-align: middle;
        }

        /* Minimal Status Tag */
        .tag-active {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 2px 6px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: 600;
        }

        /* Action Link */
        .link-btn {
            color: #10b981;
            text-decoration: none;
            font-weight: 500;
        }

        .link-btn:hover {
            text-decoration: underline;
        }

        /* Flash Message Styling */
        .alert-simple {
            border-radius: 4px;
            padding: 10px 14px;
            font-size: 13px;
            margin-bottom: 16px;
        }
    </style>
</head>
<body>

<%@include file="navbar.jsp" %>
        <%-- Breadcrumbs --%>
        <div class="breadcrumb-bar bg-white px-4 py-2 border-bottom mb-3 text-muted" style="font-size: 11px;">
            Home &gt; Admin Console &gt; Dashboard Overview
        </div>

        <%-- Main Content Area --%>
        <div class="content-body">

            <%-- Flash Messages --%>
            <c:if test="${not empty succMsg}">
                <div class="alert alert-success alert-simple alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-1"></i> ${succMsg}
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="succMsg" scope="session"/>
            </c:if>
            <c:if test="${not empty failedMsg}">
                <div class="alert alert-danger alert-simple alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-1"></i> ${failedMsg}
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="failedMsg" scope="session"/>
            </c:if>

            <div class="page-title">
                <div>System Dashboard Overview</div>
            </div>

            <div class="row">
                <%-- Left Column --%>
                <div class="col-md-7">
                    
                    <%-- Main Statistics --%>
                    <div class="cf-card">
                        <div class="cf-card-title">Database Records Overview</div>
                        <table class="table-cf">
                            <thead>
                                <tr>
                                    <th>Status</th>
                                    <th>Category</th>
                                    <th>Total Count</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><span class="tag-active">Active</span></td>
                                    <td><strong>Total Books Catalog</strong></td>
                                    <td><c:out value="${not empty totalBooks ? totalBooks : '0'}"/> Items</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/all_books.jsp" class="link-btn">View All</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span class="tag-active">Active</span></td>
                                    <td><strong>Registered User Accounts</strong></td>
                                    <td><c:out value="${not empty totalUsers ? totalUsers : '0'}"/> Users</td>
                                    <td><a href="${pageContext.request.contextPath}/admin/users" class="link-btn">Manage</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <%-- Orders Activity --%>
                    <div class="cf-card">
                        <div class="cf-card-title">Order Processing Activity</div>
                        <table class="table-cf">
                            <thead>
                                <tr>
                                    <th>Metric</th>
                                    <th>Total</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>Total Book Orders</strong></td>
                                    <td><c:out value="${not empty totalOrders ? totalOrders : '0'}"/></td>
                                    <td><a href="${pageContext.request.contextPath}/admin/orders.jsp" class="link-btn">Manage</a></td>
                                </tr>
                                <tr>
                                    <td><strong>Active Transactions</strong></td>
                                    <td><c:out value="${not empty activeTransactions ? activeTransactions : '0'}"/></td>
                                    <td><a href="${pageContext.request.contextPath}/admin/active_transactions.jsp" class="link-btn">Review</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>

                <%-- Right Column --%>
                <div class="col-md-5">

                    <%-- Financial Overview --%>
                    <div class="cf-card">
                        <div class="cf-card-title">Revenue Summary</div>
                        <table class="table-cf">
                            <thead>
                                <tr>
                                    <th>Currency</th>
                                    <th>Total Revenue</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>USD ($)</strong></td>
                                    <td class="text-success fw-bold">$<c:out value="${not empty totalSalesUSD ? totalSalesUSD : '0.00'}"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <%-- Shortcuts --%>
                    <div class="cf-card">
                        <div class="cf-card-title">Quick Actions</div>
                        <ul class="list-unstyled mb-0" style="font-size: 13px;">
                            <li class="mb-2"><a href="${pageContext.request.contextPath}/admin/add_books.jsp" class="link-btn">+ Add New Book to Store</a></li>
                            <li class="mb-2"><a href="${pageContext.request.contextPath}/admin/all_books.jsp" class="link-btn">→ Open Full Book Inventory</a></li>
                            <li><a href="${pageContext.request.contextPath}/admin/orders.jsp" class="link-btn">→ View All Customer Orders</a></li>
                        </ul>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
