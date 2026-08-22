<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Successful — Ebook Store</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        :root { 
            --ui-bg: #f4f6f8; 
            --ui-card: #ffffff; 
            --ui-navy: #1e293b; 
            --ui-text: #334155; 
            --ui-muted: #64748b; 
            --ui-border: #cbd5e1; 
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
        .section-header { 
            border-bottom: 2px solid var(--ui-border); 
            padding-bottom: 12px; 
            margin-bottom: 20px; 
        }
        .btn-ui-primary { 
            background: var(--ui-navy); 
            color: #fff !important; 
            font-weight: 700; 
            font-size: 0.85rem; 
            text-transform: uppercase; 
            border: none;
            padding: 10px 16px;
            display: inline-block;
            text-decoration: none;
            text-align: center;
        }
        .btn-ui-primary:hover { 
            background: #0f172a; 
        }
        .btn-ui-outline { 
            background: #fff; 
            color: var(--ui-navy) !important; 
            border: 1px solid var(--ui-border); 
            font-weight: 700; 
            font-size: 0.85rem; 
            text-transform: uppercase; 
            display: inline-block;
            text-decoration: none;
            padding: 10px 16px;
            text-align: center;
        }
        .btn-ui-outline:hover { 
            background: var(--ui-navy); 
            color: #fff !important; 
        }
        .order-badge {
            background: #f1f5f9;
            border: 1px dashed var(--ui-border);
            color: var(--ui-navy);
            padding: 12px;
            font-family: monospace;
            font-size: 0.95rem;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@include file="../component/navbar.jsp" %>

    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <div class="container p-3 p-md-4 my-auto flex-grow-1 d-flex align-items-center justify-content-center">
        <div class="row w-100 justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">
                <div class="ui-card p-4 text-center">
                    
                    <!-- Success Icon -->
                    <div class="mb-3 d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px; border: 2px solid var(--ui-green); background: #f0fdf4;">
                        <i class="fas fa-check fa-2x" style="color: var(--ui-green);"></i>
                    </div>

                    <h4 class="fw-bold text-uppercase mb-1" style="color: var(--ui-navy);">Order Confirmed!</h4>
                    <p class="small text-muted mb-4">Thank you for your purchase. Your order has been placed successfully.</p>

                    <!-- Order Reference -->
                    <c:if test="${not empty orderNo}">
                        <div class="order-badge mb-4">
                            <span class="text-muted text-uppercase small d-block mb-1" style="font-family: sans-serif;">Order Reference</span>
                            <strong class="fs-6">#${orderNo}</strong>
                        </div>
                        <c:remove var="orderNo" scope="session"/>
                    </c:if>

                    <!-- Action Buttons -->
                    <div class="row g-2 mt-2">
                        <div class="col-12 col-sm-6">
                            <a href="${pageContext.request.contextPath}/user/order.jsp" class="btn-ui-primary w-100">
                                <i class="fas fa-box-open me-1"></i> View Orders
                            </a>
                        </div>
                        <div class="col-12 col-sm-6">
                            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-ui-outline w-100">
                                <i class="fas fa-shopping-cart me-1"></i> Continue Shopping
                            </a>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>