<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App - Customer Orders</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">

    <%@include file="../component/navbar.jsp" %>

    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold mb-0"><i class="fas fa-boxes text-warning me-2"></i>Customer Orders Management</h3>
        </div>

        <div class="card border-0 rounded-0 shadow-sm p-4 bg-white">
            <div class="table-responsive">
                <table class="table align-middle table-hover mb-0 border">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col">Order ID</th>
                            <th scope="col">Customer Name</th>
                            <th scope="col">Book Name</th>
                            <th scope="col">Author</th>
                            <th scope="col">Price (៛)</th>
                            <th scope="col">Payment</th>
                            <th scope="col" class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Order Row 1 -->
                        <tr>
                            <td class="fw-bold text-primary">#ORD-1001</td>
                            <td class="fw-semibold">Sokha Chan</td>
                            <td class="fw-bold">Java Programming</td>
                            <td>John Doe</td>
                            <td class="fw-bold text-success">100,000 ៛</td>
                            <td><span class="badge bg-success rounded-0 px-2 py-1"><i class="fas fa-money-bill-wave me-1"></i>COD</span></td>
                            <td class="text-center">
                                <button type="button" class="btn btn-dark btn-sm rounded-0 px-3 py-1" style="font-size: 13px;" data-bs-toggle="modal" data-bs-target="#orderModal1">
                                    <i class="fas fa-eye me-1"></i> View Details
                                </button>
                            </td>
                        </tr>

                        <!-- Order Row 2 -->
                        <tr>
                            <td class="fw-bold text-primary">#ORD-1002</td>
                            <td class="fw-semibold">Borey Vong</td>
                            <td class="fw-bold">Java Spring Boot</td>
                            <td>Piseth Java</td>
                            <td class="fw-bold text-success">300,000 ៛</td>
                            <td><span class="badge bg-primary rounded-0 px-2 py-1"><i class="fas fa-credit-card me-1"></i>Online Payment</span></td>
                            <td class="text-center">
                                <button type="button" class="btn btn-dark btn-sm rounded-0 px-3 py-1" style="font-size: 13px;" data-bs-toggle="modal" data-bs-target="#orderModal2">
                                    <i class="fas fa-eye me-1"></i> View Details
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal 1: Order Details #ORD-1001 -->
    <div class="modal fade" id="orderModal1" tabindex="-1" aria-labelledby="orderModal1Label" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content rounded-0 border-0 shadow">
                <div class="modal-header bg-dark text-white rounded-0">
                    <h5 class="modal-title fw-bold" id="orderModal1Label">
                        <i class="fas fa-receipt text-warning me-2"></i>Order Details - #ORD-1001
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-4">
                        <!-- Contact & Shipping Details -->
                        <div class="col-md-6 border-end">
                            <h6 class="fw-bold text-primary border-bottom pb-2 mb-3">
                                <i class="fas fa-user-circle me-2"></i>Customer & Shipping Details
                            </h6>
                            <div class="mb-3">
                                <span class="text-muted small d-block">Full Name</span>
                                <strong class="fs-6 text-dark">Sokha Chan</strong>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted small d-block"><i class="fas fa-envelope text-secondary me-1"></i>Email Address</span>
                                <span class="fw-bold text-dark">sokha.chan@gmail.com</span>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted small d-block"><i class="fas fa-phone text-secondary me-1"></i>Phone Number</span>
                                <span class="fw-bold text-dark">012 345 678</span>
                            </div>
                            <div class="mb-0">
                                <span class="text-muted small d-block"><i class="fas fa-map-marker-alt text-danger me-1"></i>Delivery Address</span>
                                <span class="fw-semibold text-dark">#123, St. 271, Khan Chamkarmon, Phnom Penh</span>
                            </div>
                        </div>

                        <!-- Book & Payment Details -->
                        <div class="col-md-6">
                            <h6 class="fw-bold text-primary border-bottom pb-2 mb-3">
                                <i class="fas fa-book me-2"></i>Book & Payment Info
                            </h6>
                            <div class="mb-3">
                                <span class="text-muted small d-block">Book Title</span>
                                <strong class="fs-6 text-dark">Java Programming</strong>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted small d-block">Author</span>
                                <span class="text-dark">John Doe</span>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted small d-block">Total Cost</span>
                                <span class="fw-bold text-success fs-5">100,000 ៛</span>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted small d-block">Payment Method</span>
                                <span class="badge bg-success rounded-0 px-2 py-1">Cash on Delivery (COD)</span>
                            </div>
                            <div class="mb-0">
                                <span class="text-muted small d-block">Order Status</span>
                                <span class="badge bg-warning text-dark rounded-0 px-2 py-1">Pending Delivery</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light rounded-0">
                    <button type="button" class="btn btn-secondary rounded-0 px-4" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal 2: Order Details #ORD-1002 -->
    <div class="modal fade" id="orderModal2" tabindex="-1" aria-labelledby="orderModal2Label" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content rounded-0 border-0 shadow">
                <div class="modal-header bg-dark text-white rounded-0">
                    <h5 class="modal-title fw-bold" id="orderModal2Label">
                        <i class="fas fa-receipt text-warning me-2"></i>Order Details - #ORD-1002
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-4">
                        <!-- Contact & Shipping Details -->
                        <div class="col-md-6 border-end">
                            <h6 class="fw-bold text-primary border-bottom pb-2 mb-3">
                                <i class="fas fa-user-circle me-2"></i>Customer & Shipping Details
                            </h6>
                            <div class="mb-3">
                                <span class="text-muted small d-block">Full Name</span>
                                <strong class="fs-6 text-dark">Borey Vong</strong>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted small d-block"><i class="fas fa-envelope text-secondary me-1"></i>Email Address</span>
                                <span class="fw-bold text-dark">borey.vong@gmail.com</span>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted small d-block"><i class="fas fa-phone text-secondary me-1"></i>Phone Number</span>
                                <span class="fw-bold text-dark">098 765 432</span>
                            </div>
                            <div class="mb-0">
                                <span class="text-muted small d-block"><i class="fas fa-map-marker-alt text-danger me-1"></i>Delivery Address</span>
                                <span class="fw-semibold text-dark">#45, Monivong Blvd, Khan Daun Penh, Phnom Penh</span>
                            </div>
                        </div>

                        <!-- Book & Payment Details -->
                        <div class="col-md-6">
                            <h6 class="fw-bold text-primary border-bottom pb-2 mb-3">
                                <i class="fas fa-book me-2"></i>Book & Payment Info
                            </h6>
                            <div class="mb-3">
                                <span class="text-muted small d-block">Book Title</span>
                                <strong class="fs-6 text-dark">Java Spring Boot</strong>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted small d-block">Author</span>
                                <span class="text-dark">Piseth Java</span>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted small d-block">Total Cost</span>
                                <span class="fw-bold text-success fs-5">300,000 ៛</span>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted small d-block">Payment Method</span>
                                <span class="badge bg-primary rounded-0 px-2 py-1">Online Payment (ABA KHQR)</span>
                            </div>
                            <div class="mb-0">
                                <span class="text-muted small d-block">Order Status</span>
                                <span class="badge bg-success rounded-0 px-2 py-1">Paid & Processing</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light rounded-0">
                    <button type="button" class="btn btn-secondary rounded-0 px-4" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JavaScript Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <%@include file="../component/footer.jsp" %>
</body>
</html>


