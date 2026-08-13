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
                <a href="#" class="btn btn-sm btn-outline-primary rounded-2 px-3">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>

            <div class="row g-4">
                <!-- Book 1 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/javaBook.jpg" class="book-img" alt="Java Programming">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-primary-subtle text-primary rounded-1 mb-2">Recent</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">Java Programming</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Joyce Farrell</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-primary mb-2">100,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Book 2 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/1670219741murach.webp" class="book-img" alt="PHP & MySQL">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-primary-subtle text-primary rounded-1 mb-2">Recent</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">PHP and MySQL for Beginner</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Jim Keogh</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-primary mb-2">120,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Book 3 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/61aatAAWF6L._UF1000,1000_QL80_.jpg" class="book-img" alt="Spring Boot">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-primary-subtle text-primary rounded-1 mb-2">Recent</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">Spring Boot in Action</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Craig Walls</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-primary mb-2">140,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Book 4 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/61o1cENQKLL._UF1000,1000_QL80_.jpg" class="book-img" alt="Clean Code">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-primary-subtle text-primary rounded-1 mb-2">Recent</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">Clean Code</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Robert C. Martin</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-primary mb-2">160,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 2. New Books Section -->
        <section class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h4 class="fw-bold mb-0 text-dark d-flex align-items-center">
                    <i class="fas fa-sparkles text-success me-2"></i> New Books
                </h4>
                <a href="#" class="btn btn-sm btn-outline-success rounded-2 px-3">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>

            <div class="row g-4">
                <!-- Book 1 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/711YQqVr6aL._UF1000,1000_QL80_.jpg" class="book-img" alt="Python Crash Course">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-success-subtle text-success rounded-1 mb-2">New</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">Python Crash Course</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Eric Matthes</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-success mb-2">110,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Book 2 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/717hDNtqA5L._AC_UF1000,1000_QL80_.jpg" class="book-img" alt="JS Guide">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-success-subtle text-success rounded-1 mb-2">New</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">JavaScript: Definitive Guide</h6>
                                <p class="text-muted small text-truncate mb-2">Author: David Flanagan</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-success mb-2">130,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Book 3 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/images (1).jpg" class="book-img" alt="Learning React">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-success-subtle text-success rounded-1 mb-2">New</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">Learning React</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Alex Banks & Eve Porcello</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-success mb-2">150,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Book 4 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/images (2).jpg" class="book-img" alt="Full Stack Dev">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-success-subtle text-success rounded-1 mb-2">New</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">Full-Stack Web Dev</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Eric Sarrion</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-success mb-2">180,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 3. Old Books Section -->
        <section class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h4 class="fw-bold mb-0 text-dark d-flex align-items-center">
                    <i class="fas fa-history text-secondary me-2"></i> Old Books
                </h4>
                <a href="#" class="btn btn-sm btn-outline-secondary rounded-2 px-3">View All <i class="fas fa-arrow-right ms-1"></i></a>
            </div>

            <div class="row g-4">
                <!-- Book 1 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/images (3).jpg" class="book-img" alt="Database Concepts">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-secondary-subtle text-secondary rounded-1 mb-2">Old</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">Database System Concepts</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Abraham Silberschatz</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-secondary mb-2">50,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Book 2 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/images (4).jpg" class="book-img" alt="C++ Primer">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-secondary-subtle text-secondary rounded-1 mb-2">Old</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">C++ Primer</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Stanley B. Lippman</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-secondary mb-2">45,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Book 3 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/images (5).jpg" class="book-img" alt="Data Structures">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-secondary-subtle text-secondary rounded-1 mb-2">Old</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">Data Structures in C</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Mark Allen Weiss</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-secondary mb-2">60,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Book 4 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 book-card p-3 bg-white shadow-sm">
                        <div class="book-img-wrapper mb-3">
                            <img src="img/images (6).jpg" class="book-img" alt="Computer Networks">
                        </div>
                        <div class="card-body p-0 d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-secondary-subtle text-secondary rounded-1 mb-2">Old</span>
                                <h6 class="card-title text-truncate fw-bold text-dark mb-1">Computer Networks</h6>
                                <p class="text-muted small text-truncate mb-2">Author: Andrew S. Tanenbaum</p>
                            </div>
                            <div class="pt-2 border-top mt-2">
                                <div class="fw-bold text-secondary mb-2">55,000 ៛</div>
                                <div class="d-grid gap-1 d-flex">
                                    <a href="#" class="btn btn-danger btn-sm rounded-2 w-50"><i class="fas fa-cart-plus me-1"></i>Add</a>
                                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-2 w-50"><i class="fas fa-eye me-1"></i>View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </div>

    <%@include file="component/footer.jsp" %>

</body>
</html>