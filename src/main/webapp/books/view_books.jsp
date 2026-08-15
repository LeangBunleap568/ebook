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
            background: #fff0f2;
            color: #dc3545;
            border-radius: 12px;
            padding: 1rem 0.5rem;
            transition: all 0.3s ease;
        }
        .feature-box:hover {
            background: #dc3545;
            color: #ffffff;
            transform: translateY(-4px);
        }
        .badge-category {
            background-color: #eef2ff;
            color: #4f46e5;
            font-weight: 600;
            padding: 0.5em 1em;
            border-radius: 50rem;
        }
        .btn-custom {
            border-radius: 50rem;
            padding: 0.75rem 1.75rem;
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
    %>

    <div class="container py-5">
        <div class="row g-4 align-items-stretch">
            
            <!-- Left Card: Book Image & Metadata -->
            <div class="col-lg-5">
                <div class="product-card p-4 h-100 d-flex flex-column justify-content-between text-center">
                    <div class="product-image-container mb-4">
                        <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="product-image" alt="<%= b.getBookName() %>">
                    </div>
                    <div>
                        <span class="badge badge-category mb-3 d-inline-block"><%= b.getBookCategory() %></span>
                        <h4 class="fw-bold text-dark mb-2">Book Name: <span class="text-success"><%= b.getBookName() %></span></h4>
                        <h5 class="text-muted mb-2">Author Name: <span class="text-success"><%= b.getAuthor() %></span></h5>
                        <h5 class="text-muted mb-0">Category: <span class="text-success"><%= b.getBookCategory() %></span></h5>
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
                                <h5 class="text-primary m-0 mb-1">Contact Seller</h5>
                                <h5 class="text-primary m-0"><i class="fas fa-envelope me-2"></i>Email: <%= b.getEmail() %></h5>
                            </div>
                        <% } %>

                        <!-- Service Features Row -->
                        <div class="row g-3 my-4">
                            <div class="col-4">
                                <div class="feature-box">
                                    <i class="fas fa-money-bill-wave fa-2x mb-2"></i>
                                    <p class="fw-bold mb-0 small">Cash On Delivery</p>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="feature-box">
                                    <i class="fas fa-undo-alt fa-2x mb-2"></i>
                                    <p class="fw-bold mb-0 small">Return Available</p>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="feature-box">
                                    <i class="fas fa-truck-moving fa-2x mb-2"></i>
                                    <p class="fw-bold mb-0 small">Free Shipping</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Dynamic Action Buttons & Price Display -->
                    <div class="mt-4 pt-3 border-top">
                        <div class="d-flex justify-content-center align-items-center gap-2">
                            <% if("Old".equals(b.getBookCategory())) { %>
                                <a href="../index.jsp" class="btn btn-success btn-custom btn-lg"><i class="fas fa-cart-plus me-1"></i> Continue Shopping</a>
                                <span class="btn btn-danger btn-custom btn-lg disabled"><%= new java.text.DecimalFormat("#,###").format(Double.parseDouble(b.getPrice())) %> ៛</span>
                            <% } else { %>
                                <a href="../cart?bid=<%= b.getBookId() %>&uid=${userobj.id}" class="btn btn-primary btn-custom btn-lg"><i class="fas fa-cart-plus me-1"></i> Add to Cart</a>
                                <span class="btn btn-danger btn-custom btn-lg disabled"><%= new java.text.DecimalFormat("#,###").format(Double.parseDouble(b.getPrice())) %> ៛</span>
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