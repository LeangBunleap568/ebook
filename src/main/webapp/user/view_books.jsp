<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.app.entity.*, com.app.dao.impl.*, com.app.db.*, java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${empty userobj}">
    <c:redirect url="../login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="km">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Book Details - Ebook Store</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        :root { 
            --ui-bg: #f4f6f8; 
            --ui-card: #ffffff; 
            --ui-navy: #1e293b; 
            --ui-text: #334155; 
            --ui-muted: #64748b; 
            --ui-border: #cbd5e1; 
            --ui-red: #ef4444;
            --ui-green: #16a34a;
        }
        *, *::before, *::after { 
            border-radius: 0 !important; 
            backdrop-filter: none !important; 
            -webkit-backdrop-filter: none !important; 
        }
        body { 
            background-color: var(--ui-bg) !important; 
            color: var(--ui-text); 
            font-family: system-ui, -apple-system, sans-serif; 
        }
        .ui-card { 
            background: var(--ui-card); 
            border: 2px solid var(--ui-border); 
        }
        .product-image-container {
            background: #f8fafc;
            border: 1px solid var(--ui-border);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .product-image {
            height: 280px;
            width: 100%;
            max-width: 200px;
            object-fit: cover;
            border: 1px solid var(--ui-border);
            box-shadow: 4px 4px 0px rgba(0, 0, 0, 0.05);
        }
        @media (max-width: 576px) {
            .product-image { height: 220px; max-width: 160px; }
            .product-image-container { padding: 1rem; }
        }
        .feature-box {
            background: #f8fafc;
            color: var(--ui-text);
            border: 1px solid var(--ui-border);
            padding: 1rem 0.5rem;
            text-align: center;
        }
        .btn-ui-primary { 
            background: var(--ui-navy); 
            color: #fff !important; 
            font-weight: 700; 
            font-size: 0.85rem; 
            text-transform: uppercase; 
            border: none;
            padding: 10px 20px;
            display: inline-block;
            text-decoration: none;
        }
        .btn-ui-primary:hover { background: #0f172a; }
        .btn-ui-outline { 
            background: #fff; 
            color: var(--ui-navy) !important; 
            border: 1px solid var(--ui-navy); 
            font-weight: 700; 
            font-size: 0.85rem; 
            text-transform: uppercase; 
            display: inline-block;
            text-decoration: none;
            padding: 10px 20px;
        }
        .btn-ui-outline:hover { 
            background: var(--ui-navy); 
            color: #fff !important; 
        }
        .badge-ui {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            padding: 4px 8px;
            border: 1px solid var(--ui-border);
            background: #f8fafc;
            color: var(--ui-navy);
        }
        .price-tag {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--ui-red);
            border: 1px solid var(--ui-red);
            background: #fef2f2;
            padding: 8px 16px;
            display: inline-block;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <%@include file="../component/navbar.jsp" %>

    <%
        String idParam = request.getParameter("id");
        int id = 0;
        if (idParam != null && !idParam.trim().isEmpty()) {
            try { 
                id = Integer.parseInt(idParam); 
            } catch(Exception e) {
                id = 0;
            }
        }
        
        BookDtls b = null;
        try {
            java.sql.Connection conn = DBconnect.getConn();
            if (conn != null && id > 0) {
                BookDAOImpl dao = new BookDAOImpl(conn);
                b = dao.getBookById(id);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }

        if (b == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
    %>

    <div class="container p-3 p-md-4 my-auto flex-grow-1">
        <div class="row g-4 align-items-stretch">
            
            <!-- Left Card: Book Image & Metadata -->
            <div class="col-12 col-md-5 col-lg-5">
                <div class="ui-card p-4 h-100 d-flex flex-column justify-content-between text-center">
                    <div class="product-image-container mb-4">
                        <img src="${pageContext.request.contextPath}/book/<%= b.getPhotoName() %>" class="product-image" alt="<%= b.getBookName() %>" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/book/default_book.svg';">
                    </div>
                    <div>
                        <span class="badge-ui mb-3 d-inline-block"><%= b.getBookCategory() %> Category</span>
                        <h5 class="fw-bold text-uppercase mb-2" style="color: var(--ui-navy);"><%= b.getBookName() %></h5>
                        <div class="small text-muted mb-1"><span class="fw-bold">Author:</span> <%= b.getAuthor() %></div>
                        <div class="small text-muted"><span class="fw-bold">Status:</span> Active</div>
                    </div>
                </div>
            </div>

            <!-- Right Card: Details, Seller Info & Actions -->
            <div class="col-12 col-md-7 col-lg-7">
                <div class="ui-card p-4 p-md-5 h-100 d-flex flex-column justify-content-between text-center">
                    <div>
                        <h3 class="fw-bold text-uppercase mb-4" style="color: var(--ui-navy); border-bottom: 2px solid var(--ui-border); padding-bottom: 12px;"><%= b.getBookName() %></h3>
                        
                        <% if("Old".equals(b.getBookCategory())) { %>
                            <div class="p-3 mb-4 text-start" style="background: #f8fafc; border: 1px solid var(--ui-border);">
                                <div class="fw-bold text-uppercase mb-1" style="font-size: 0.8rem; color: var(--ui-navy);">
                                    <i class="fas fa-user-circle me-1"></i> Contact Seller Info
                                </div>
                                <div class="small text-muted">
                                    <i class="fas fa-envelope me-2"></i>Email: <strong><%= b.getEmail() %></strong>
                                </div>
                            </div>
                        <% } %>

                        <!-- Service Features Row -->
                        <div class="row g-3 my-4">
                            <div class="col-4">
                                <div class="feature-box">
                                    <i class="fas fa-money-bill-wave fa-2x mb-2" style="color: var(--ui-green);"></i>
                                    <div class="fw-bold small text-uppercase" style="font-size: 0.7rem;">Cash On Delivery</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="feature-box">
                                    <i class="fas fa-undo-alt fa-2x mb-2" style="color: var(--ui-red);"></i>
                                    <div class="fw-bold small text-uppercase" style="font-size: 0.7rem;">Return Available</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="feature-box">
                                    <i class="fas fa-shipping-fast fa-2x mb-2" style="color: var(--ui-navy);"></i>
                                    <div class="fw-bold small text-uppercase" style="font-size: 0.7rem;">Free Delivery</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Dynamic Action Buttons & Price Display -->
                    <div class="pt-4" style="border-top: 1px solid var(--ui-border);">
                        <div class="d-flex flex-wrap justify-content-center align-items-center gap-3">
                            <% if("Old".equals(b.getBookCategory())) { %>
                                <a href="${pageContext.request.contextPath}/index.jsp" class="btn-ui-outline">
                                    <i class="fas fa-arrow-left me-1"></i> Back to Store
                                </a>
                                <div class="price-tag">
                                    $<%= b.getPrice() %>
                                </div>
                            <% } else { %>
                                <a href="${pageContext.request.contextPath}/user/cart?bid=<%= b.getBookId() %>" class="btn-ui-primary">
                                    <i class="fas fa-cart-plus me-1"></i> Add to Cart
                                </a>
                                <div class="price-tag">
                                    $<%= b.getPrice() %>
                                </div>
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