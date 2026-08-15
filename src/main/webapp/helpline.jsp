<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Support</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">

    <%@include file="../component/navbar.jsp" %>

    <div class="container py-5">
        
        <%-- Header Section --%>
        <div class="text-center mb-5">
            <h3 class="fw-bold text-dark mb-2">How can we help you?</h3>
            <p class="text-muted">Feel free to reach out to our support team anytime.</p>
        </div>

        <div class="row g-4 justify-content-center">
            
            <%-- Phone Contact Card --%>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 h-100 text-center p-3">
                    <div class="card-body">
                        <div class="d-inline-block bg-primary bg-opacity-10 text-primary p-3 rounded-circle mb-3">
                            <i class="fas fa-phone-alt fa-2x"></i>
                        </div>
                        <h5 class="fw-bold mb-2">Customer Helpline</h5>
                        <p class="text-muted small mb-3">Call us directly for fast support</p>
                        <a href="tel:069543838" class="text-decoration-none h5 fw-bold text-primary mb-0 d-block">
                            069 543 838
                        </a>
                    </div>
                </div>
            </div>

            <%-- Email Contact Card --%>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 h-100 text-center p-3">
                    <div class="card-body">
                        <div class="d-inline-block bg-success bg-opacity-10 text-success p-3 rounded-circle mb-3">
                            <i class="fas fa-envelope fa-2x"></i>
                        </div>
                        <h5 class="fw-bold mb-2">Email Support</h5>
                        <p class="text-muted small mb-3">Send us an email anytime</p>
                        <a href="mailto:leangbunleap007@gmail.com" class="text-decoration-none fw-bold text-success d-block text-break">
                            leangbunleap007@gmail.com
                        </a>
                    </div>
                </div>
            </div>

            <%-- Telegram Contact Card --%>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 h-100 text-center p-3">
                    <div class="card-body">
                        <div class="d-inline-block bg-info bg-opacity-10 text-info p-3 rounded-circle mb-3">
                            <i class="fab fa-telegram-plane fa-2x"></i>
                        </div>
                        <h5 class="fw-bold mb-2">Telegram Chat</h5>
                        <p class="text-muted small mb-3">Direct message via phone number</p>
                        <a href="@Leangbunleap" target="_blank" class="btn btn-outline-info btn-sm fw-bold rounded-pill px-3">
                            <i class="fab fa-telegram me-1"></i> Telegram: 069 543 838
                        </a>
                    </div>
                </div>
            </div>

        </div>

        <%-- Quick Notice --%>
        <div class="row justify-content-center mt-5">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm rounded-4 bg-white p-4 text-center">
                    <h5 class="fw-bold mb-2"><i class="fas fa-info-circle text-warning me-2"></i>Need Immediate Help?</h5>
                    <p class="text-muted small mb-0">
                        If you have issues regarding book orders or account registration, please call <strong>069 543 838</strong> or email to <strong>leangbunleap007@gmail.com</strong>.
                    </p>
                </div>
            </div>
        </div>

    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>