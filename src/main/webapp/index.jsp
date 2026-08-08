<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App - Home</title>
    <%@include file="component/rootCss.jsp" %>
    <style>
        .book-card {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.12) !important;
        }
        .book-img {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }
    </style>
</head>
<body class="bg-light">

    <%@include file="component/navbar.jsp" %>

    <!-- Hero Banner Section -->
    <div class="text-center text-white py-5 shadow-sm" style="background: linear-gradient(rgba(15, 23, 42, 0.8), rgba(15, 23, 42, 0.8)), url('img/javaBook.jpg'); background-size: cover; background-position: center; padding: 100px 20px;">
        <div class="container">
            <h1 class="display-4 fw-bold text-white mb-3"><i class="fas fa-book-reader text-warning me-2"></i>Ebook Management System</h1>
            <p class="lead text-light mb-4">Discover thousands of technology, programming, and classic ebooks in Cambodian Riel.</p>
            <a href="register.jsp" class="btn btn-warning rounded-0 px-4 py-2 fw-bold text-dark me-2">Get Started</a>
            <a href="#recent-books" class="btn btn-outline-light rounded-0 px-4 py-2">Explore Catalog</a>
        </div>
    </div>

    <!-- 1. Recent Books Section -->
    <div class="container my-5" id="recent-books">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold mb-0 text-dark"><i class="fas fa-clock text-primary me-2"></i>Recent Books</h3>
            <a href="#" class="btn btn-sm btn-outline-dark rounded-0">View All</a>
        </div>

        <div class="row g-4">
            <!-- Book 1 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/javaBook.jpg" class="card-img-top mx-auto mt-2 book-img" alt="Java Programming">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">Java Programming</h5>
                            <p class="text-muted small mb-1">Author: John Doe</p>
                            <span class="badge bg-primary-subtle text-primary rounded-0 mb-2">Recent</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">100,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Book 2 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/1670219741murach.webp" class="card-img-top mx-auto mt-2 book-img" alt="Murach Servlets">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">Murach's Java Servlets</h5>
                            <p class="text-muted small mb-1">Author: Joel Murach</p>
                            <span class="badge bg-primary-subtle text-primary rounded-0 mb-2">Recent</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">120,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Book 3 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/61aatAAWF6L._UF1000,1000_QL80_.jpg" class="card-img-top mx-auto mt-2 book-img" alt="Spring Boot">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">Spring Boot in Action</h5>
                            <p class="text-muted small mb-1">Author: Craig Walls</p>
                            <span class="badge bg-primary-subtle text-primary rounded-0 mb-2">Recent</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">140,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Book 4 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/61o1cENQKLL._UF1000,1000_QL80_.jpg" class="card-img-top mx-auto mt-2 book-img" alt="Clean Code">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">Clean Code</h5>
                            <p class="text-muted small mb-1">Author: Robert C. Martin</p>
                            <span class="badge bg-primary-subtle text-primary rounded-0 mb-2">Recent</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">160,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 2. New Books Section -->
    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold mb-0 text-dark"><i class="fas fa-star text-warning me-2"></i>New Books</h3>
            <a href="#" class="btn btn-sm btn-outline-dark rounded-0">View All</a>
        </div>

        <div class="row g-4">
            <!-- Book 1 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/711YQqVr6aL._UF1000,1000_QL80_.jpg" class="card-img-top mx-auto mt-2 book-img" alt="Python Crash Course">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">Python Crash Course</h5>
                            <p class="text-muted small mb-1">Author: Eric Matthes</p>
                            <span class="badge bg-success-subtle text-success rounded-0 mb-2">New</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">110,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Book 2 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/717hDNtqA5L._AC_UF1000,1000_QL80_.jpg" class="card-img-top mx-auto mt-2 book-img" alt="JavaScript Guide">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">JavaScript Definitive Guide</h5>
                            <p class="text-muted small mb-1">Author: David Flanagan</p>
                            <span class="badge bg-success-subtle text-success rounded-0 mb-2">New</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">130,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Book 3 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/images (1).jpg" class="card-img-top mx-auto mt-2 book-img" alt="React & Redux">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">React & Redux Guide</h5>
                            <p class="text-muted small mb-1">Author: Dan Abramov</p>
                            <span class="badge bg-success-subtle text-success rounded-0 mb-2">New</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">150,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Book 4 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/images (2).jpg" class="card-img-top mx-auto mt-2 book-img" alt="Full Stack Dev">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">Full Stack Web Dev</h5>
                            <p class="text-muted small mb-1">Author: Angela Yu</p>
                            <span class="badge bg-success-subtle text-success rounded-0 mb-2">New</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">180,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 3. Old Books Section -->
    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold mb-0 text-dark"><i class="fas fa-history text-secondary me-2"></i>Old Books</h3>
            <a href="#" class="btn btn-sm btn-outline-dark rounded-0">View All</a>
        </div>

        <div class="row g-4">
            <!-- Book 1 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/images (3).jpg" class="card-img-top mx-auto mt-2 book-img" alt="Database Systems">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">Database Systems Classic</h5>
                            <p class="text-muted small mb-1">Author: Abraham S.</p>
                            <span class="badge bg-secondary-subtle text-secondary rounded-0 mb-2">Old</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">50,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Book 2 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/images (4).jpg" class="card-img-top mx-auto mt-2 book-img" alt="C++ Programming">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">C++ Programming Primer</h5>
                            <p class="text-muted small mb-1">Author: Stanley B.</p>
                            <span class="badge bg-secondary-subtle text-secondary rounded-0 mb-2">Old</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">45,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Book 3 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/images (5).jpg" class="card-img-top mx-auto mt-2 book-img" alt="Data Structures">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">Data Structures in C</h5>
                            <p class="text-muted small mb-1">Author: Mark Allen</p>
                            <span class="badge bg-secondary-subtle text-secondary rounded-0 mb-2">Old</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">60,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Book 4 -->
            <div class="col-md-3">
                <div class="card h-100 book-card text-center p-2 rounded-0 shadow-sm bg-white border-0">
                    <img src="img/images (6).jpg" class="card-img-top mx-auto mt-2 book-img" alt="Computer Networks">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h5 class="card-title text-truncate fs-6 fw-bold mb-1">Computer Networks</h5>
                            <p class="text-muted small mb-1">Author: Andrew S.</p>
                            <span class="badge bg-secondary-subtle text-secondary rounded-0 mb-2">Old</span>
                        </div>
                        <div class="d-flex justify-content-center align-items-center gap-1 mt-2">
                            <a href="#" class="btn btn-danger btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-cart-plus me-1"></i>Add</a>
                            <a href="#" class="btn btn-success btn-sm px-2 py-1 rounded-0" style="font-size: 12px;"><i class="fas fa-eye me-1"></i>View</a>
                            <span class="badge bg-secondary py-2 px-2 rounded-0" style="font-size: 12px;">55,000 ៛</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="component/footer.jsp" %>

</body>
</html>