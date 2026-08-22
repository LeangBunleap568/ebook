<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.app.dao.impl.BookDAOImpl, com.app.db.DBconnect, com.app.entity.BookDtls, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ebook Store Classic Modern</title>
    <%@include file="component/rootCss.jsp" %>
    <style>
        :root { --c-bg: #f4f6f8; --c-surface: #ffffff; --c-border: #cbd5e1; --c-text: #1e293b; --c-muted: #64748b; --c-accent: #2d6a4f; --c-accent-hover: #1b4332; --c-price: #b91c1c; }
        *, *::before, *::after { border-radius: 0 !important; }
        body { background-color: var(--c-bg) !important; color: var(--c-text); font-family: system-ui, -apple-system, sans-serif; }
        .section-header { border-bottom: 2px solid var(--c-border); padding-bottom: 0.85rem; }
        .section-title { color: var(--c-text); font-weight: 800; font-size: 1.2rem; text-transform: uppercase; }
        .btn-view-all { border: 1px solid #94a3b8; color: var(--c-text); font-weight: 700; font-size: 0.8rem; background: #fff; text-transform: uppercase; }
        .btn-view-all:hover { background: var(--c-accent); color: #fff; border-color: var(--c-accent); }
        .horizontal-scroll-container { display: flex; overflow-x: auto; padding: 1rem 0.25rem; gap: 1.25rem; cursor: grab; user-select: none; }
        .horizontal-scroll-container::-webkit-scrollbar { height: 6px; }
        .horizontal-scroll-container::-webkit-scrollbar-thumb { background: #94a3b8; }
        .scroll-item { flex: 0 0 240px; max-width: 240px; }
        .book-card { border: 2px solid var(--c-border) !important; background: var(--c-surface) !important; }
        .book-card:hover { border-color: var(--c-accent) !important; }
        .book-img-wrapper { height: 200px; background: #fff; border: 1px solid var(--c-border); display: flex; align-items: center; justify-content: center; }
        .book-img { height: 100%; width: 100%; object-fit: contain; padding: 0.5rem; pointer-events: none; }
        .price-text { color: var(--c-price); font-size: 1.15rem; font-weight: 800; }
        .btn-add-cart { background: var(--c-accent); border: none; color: #fff; font-weight: 700; font-size: 0.8rem; text-transform: uppercase; }
        .btn-add-cart:hover { background: var(--c-accent-hover); color: #fff; }
        .btn-view-details { border: 1px solid #94a3b8; background: #fff; color: var(--c-text); font-weight: 700; font-size: 0.8rem; text-transform: uppercase; }
        .btn-view-details:hover { background: var(--c-text); color: #fff; }
        .badge-custom { font-size: 0.65rem; padding: 4px 8px; text-transform: uppercase; font-weight: 800; color: #fff; display: inline-block; }
    </style>
</head>
<body>
    <%@include file="component/navbar.jsp" %>
    <% 
        java.sql.Connection conn = DBconnect.getConn();
        if (conn == null) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }
        BookDAOImpl dao = new BookDAOImpl(conn); 
    %>

    <div class="container my-5">
        <!-- 1. Recent Books -->
        <section class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-3 section-header">
                <h4 class="section-title mb-0"><i class="fas fa-clock me-2" style="color: #d97706;"></i> Recent Books</h4>
                <a href="${pageContext.request.contextPath}/user/all_recent_book.jsp" class="btn btn-sm btn-view-all px-3 py-1.5">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>
            <div class="horizontal-scroll-container">
                <% List<BookDtls> list1 = dao.getAllRecentBook();
                   if (list1 == null || list1.isEmpty()) { %>
                    <div class="text-center w-100 py-4 border border-dashed bg-white"><p class="text-muted fw-bold mb-0">No Recent Books Available</p></div>
                <% } else { for (BookDtls b : list1) { %>
                    <div class="scroll-item">
                        <div class="card h-100 book-card p-3">
                            <div class="book-img-wrapper mb-3"><img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="book-img" onerror="this.src='${pageContext.request.contextPath}/book/default_book.svg';"></div>
                            <div class="card-body p-0 d-flex flex-column justify-content-between">
                                <div><span class="badge badge-custom mb-2" style="background:#d97706;">Recent</span><h6 class="card-title text-truncate fw-bold mb-1"><%= b.getBookName() %></h6><p class="small text-truncate mb-2 text-muted">Author: <%= b.getAuthor() %></p></div>
                                <div class="pt-2 border-top mt-2">
                                    <div class="fw-bold price-text mb-2">$<%= new java.text.DecimalFormat("#,##0.00").format(Double.parseDouble(b.getPrice())) %></div>
                                    <div class="d-flex gap-2">
                                        <a href="${pageContext.request.contextPath}/cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-add-cart btn-sm w-50 py-1.5"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                        <a href="${pageContext.request.contextPath}/user/view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-view-details btn-sm w-50 py-1.5"><i class="fas fa-eye me-1"></i>View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <% }} %>
            </div>
        </section>

        <!-- 2. New Books -->
        <section class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-3 section-header">
                <h4 class="section-title mb-0"><i class="fas fa-sparkles me-2" style="color: var(--c-accent);"></i> New Books</h4>
                <a href="${pageContext.request.contextPath}/user/all_new_book.jsp" class="btn btn-sm btn-view-all px-3 py-1.5">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>
            <div class="horizontal-scroll-container">
                <% List<BookDtls> list2 = dao.getAllNewBook();
                   if (list2 == null || list2.isEmpty()) { %>
                    <div class="text-center w-100 py-4 border border-dashed bg-white"><p class="text-muted fw-bold mb-0">No New Books Available</p></div>
                <% } else { for (BookDtls b : list2) { %>
                    <div class="scroll-item">
                        <div class="card h-100 book-card p-3">
                            <div class="book-img-wrapper mb-3"><img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="book-img" onerror="this.src='${pageContext.request.contextPath}/book/default_book.svg';"></div>
                            <div class="card-body p-0 d-flex flex-column justify-content-between">
                                <div><span class="badge badge-custom mb-2" style="background:var(--c-accent);">New</span><h6 class="card-title text-truncate fw-bold mb-1"><%= b.getBookName() %></h6><p class="small text-truncate mb-2 text-muted">Author: <%= b.getAuthor() %></p></div>
                                <div class="pt-2 border-top mt-2">
                                    <div class="fw-bold price-text mb-2">$<%= new java.text.DecimalFormat("#,##0.00").format(Double.parseDouble(b.getPrice())) %></div>
                                    <div class="d-flex gap-2">
                                      <a href="${pageContext.request.contextPath}/user/cart?bid=<%= b.getBookId() %>" class="btn btn-add-cart btn-sm w-50 py-1.5">
    <i class="fas fa-cart-plus me-1"></i>Add
</a>
                                        <a href="${pageContext.request.contextPath}/user/view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-view-details btn-sm w-50 py-1.5"><i class="fas fa-eye me-1"></i>View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <% }} %>
            </div>
        </section>
    </div>

    <%@include file="component/footer.jsp" %>
    <script>
        document.querySelectorAll(".horizontal-scroll-container").forEach(s => {
            let isDown = false, startX, scrollLeft, isDragging = false;
            s.addEventListener("mousedown", e => { isDown = true; isDragging = false; startX = e.pageX - s.offsetLeft; scrollLeft = s.scrollLeft; });
            s.addEventListener("mouseleave", () => isDown = false);
            s.addEventListener("mouseup", () => isDown = false);
            s.addEventListener("mousemove", e => { if(!isDown) return; const walk = (e.pageX - s.offsetLeft - startX) * 1.5; if(Math.abs(walk) > 5) isDragging = true; e.preventDefault(); s.scrollLeft = scrollLeft - walk; });
            s.addEventListener("click", e => { if(isDragging) { e.preventDefault(); e.stopPropagation(); } }, true);
            s.addEventListener("wheel", e => { if(e.deltaY !== 0) { e.preventDefault(); s.scrollLeft += e.deltaY; } });
        });
    </script>
</body>
</html>