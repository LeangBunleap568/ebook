<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="com.app.entity.*, com.app.dao.impl.*, com.app.db.*, java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Fetch search keyword and query book catalog --%>
<%
    String ch = request.getParameter("ch");
    if (ch == null) ch = "";
    pageContext.setAttribute("searchQuery", ch);

    try {
        java.sql.Connection conn = DBconnect.getConn();
        if (conn == null) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }
        BookDAOImpl dao = new BookDAOImpl(conn);
        List<BookDtls> books = dao.getBookBySearch(ch);
            if (books == null) books = new java.util.ArrayList<>();
pageContext.setAttribute("bookList", books);
    } catch (Exception e) {
        pageContext.setAttribute("bookList", null);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - Ebook Store</title>
    <%@include file="../component/rootCss.jsp" %>
    
    <style>
        :root {
            --cf-bg: #EFEFEF;
            --cf-header: #3B4752;
            --cf-orange: #F5A623;
            --cf-green: #5CB85C;
            --cf-text-dark: #333333;
            --cf-text-muted: #666666;
            --cf-badge-bg: #777777;
            --cf-border: #E0E0E0;
        }

        body {
            background-color: var(--cf-bg) !important;
            color: var(--cf-text-dark);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        }

        .cf-card {
            background-color: #ffffff;
            border: 1px solid var(--cf-border);
            border-radius: 4px;
            transition: box-shadow 0.2s ease;
        }

        .cf-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08) !important;
        }

        .book-img-container {
            height: 220px;
            overflow: hidden;
            background-color: #f7f7f7;
            border-bottom: 1px solid var(--cf-border);
        }

        .book-img-container img {
            height: 100%;
            width: 100%;
            object-fit: cover;
        }

        /* Color Scheme Adjustments */
        .badge-count {
            background-color: var(--cf-badge-bg);
            color: #ffffff;
            font-weight: 500;
            padding: 4px 8px;
            border-radius: 3px;
        }

        .badge-category {
            background-color: #E9ECEF;
            color: var(--cf-header);
            font-size: 0.75rem;
            border-radius: 2px;
        }

        .text-accent-orange {
            color: var(--cf-orange) !important;
        }

        .text-header-slate {
            color: var(--cf-header) !important;
        }

        .btn-cf-primary {
            background-color: var(--cf-green);
            color: #ffffff;
            border: none;
            border-radius: 3px;
            font-weight: 600;
        }

        .btn-cf-primary:hover {
            background-color: #4cae4c;
            color: #ffffff;
        }

        .btn-cf-outline {
            background-color: transparent;
            color: var(--cf-header);
            border: 1px solid var(--cf-border);
            border-radius: 3px;
        }

        .btn-cf-outline:hover {
            background-color: #f5f5f5;
            color: var(--cf-header);
        }

        .btn-cf-orange {
            background-color: var(--cf-orange);
            color: #ffffff;
            border: none;
            border-radius: 3px;
        }

        .btn-cf-orange:hover {
            background-color: #e0951d;
            color: #ffffff;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@include file="../component/navbar.jsp" %>

    <div class="container p-4 my-3 flex-grow-1">
        
        <!-- Search Header -->
        <div class="d-flex align-items-center justify-content-between mb-4 pb-2 border-bottom">
            <h4 class="fw-bold text-header-slate mb-0">
                <i class="fas fa-search text-accent-orange me-2"></i>Search Results for: 
                <span class="text-accent-orange">&ldquo;${fn:escapeXml(searchQuery)}&rdquo;</span>
            </h4>
            <c:if test="${not empty bookList}">
                <span class="badge badge-count">${fn:length(bookList)}</span>
            </c:if>
        </div>

        <c:choose>
            <%-- Empty State: No search results --%>
            <c:when test="${empty bookList}">
                <div class="row justify-content-center my-5">
                    <div class="col-md-6 col-sm-8">
                        <div class="cf-card p-5 text-center">
                            <div class="mb-3">
                                <span style="display:inline-flex;align-items:center;justify-content:center;
                                             width:70px;height:70px;border-radius:50%;
                                             background:#F3F4F5;">
                                    <i class="fas fa-search fa-2x text-muted"></i>
                                </span>
                            </div>
                            <h5 class="fw-bold text-header-slate mb-2">No Results Found</h5>
                            <p class="text-muted small mb-4">
                                No books matched &ldquo;<strong>${fn:escapeXml(searchQuery)}</strong>&rdquo;.<br>
                                Try searching for another term or return to the main dashboard.
                            </p>
                            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-cf-orange px-4 py-2">
                                <i class="fas fa-home me-2"></i>Back to Home
                            </a>
                        </div>
                    </div>
                </div>
            </c:when>

            <%-- Results Grid --%>
            <c:otherwise>
                <div class="row g-3">
                    <c:forEach var="b" items="${bookList}">
                        <div class="col-6 col-md-4 col-lg-3">
                            <div class="cf-card h-100 d-flex flex-column overflow-hidden">
                                <div class="book-img-container">
                                    <img src="${pageContext.request.contextPath}/book/${b.photoName}" alt="${fn:escapeXml(b.bookName)}">
                                </div>
                                
                                <div class="card-body d-flex flex-column p-3">
                                    <h6 class="fw-bold text-header-slate mb-1 text-truncate" title="${fn:escapeXml(b.bookName)}">
                                        <c:out value="${b.bookName}" />
                                    </h6>
                                    <p class="text-muted small mb-2 text-truncate">
                                        <c:out value="${b.author}" />
                                    </p>
                                    
                                    <div class="mb-3">
                                        <span class="badge badge-category px-2 py-1">
                                            <c:out value="${b.bookCategory}" />
                                        </span>
                                    </div>

                                    <%-- Declarative Currency Formatting via JSTL --%>
                                    <p class="fw-bold fs-6 mb-3 text-header-slate">
                                        $<fmt:formatNumber value="${not empty b.price ? b.price : 0}" type="number" pattern="#,##0.00" />
                                    </p>

                                    <div class="mt-auto d-flex gap-2">
                                        <a href="${pageContext.request.contextPath}/user/view_books.jsp?id=${b.bookId}" 
                                           class="btn btn-sm btn-cf-outline flex-fill">
                                            View
                                        </a>

                                        <%-- Auth Check before Adding to Cart --%>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.userobj}">
                                                <a href="${pageContext.request.contextPath}/user/cart?bid=${b.bookId}&uid=${sessionScope.userobj.id}" 
                                                   class="btn btn-sm btn-cf-primary flex-fill">
                                                    <i class="fas fa-cart-plus me-1"></i>Cart
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/login.jsp" 
                                                   class="btn btn-sm btn-cf-primary flex-fill">
                                                    <i class="fas fa-cart-plus me-1"></i>Cart
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>