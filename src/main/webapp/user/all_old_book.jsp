<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.dao.impl.BookDAOImpl" %>
<%@ page import="com.ebook.db.DBconnect" %>
<%@ page import="com.ebook.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Old Books</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        :root {
            --color-amber-yellow: #f5a623; 
            --color-coral-pink: #f05a66;   
            --color-emerald-green: #00b074; 
            --color-dark-slate: #2d404e;   
            --color-light-bg: #f5f7fa;     
            --color-card-white: #ffffff;   
            --color-input-bg: #eef2f5;     
            --color-input-border: #dcdfe3; 
            --color-text-dark: #2d404e;    
            --color-text-muted: #8c9ba5;   
            --color-text-light: #ffffff;   
        }

        body {
            background-color: var(--color-light-bg) !important;
            color: var(--color-text-dark);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .section-title {
            color: var(--color-dark-slate);
            font-weight: 700;
        }

        .book-card {
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            border: 1px solid var(--color-input-border) !important;
            border-radius: 12px !important;
            background-color: var(--color-card-white) !important;
        }

        .book-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 24px rgba(45, 64, 78, 0.12) !important;
        }

        .book-img-wrapper {
            height: 220px;
            overflow: hidden;
            border-radius: 8px;
            background-color: var(--color-input-bg);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .book-img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
            padding: 0.5rem;
        }

        .book-card:hover .book-img {
            transform: scale(1.05);
        }

        .price-text {
            color: var(--color-coral-pink);
            font-size: 1.1rem;
        }

        .btn-add-cart {
            background-color: var(--color-coral-pink);
            border: 1px solid var(--color-coral-pink);
            color: var(--color-text-light);
            transition: all 0.2s ease;
        }

        .btn-add-cart:hover {
            background-color: #d94854;
            border-color: #d94854;
            color: var(--color-text-light);
        }

        .btn-view-details {
            border: 1px solid var(--color-input-border);
            color: var(--color-text-dark);
            background-color: transparent;
            transition: all 0.2s ease;
        }

        .btn-view-details:hover {
            background-color: var(--color-input-bg);
            color: var(--color-text-dark);
        }

        .badge-old {
            background-color: rgba(245, 166, 35, 0.15) !important;
            color: var(--color-amber-yellow) !important;
        }

        .book-title {
            color: var(--color-text-dark);
        }

        .book-author {
            color: var(--color-text-muted);
        }
    </style>
</head>
<body>
    <%@include file="../component/navbar.jsp" %>

    <div class="container my-5">
        <div class="d-flex align-items-center justify-content-center mb-4 pb-2 border-bottom">
            <h4 class="section-title mb-0 d-flex align-items-center">
                <i class="fas fa-book me-2" style="color: var(--color-amber-yellow);"></i> All Old Books
            </h4>
        </div>

        <% 
            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
            List<BookDtls> list = dao.getAllOldBook();
            if (list == null) list = new java.util.ArrayList<>();
        %>

        <% if (list.isEmpty()) { %>
            <%-- Empty State: No old books --%>
            <div class="row justify-content-center my-5">
                <div class="col-md-5 col-sm-8">
                    <div class="card border-0 shadow-sm rounded-4 p-5 text-center">
                        <div class="mb-3">
                            <span style="display:inline-flex;align-items:center;justify-content:center;
                                         width:80px;height:80px;border-radius:50%;
                                         background:rgba(133,135,150,0.1);">
                                <i class="fas fa-book-open fa-2x text-muted"></i>
                            </span>
                        </div>
                        <h5 class="fw-bold text-secondary mb-1">No Old Books Available</h5>
                        <p class="text-muted small mb-4">
                            There are no old books in the catalog at the moment.<br>
                            Explore other categories instead!
                        </p>
                        <a href="${pageContext.request.contextPath}/index.jsp"
                           class="btn btn-primary rounded-pill px-4">
                            <i class="fas fa-home me-2"></i>Back to Home
                        </a>
                    </div>
                </div>
            </div>
        <% } else { %>
        <div class="row g-4">
            <% for (BookDtls b : list) { %>
            <div class="col-6 col-md-4 col-lg-3">
                <div class="card h-100 book-card p-3 shadow-sm">
                    <div class="book-img-wrapper mb-3">
                        <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" 
                             class="book-img" 
                             alt="<%= b.getBookName() %>" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/book/default_book.svg';">
                    </div>
                    <div class="card-body p-0 d-flex flex-column justify-content-between">
                        <div>
                            <span class="badge badge-old rounded-1 mb-2 fw-semibold">Old</span>
                            <h6 class="card-title book-title text-truncate fw-bold mb-1"><%= b.getBookName() %></h6>
                            <p class="small book-author text-truncate mb-2">Author: <%= b.getAuthor() %></p>
                        </div>
                        <div class="pt-2 border-top mt-2">
                            <div class="fw-bold price-text mb-2"><%= new java.text.DecimalFormat("#,###").format(Double.parseDouble(b.getPrice())) %> ៛</div>
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-add-cart btn-sm rounded-2 flex-fill text-center"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                <a href="${pageContext.request.contextPath}/view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-view-details btn-sm rounded-2 flex-fill text-center"><i class="fas fa-eye me-1"></i>View</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>

