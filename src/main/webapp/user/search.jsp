<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="com.ebook.dao.impl.BookDAOImpl" %>
<%@ page import="com.ebook.db.DBconnect" %>
<%@ page import="com.ebook.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%-- Fetch search keyword and query book catalog --%>
<%
    String ch = request.getParameter("ch");
    if (ch == null) ch = "";
    pageContext.setAttribute("searchQuery", ch);

    try {
        BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
        List<BookDtls> books = dao.getBookBySearch(ch);
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
        .book-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .book-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
        }
        .book-img-container {
            height: 230px;
            overflow: hidden;
            background-color: #f8f9fa;
        }
        .book-img-container img {
            height: 100%;
            width: 100%;
            object-fit: cover;
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">
    <%@include file="../component/navbar.jsp" %>

    <div class="container p-4 my-4 flex-grow-1">
        
        <!-- Search Header -->
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h4 class="fw-bold text-dark mb-0">
                <i class="fas fa-search text-warning me-2"></i>Search Results for: 
                <span class="text-primary">&ldquo;${fn:escapeXml(searchQuery)}&rdquo;</span>
            </h4>
            <c:if test="${not empty bookList}">
                <span class="badge bg-secondary rounded-pill">${fn:length(bookList)} items found</span>
            </c:if>
        </div>

        <c:choose>
            <%-- Empty State: No search results --%>
            <c:when test="${empty bookList}">
                <div class="row justify-content-center my-5">
                    <div class="col-md-5 col-sm-8">
                        <div class="card border-0 shadow-sm rounded-4 p-5 text-center">
                            <div class="mb-3">
                                <span style="display:inline-flex;align-items:center;justify-content:center;
                                             width:80px;height:80px;border-radius:50%;
                                             background:rgba(108,117,125,0.1);">
                                    <i class="fas fa-search fa-2x text-muted"></i>
                                </span>
                            </div>
                            <h5 class="fw-bold text-secondary mb-1">No Results Found</h5>
                            <p class="text-muted small mb-4">
                                No books matched &ldquo;<strong>${fn:escapeXml(searchQuery)}</strong>&rdquo;.<br>
                                Try a different keyword or browse our general catalog.
                            </p>
                            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary rounded-pill px-4">
                                <i class="fas fa-home me-2"></i>Back to Home
                            </a>
                        </div>
                    </div>
                </div>
            </c:when>

            <%-- Results Grid --%>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="b" items="${bookList}">
                        <div class="col-6 col-md-4 col-lg-3">
                            <div class="card h-100 book-card shadow-sm border-0 rounded-3 overflow-hidden">
                                <div class="book-img-container">
                                    <img src="${pageContext.request.contextPath}/book/${b.photoName}" alt="${fn:escapeXml(b.bookName)}">
                                </div>
                                
                                <div class="card-body d-flex flex-column p-3">
                                    <h6 class="fw-bold text-dark mb-1 text-truncate" title="${fn:escapeXml(b.bookName)}">${b.bookName}</h6>
                                    <p class="text-muted small mb-2 text-truncate">${b.author}</p>
                                    
                                    <div class="mb-2">
                                        <span class="badge bg-warning text-dark me-1">${b.bookCategory}</span>
                                    </div>

                                    <%-- Safe Currency Calculation --%>
                                    <c:set var="formattedPrice" value="0" />
                                    <%
                                        BookDtls item = (BookDtls) pageContext.getAttribute("b");
                                        double p = 0.0;
                                        if (item != null && item.getPrice() != null) {
                                            try {
                                                p = Double.parseDouble(item.getPrice());
                                            } catch (Exception e) {
                                                p = 0.0;
                                            }
                                        }
                                        pageContext.setAttribute("formattedPrice", new java.text.DecimalFormat("#,###").format(p));
                                    %>

                                    <p class="text-danger fw-bold fs-6 mb-3">${formattedPrice} ៛</p>

                                    <div class="mt-auto d-flex gap-2">
                                        <a href="${pageContext.request.contextPath}/user/view_books.jsp?id=${b.bookId}" 
                                           class="btn btn-sm btn-outline-primary flex-fill rounded-2">
                                            View
                                        </a>

                                        <%-- Auth Check before Adding to Cart --%>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.userobj}">
                                                <a href="${pageContext.request.contextPath}/cart?bid=${b.bookId}&uid=${sessionScope.userobj.id}" 
                                                   class="btn btn-sm btn-warning flex-fill rounded-2 fw-semibold">
                                                    <i class="fas fa-cart-plus me-1"></i>Cart
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/login.jsp" 
                                                   class="btn btn-sm btn-warning flex-fill rounded-2 fw-semibold">
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