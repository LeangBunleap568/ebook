<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.app.entity.*, com.app.dao.impl.*, com.app.db.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Recent Books - Classic Modern</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        :root { --c-bg: #f4f6f8; --c-surface: #ffffff; --c-border: #cbd5e1; --c-text: #1e293b; --c-muted: #64748b; --c-accent: #2d6a4f; --c-accent-hover: #1b4332; --c-price: #b91c1c; --c-recent-badge: #3b82f6; }
        *, *::before, *::after { border-radius: 0 !important; }
        body { background-color: var(--c-bg) !important; color: var(--c-text); font-family: system-ui, -apple-system, sans-serif; }
        .section-header { border-bottom: 2px solid var(--c-border); padding-bottom: 0.85rem; }
        .section-title { color: var(--c-text); font-weight: 800; font-size: 1.25rem; text-transform: uppercase; }
        .book-card { border: 2px solid var(--c-border) !important; background: var(--c-surface) !important; transition: border-color 0.2s ease; }
        .book-card:hover { border-color: var(--c-accent) !important; }
        .book-img-wrapper { height: 210px; background: #fff; border: 1px solid var(--c-border); display: flex; align-items: center; justify-content: center; }
        .book-img { height: 100%; width: 100%; object-fit: contain; padding: 0.5rem; }
        .price-text { color: var(--c-price); font-size: 1.15rem; font-weight: 800; }
        .btn-add-cart { background: var(--c-accent); border: none; color: #fff; font-weight: 700; font-size: 0.8rem; text-transform: uppercase; }
        .btn-add-cart:hover { background: var(--c-accent-hover); color: #fff; }
        .btn-view-details { border: 1px solid #94a3b8; background: #fff; color: var(--c-text); font-weight: 700; font-size: 0.8rem; text-transform: uppercase; }
        .btn-view-details:hover { background: var(--c-text); color: #fff; }
        .badge-custom { font-size: 0.65rem; padding: 4px 8px; text-transform: uppercase; font-weight: 800; color: #fff; display: inline-block; background: var(--c-recent-badge); }
        @media (max-width: 400px) {
            .book-img-wrapper { height: 160px; }
            .book-card { padding: 0.5rem !important; }
        }
    </style>
</head>
<body>
    <%@include file="../component/navbar.jsp" %>

    <div class="container my-5">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-4 section-header">
            <h4 class="section-title mb-0 d-flex align-items-center">
                <i class="fas fa-history me-2" style="color: var(--c-recent-badge);"></i> All Recent Books
            </h4>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-sm btn-view-details px-3 py-1.5">
                <i class="fas fa-arrow-left me-1"></i> Back to Home
            </a>
        </div>

        <% 
            java.sql.Connection conn = DBconnect.getConn();
            if (conn == null) {
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            BookDAOImpl dao = new BookDAOImpl(conn);
            List<BookDtls> list = dao.getAllRecentBook();
            if (list == null) list = new java.util.ArrayList<>();
            java.text.DecimalFormat formatter = new java.text.DecimalFormat("#,###");
        %>

        <% if (list == null || list.isEmpty()) { %>
            <div class="row justify-content-center my-5">
                <div class="col-md-6 text-center">
                    <div class="p-5 border border-2 bg-white" style="border-color: var(--c-border) !important;">
                        <div class="mb-3">
                            <i class="fas fa-book-open fa-3x" style="color: var(--c-muted);"></i>
                        </div>
                        <h5 class="fw-bold mb-2 text-uppercase">No Recent Books Available</h5>
                        <p class="text-muted small mb-4">There are no recent books available at the moment.</p>
                        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-add-cart px-4 py-2">
                            <i class="fas fa-home me-2"></i>Back to Home
                        </a>
                    </div>
                </div>
            </div>
        <% } else { %>
            <div class="row g-4">
                <% for (BookDtls b : list) { 
                    String price = "0";
                    try { price = formatter.format(Double.parseDouble(b.getPrice())); } catch (Exception e) { price = b.getPrice(); }
                %>
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3">
                        <div class="book-img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="book-img" alt="<%= b.getBookName() %>" onerror="this.src='${pageContext.request.contextPath}/book/default_book.svg';">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge badge-custom mb-2">Recent</span>
                                <h6 class="card-title text-truncate fw-bold mb-1"><%= b.getBookName() %></h6>
                                <p class="small text-truncate mb-2 text-muted">Author: <%= b.getAuthor() %></p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold price-text mb-2">$<%= price %></div>
                                <div class="d-flex flex-wrap gap-2">
                                    <a href="${pageContext.request.contextPath}/user/cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-add-cart btn-sm w-50 py-1.5"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="${pageContext.request.contextPath}/user/view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-view-details btn-sm w-50 py-1.5"><i class="fas fa-eye me-1"></i>View</a>
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