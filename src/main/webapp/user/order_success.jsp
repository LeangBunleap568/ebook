<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Successful</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">
    <%@include file="../component/navbar.jsp" %>
    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-6 text-center">
                <div class="card shadow border-0 p-5">
                    <div style="width:100px;height:100px;border-radius:50%;background:rgba(25,135,84,0.1);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                        <i class="fas fa-check-circle fa-4x text-success"></i>
                    </div>
                    <h3 class="fw-bold text-success">Order Placed Successfully!</h3>
                    <p class="text-muted mt-2">Thank you for your purchase. Your order has been received.</p>
                    <div class="alert alert-info mt-3">
                        <strong>Order ID:</strong> ${orderNo}
                    </div>
                    <c:remove var="orderNo" scope="session"/>
                    <div class="d-flex gap-3 justify-content-center mt-4">
                        <a href="${pageContext.request.contextPath}/user/order.jsp" class="btn btn-primary"><i class="fas fa-box-open me-1"></i> View Orders</a>
                        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-secondary"><i class="fas fa-home me-1"></i> Continue Shopping</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>


