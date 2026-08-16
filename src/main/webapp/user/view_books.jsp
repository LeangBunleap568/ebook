<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.db.DBconnect" %>
<%@ page import="com.ebook.dao.impl.BookDAOImpl" %>
<%@ page import="com.ebook.entity.BookDtls" %>
<!DOCTYPE html>
<html lang="km">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Book Details</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        .product-card {
            border: none;
            border-radius: 16px;
            background: #ffffff;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }
        .product-image-container {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2.5rem;
        }
        .product-image {
            height: 320px;
            width: 210px;
            object-fit: cover;
            border-radius: 12px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.12);
            transition: transform 0.3s ease;
        }
        .product-image:hover {
            transform: scale(1.03);
        }
        .feature-box {
            background: var(--color-input-bg);
            color: var(--color-text-dark);
            border-radius: 12px;
            padding: 1rem 0.5rem;
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.03);
        }
        .feature-box:hover {
            background: var(--primary);
            color: #ffffff;
            transform: translateY(-4px);
        }
        .btn-custom {
            padding: 0.75rem 2rem !important;
            font-weight: 600;
            transition: all 0.2s ease;
        }
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.12);
        }
    </style>
</head>
<body class="bg-light">
    <%@include file="../component/navbar.jsp" %>

    <%
        int id = Integer.parseInt(request.getParameter("id"));
        BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
        BookDtls b = dao.getBookById(id);
        
        String categoryBadgeClass = "bg-secondary-subtle text-secondary";
        if("New".equals(b.getBookCategory())) {
            categoryBadgeClass = "bg-success-subtle text-success";
        } else if("Recent".equals(b.getBookCategory())) {
            categoryBadgeClass = "bg-primary-subtle text-primary";
        }
    %>

    <div class="container py-5">
        <div class="row g-4 align-items-stretch">
            
            <!-- Left Card: Book Image & Metadata -->
            <div class="col-lg-5">
                <div class="product-card p-4 h-100 d-flex flex-column justify-content-between text-center">
                    <div class="product-image-container mb-4">
                        <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="product-image" alt="<%= b.getBookName() %>" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/book/default_book.svg';">
                    </div>
                    <div>
                        <span class="badge <%= categoryBadgeClass %> mb-3 d-inline-block px-3 py-2" style="font-size: 0.85rem !important;"><%= b.getBookCategory() %></span>
                        <h4 class="fw-bold text-dark mb-2"><span class="text-secondary small fw-normal">Title:</span> <%= b.getBookName() %></h4>
                        <h5 class="text-muted mb-2"><span class="small fw-normal">Author:</span> <%= b.getAuthor() %></h5>
                        <h5 class="text-muted mb-0"><span class="small fw-normal">Category:</span> <%= b.getBookCategory() %></h5>
                    </div>
                </div>
            </div>

            <!-- Right Card: Details, Seller Info & Actions -->
            <div class="col-lg-7">
                <div class="product-card p-4 p-md-5 h-100 d-flex flex-column justify-content-between text-center">
                    <div>
                        <h2 class="fw-bold text-dark mb-4"><%= b.getBookName() %></h2>
                        
                        <% if("Old".equals(b.getBookCategory())) { %>
                            <div class="p-3 bg-light rounded-3 mb-4 border">
                                <h5 class="text-primary m-0 mb-2 fw-bold"><i class="fas fa-user-circle me-1"></i> Contact Seller</h5>
                                <p class="text-muted m-0"><i class="fas fa-envelope me-2"></i>Email: <strong><%= b.getEmail() %></strong></p>
                            </div>
                        <% } %>

                        <!-- Service Features Row -->
                        <div class="row g-3 my-4">
                            <div class="col-4">
                                <div class="feature-box shadow-sm">
                                    <i class="fas fa-money-bill-wave fa-2x mb-2 text-success"></i>
                                    <p class="fw-bold mb-0 small">Cash On Delivery</p>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="feature-box shadow-sm">
                                    <i class="fas fa-undo-alt fa-2x mb-2 text-danger"></i>
                                    <p class="fw-bold mb-0 small">Return Available</p>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="feature-box shadow-sm">
                                    <i class="fas fa-shipping-fast fa-2x mb-2 text-primary"></i>
                                    <p class="fw-bold mb-0 small">Free Delivery</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Dynamic Action Buttons & Price Display -->
                    <div class="mt-4 pt-3 border-top">
                        <div class="d-flex justify-content-center align-items-center gap-3">
                            <% if("Old".equals(b.getBookCategory())) { %>
                                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-dark btn-custom btn-lg shadow-sm"><i class="fas fa-shopping-bag me-1"></i> Continue Shopping</a>
                                <span class="btn btn-outline-danger btn-custom btn-lg disabled bg-light text-danger fw-bold border-danger shadow-sm"><%= new java.text.DecimalFormat("#,###").format(Double.parseDouble(b.getPrice())) %> ៛</span>
                            <% } else { %>
                                <a href="${pageContext.request.contextPath}/cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-primary btn-custom btn-lg shadow-sm"><i class="fas fa-cart-plus me-1"></i> Add to Cart</a>
                                <span class="btn btn-outline-danger btn-custom btn-lg disabled bg-light text-danger fw-bold border-danger shadow-sm"><%= new java.text.DecimalFormat("#,###").format(Double.parseDouble(b.getPrice())) %> ៛</span>
                            <% } %>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
    
    <%@include file="../component/footer.jsp" %>
</body>
</html>

