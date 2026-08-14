<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.dao.impl.BookDAOImpl" %>
<%@ page import="com.db.DBconnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App - Home</title>
    <%@include file="component/rootCss.jsp" %>
    <style>
        .book-card {
            transition: all 0.25s ease-in-out;
            border: 1px solid rgba(0, 0, 0, 0.06) !important;
            border-radius: 12px !important;
        }
        .book-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08) !important;
        }
        .book-img-wrapper {
            height: 220px;
            overflow: hidden;
            border-radius: 8px;
            background-color: #f8f9fa;
        }
        .book-img {
            height: 100%;
            width: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        .book-card:hover .book-img {
            transform: scale(1.04);
        }
    </style>
</head>
<body class="bg-light">

    <%@include file="component/navbar.jsp" %>

    <!-- Main Content Container -->
    <div class="container my-5">

        <!-- 1. Recent Books Section -->
        <section id="recent-books" class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h4 class="fw-bold mb-0 text-dark d-flex align-items-center">
                    <i class="fas fa-clock text-primary me-2"></i> Recent Books
                </h4>
                <a href="all_recent_book.jsp" class="btn btn-sm btn-outline-primary rounded-2 px-3">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>

            <div class="row g-4">
                <% 
                    BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
                    List<BookDtls> recentBooks = dao.getRecentBooks();
                    for (BookDtls b : recentBooks) { 
                %>
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="book-img" alt="<%= b.getBookName() %>" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/book/default_book.svg';">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-primary-subtle text-primary rounded-1 mb-2">Recent</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1"><%= b.getBookName() %></h6>
                                <p class="text-muted small text-truncate mb-2">Author: <%= b.getAuthor() %></p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-primary mb-2"><%= b.getPrice() %> ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </section>

        <!-- 2. New Books Section -->
        <section id="new-books" class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h4 class="fw-bold mb-0 text-dark d-flex align-items-center">
                    <i class="fas fa-sparkles text-success me-2"></i> New Books
                </h4>
                <a href="all_new_book.jsp" class="btn btn-sm btn-outline-success rounded-2 px-3">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>

            <div class="row g-4">
                <% 
                    List<BookDtls> newBooks = dao.getNewBook();
                    for (BookDtls b : newBooks) { 
                %>
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="book-img" alt="<%= b.getBookName() %>" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/book/default_book.svg';">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-success-subtle text-success rounded-1 mb-2">New</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1"><%= b.getBookName() %></h6>
                                <p class="text-muted small text-truncate mb-2">Author: <%= b.getAuthor() %></p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-success mb-2"><%= b.getPrice() %> ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </section>

        <!-- 3. Old Books Section -->
        <section id="old-books" class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h4 class="fw-bold mb-0 text-dark d-flex align-items-center">
                    <i class="fas fa-history text-secondary me-2"></i> Old Books
                </h4>
                <a href="all_old_book.jsp" class="btn btn-sm btn-outline-secondary rounded-2 px-3">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>

            <div class="row g-4">
                <% 
                    List<BookDtls> oldBooks = dao.getOldBooks();
                    for (BookDtls b : oldBooks) { 
                %>
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="book-img" alt="<%= b.getBookName() %>" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/book/default_book.svg';">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-secondary-subtle text-secondary rounded-1 mb-2">Old</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1"><%= b.getBookName() %></h6>
                                <p class="text-muted small text-truncate mb-2">Author: <%= b.getAuthor() %></p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-secondary mb-2"><%= b.getPrice() %> ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="view_books.jsp?id=<%= b.getBookId() %>" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </section>

    </div>

    <%@include file="component/footer.jsp" %>

</body>
</html>