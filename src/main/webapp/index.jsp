<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App - Home</title>
    <%@include file="component/rootCss.jsp" %>
</head>
<body class="bg-light">

    <%@include file="component/navbar.jsp" %>

    <!-- Hero Section -->
    <div class="text-center text-white py-5" style="background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?q=80&w=1400&auto=format&fit=crop'); background-size: cover; background-position: center; padding: 90px 20px;">
        <div class="container">
            <h1 class="display-4 fw-bold text-white">Ebook Management System</h1>
            <p class="lead text-light">Discover thousands of books, read anywhere, and upgrade your knowledge.</p>
        </div>
    </div>
    <!-- 1. Recent Books Section -->
    <div class="container my-5">
        <h3 class="text-center fw-bold mb-4">Recent Books</h3>
        <div class="row g-4">
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm">
                    <img src="https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?q=80&w=400&auto=format&fit=crop" class="card-img-top mx-auto mt-2" style="height: 180px; object-fit: cover; width: 80%;" alt="Book Cover">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold">Java Programming</h5>
                            <p class="text-muted small mb-1">Author: John Doe</p>
                            <p class="text-muted small">Category: Recent</p>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;">Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;">View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">$25</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 2. New Books Section -->
    <div class="container my-5">
        <h3 class="text-center fw-bold mb-4">New Books</h3>
        <div class="row g-4">
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm">
                    <img src="https://images.unsplash.com/photo-1528459801416-a9e53bbf4e17?q=80&w=400&auto=format&fit=crop" class="card-img-top mx-auto mt-2" style="height: 180px; object-fit: cover; width: 80%;" alt="Book Cover">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold">AI Revolution</h5>
                            <p class="text-muted small mb-1">Author: Sam Altman</p>
                            <p class="text-muted small">Category: New</p>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;">Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;">View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">$40</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 3. Old Books Section -->
    <div class="container my-5">
        <h3 class="text-center fw-bold mb-4">Old Books</h3>
        <div class="row g-4">
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm">
                    <img src="https://images.unsplash.com/photo-1476275466078-4007374efbbe?q=80&w=400&auto=format&fit=crop" class="card-img-top mx-auto mt-2" style="height: 180px; object-fit: cover; width: 80%;" alt="Book Cover">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold">Classic Literature</h5>
                            <p class="text-muted small mb-1">Author: Charles D.</p>
                            <p class="text-muted small">Category: Old</p>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;">Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;">View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">$10</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="component/footer.jsp" %>

</body>
</html>