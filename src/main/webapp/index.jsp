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
    <title>Ebook App - Home</title>
    <%@include file="component/rootCss.jsp" %>
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
        
        .btn-view-all {
            border-color: var(--color-dark-slate);
            color: var(--color-dark-slate);
            transition: all 0.2s ease;
        }

        .btn-view-all:hover {
            background-color: var(--color-dark-slate);
            color: var(--color-text-light);
        }

        /* Horizontal Scroll Container */
        .horizontal-scroll-container {
            display: flex;
            flex-wrap: nowrap;
            overflow-x: auto;
            scroll-behavior: auto; /* ដក smooth ចេញពេល drag ដើម្បីកុំឱ្យទាក់ */
            -webkit-overflow-scrolling: touch;
            padding-bottom: 1rem;
            padding-top: 0.5rem;
            gap: 1.25rem;
            cursor: grab;
            user-select: none;
        }

        .horizontal-scroll-container:active {
            cursor: grabbing;
        }

        /* Hide scrollbars */
        .horizontal-scroll-container::-webkit-scrollbar {
            display: none;
        }
        .horizontal-scroll-container {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        .scroll-item {
            flex: 0 0 240px;
            max-width: 240px;
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
            height: 100%;
            width: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
            padding: 0.5rem;
            pointer-events: none; /* ការពារកុំឱ្យ Drag រូបភាព */
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
            border-color: var(--color-coral-pink);
            color: var(--color-text-light);
            transition: background-color 0.2s ease;
        }

        .btn-add-cart:hover {
            background-color: #d94854;
            border-color: #d94854;
            color: var(--color-text-light);
        }

        .btn-view-details {
            border-color: var(--color-input-border);
            color: var(--color-text-dark);
        }

        .btn-view-details:hover {
            background-color: var(--color-input-bg);
            color: var(--color-text-dark);
        }

        .badge-recent {
            background-color: rgba(78, 115, 223, 0.15) !important;
            color: #4e73df !important;
            border-radius: 50px !important;
            padding: 0.4em 0.8em !important;
        }

        .badge-new {
            background-color: rgba(28, 200, 138, 0.15) !important;
            color: #1cc88a !important;
            border-radius: 50px !important;
            padding: 0.4em 0.8em !important;
        }

        .badge-old {
            background-color: rgba(133, 135, 150, 0.15) !important;
            color: #858796 !important;
            border-radius: 50px !important;
            padding: 0.4em 0.8em !important;
        }
    </style>
</head>
<body>

    <%@include file="component/navbar.jsp" %>

    <div class="container my-5">

        <!-- 1. Recent Books Section -->
        <section id="recent-books" class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                <h4 class="section-title mb-0 d-flex align-items-center">
                    <i class="fas fa-clock me-2" style="color: var(--color-amber-yellow);"></i> Recent Books
                </h4>
                <a href="${pageContext.request.contextPath}/user/all_recent_book.jsp" class="btn btn-sm btn-view-all rounded-2 px-3">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>

            <div class="horizontal-scroll-container">
                <% 
                    BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
                    // ប្រើ Method ដែលមិនបាច់ LIMIT 4 (ឧ. getAllRecentBook)
                    List<BookDtls> recentBooks = dao.getAllRecentBook();
                    if (recentBooks == null) recentBooks = new java.util.ArrayList<>();
                %>
                <% if (recentBooks.isEmpty()) { %>
                    <div class="text-center w-100 py-5">
                        <i class="fas fa-book-open fa-2x text-muted mb-3 d-block"></i>
                        <p class="text-muted fw-semibold mb-0">No Recent Books Available At The Moment</p>
                    </div>
                <% } else { %>
                    <% for (BookDtls b : recentBooks) { %>
                    <div class="scroll-item">
                        <div class="card h-100 book-card p-3 shadow-sm">
                            <div class="book-img-wrapper mb-3">
                                <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="book-img" alt="<%= b.getBookName() %>" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/book/default_book.svg';">
                            </div>
                            <div class="card-body p-0 d-flex flex-column justify-content-between">
                                <div>
                                    <span class="badge badge-recent rounded-1 mb-2 fw-semibold">Recent</span>
                                    <h6 class="card-title text-truncate fw-bold mb-1" style="color: var(--color-text-dark);"><%= b.getBookName() %></h6>
                                    <p class="small text-truncate mb-2" style="color: var(--color-text-muted);">Author: <%= b.getAuthor() %></p>
                                </div>
                                <div class="pt-2 border-top mt-2">
                                    <div class="fw-bold price-text mb-2"><%= new java.text.DecimalFormat("#,###").format(Double.parseDouble(b.getPrice())) %> ៛</div>
                                    <div class="d-grid gap-1 d-flex">
                                        <a href="${pageContext.request.contextPath}/cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-add-cart btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                        <a href="${pageContext.request.contextPath}/user/view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-view-details btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                <% } %>
            </div>
        </section>

        <!-- 2. New Books Section -->
        <section id="new-books" class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                <h4 class="section-title mb-0 d-flex align-items-center">
                    <i class="fas fa-sparkles me-2" style="color: var(--color-emerald-green);"></i> New Books
                </h4>
                <a href="${pageContext.request.contextPath}/user/all_new_book.jsp" class="btn btn-sm btn-view-all rounded-2 px-3">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>

            <div class="horizontal-scroll-container">
                <% 
                    List<BookDtls> newBooks = dao.getAllNewBook();
                    if (newBooks == null) newBooks = new java.util.ArrayList<>();
                %>
                <% if (newBooks.isEmpty()) { %>
                    <div class="text-center w-100 py-5">
                        <i class="fas fa-book-open fa-2x text-muted mb-3 d-block"></i>
                        <p class="text-muted fw-semibold mb-0">No New Books Available At The Moment</p>
                    </div>
                <% } else { %>
                    <% for (BookDtls b : newBooks) { %>
                    <div class="scroll-item">
                        <div class="card h-100 book-card p-3 shadow-sm">
                            <div class="book-img-wrapper mb-3">
                                <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="book-img" alt="<%= b.getBookName() %>" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/book/default_book.svg';">
                            </div>
                            <div class="card-body p-0 d-flex flex-column justify-content-between">
                                <div>
                                    <span class="badge badge-new rounded-1 mb-2 fw-semibold">New</span>
                                    <h6 class="card-title text-truncate fw-bold mb-1" style="color: var(--color-text-dark);"><%= b.getBookName() %></h6>
                                    <p class="small text-truncate mb-2" style="color: var(--color-text-muted);">Author: <%= b.getAuthor() %></p>
                                </div>
                                <div class="pt-2 border-top mt-2">
                                    <div class="fw-bold price-text mb-2"><%= new java.text.DecimalFormat("#,###").format(Double.parseDouble(b.getPrice())) %> ៛</div>
                                    <div class="d-grid gap-1 d-flex">
                                        <a href="${pageContext.request.contextPath}/cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-add-cart btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                        <a href="${pageContext.request.contextPath}/user/view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-view-details btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                <% } %>
            </div>
        </section>

        <!-- 3. Old Books Section -->
        <section id="old-books" class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                <h4 class="section-title mb-0 d-flex align-items-center">
                    <i class="fas fa-history me-2" style="color: var(--color-text-muted);"></i> Old Books
                </h4>
                <a href="${pageContext.request.contextPath}/user/all_old_book.jsp" class="btn btn-sm btn-view-all rounded-2 px-3">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>

            <div class="horizontal-scroll-container">
                <% 
                    List<BookDtls> oldBooks = dao.getAllOldBook();
                    if (oldBooks == null) oldBooks = new java.util.ArrayList<>();
                %>
                <% if (oldBooks.isEmpty()) { %>
                    <div class="text-center w-100 py-5">
                        <i class="fas fa-book-open fa-2x text-muted mb-3 d-block"></i>
                        <p class="text-muted fw-semibold mb-0">No Old Books Available At The Moment</p>
                    </div>
                <% } else { %>
                    <% for (BookDtls b : oldBooks) { %>
                    <div class="scroll-item">
                        <div class="card h-100 book-card p-3 shadow-sm">
                            <div class="book-img-wrapper mb-3">
                                <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="book-img" alt="<%= b.getBookName() %>" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/book/default_book.svg';">
                            </div>
                            <div class="card-body p-0 d-flex flex-column justify-content-between">
                                <div>
                                    <span class="badge badge-old rounded-1 mb-2 fw-semibold">Old</span>
                                    <h6 class="card-title text-truncate fw-bold mb-1" style="color: var(--color-text-dark);"><%= b.getBookName() %></h6>
                                    <p class="small text-truncate mb-2" style="color: var(--color-text-muted);">Author: <%= b.getAuthor() %></p>
                                </div>
                                <div class="pt-2 border-top mt-2">
                                    <div class="fw-bold price-text mb-2"><%= new java.text.DecimalFormat("#,###").format(Double.parseDouble(b.getPrice())) %> ៛</div>
                                    <div class="d-grid gap-1 d-flex">
                                        <a href="${pageContext.request.contextPath}/cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-add-cart btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                        <a href="${pageContext.request.contextPath}/user/view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-view-details btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                <% } %>
            </div>
        </section>

    </div>

    <%@include file="component/footer.jsp" %>

    <!-- Horizontal Drag Scroll Script -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const scrollContainers = document.querySelectorAll(".horizontal-scroll-container");

            scrollContainers.forEach((slider) => {
                let isDown = false;
                let startX;
                let scrollLeft;
                let isDragging = false;

                // Mouse Drag Handler
                slider.addEventListener("mousedown", (e) => {
                    isDown = true;
                    isDragging = false;
                    startX = e.pageX - slider.offsetLeft;
                    scrollLeft = slider.scrollLeft;
                });

                slider.addEventListener("mouseleave", () => {
                    isDown = false;
                });

                slider.addEventListener("mouseup", () => {
                    isDown = false;
                });

                slider.addEventListener("mousemove", (e) => {
                    if (!isDown) return;
                    const x = e.pageX - slider.offsetLeft;
                    const walk = (x - startX) * 1.5;
                    
                    if (Math.abs(walk) > 5) {
                        isDragging = true;
                    }
                    
                    e.preventDefault();
                    slider.scrollLeft = scrollLeft - walk;
                });

                // Prevent click event when dragging
                slider.addEventListener("click", (e) => {
                    if (isDragging) {
                        e.preventDefault();
                        e.stopPropagation();
                    }
                }, true);

                // Mouse Wheel Handler
                slider.addEventListener("wheel", (e) => {
                    if (e.deltaY !== 0) {
                        e.preventDefault();
                        slider.scrollLeft += e.deltaY;
                    }
                });
            });
        });
    </script>
</body>
</html>

