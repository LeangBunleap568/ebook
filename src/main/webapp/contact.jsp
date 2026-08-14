<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Us - Ebook Store</title>
<%@include file="component/rootCss.jsp"%>
</head>
<body class="bg-light">
    <%@include file="component/navbar.jsp"%>

    <div class="container my-5">

        <!-- Development Team Section -->
        <div class="row mt-4">
            <div class="col-12 text-center mb-4">
                <h3 class="fw-bold text-dark"><i class="fas fa-code me-2 text-primary"></i>Development Team</h3>
                <p class="text-muted">Meet the engineers behind Ebook Store Platform</p>
            </div>
            
            <!-- Leang Bunleap -->
            <div class="col-md-4 mb-3">
                <div class="card shadow-sm border-0 rounded-0 text-center h-100 p-3">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                <i class="fas fa-server fa-2x"></i>
                            </div>
                            <h5 class="fw-bold mb-1">Leang Bunleap</h5>
                            <span class="badge bg-primary mb-2">Server-side</span>
                            <p class="text-muted small mb-3">Logic, Servlet Handling & Database</p>
                        </div>
                        <a href="https://t.me/bunleap_leang" target="_blank" class="btn btn-outline-primary btn-sm rounded-0 w-100 fw-semibold">
                            <i class="fab fa-telegram-plane me-1"></i> Telegram
                        </a>
                    </div>
                </div>
            </div>

            <!-- Net Seyha -->
            <div class="col-md-4 mb-3">
                <div class="card shadow-sm border-0 rounded-0 text-center h-100 p-3">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                <i class="fas fa-paint-brush fa-2x"></i>
                            </div>
                            <h5 class="fw-bold mb-1">Net Seyha</h5>
                            <span class="badge bg-success mb-2">UI/UX & Client-side</span>
                            <p class="text-muted small mb-3">User Interface & Client-side Interactions</p>
                        </div>
                        <a href="https://t.me/net_seyha" target="_blank" class="btn btn-outline-success btn-sm rounded-0 w-100 fw-semibold">
                            <i class="fab fa-telegram-plane me-1"></i> Telegram
                        </a>
                    </div>
                </div>
            </div>

            <!-- Mesothea Chonent -->
            <div class="col-md-4 mb-3">
                <div class="card shadow-sm border-0 rounded-0 text-center h-100 p-3">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <div class="bg-info text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                <i class="fas fa-vial fa-2x"></i>
                            </div>
                            <h5 class="fw-bold mb-1">Mesothea Chonent</h5>
                            <span class="badge bg-info text-dark mb-2">Assistant & QA Tester</span>
                            <p class="text-muted small mb-3">Assistance & Testing</p>
                        </div>
                        <a href="https://t.me/mesothea_chonent" target="_blank" class="btn btn-outline-info btn-sm text-dark rounded-0 w-100 fw-semibold">
                            <i class="fab fa-telegram-plane me-1"></i> Telegram
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Technologies Used Section -->
        <div class="row mt-5">
            <div class="col-12 text-center mb-4">
                <h4 class="fw-bold text-dark"><i class="fas fa-layer-group me-2 text-primary"></i>Technologies Used</h4>
                <p class="text-muted small">Tools and frameworks powering this application</p>
            </div>
            <div class="col-12">
                <div class="card shadow-sm border-0 rounded-0 p-4 bg-white">
                    <div class="row text-center g-3">
                        <div class="col-6 col-md-2">
                            <i class="fab fa-java fa-3x text-danger mb-2"></i>
                            <h6 class="fw-bold mb-0">Java EE</h6>
                        </div>
                        <div class="col-6 col-md-2">
                            <i class="fas fa-code fa-3x text-warning mb-2"></i>
                            <h6 class="fw-bold mb-0">JSP & Servlet</h6>
                        </div>
                        <div class="col-6 col-md-2">
                            <i class="fas fa-database fa-3x text-primary mb-2"></i>
                            <h6 class="fw-bold mb-0">MySQL DB</h6>
                        </div>
                        <div class="col-6 col-md-2">
                            <i class="fab fa-bootstrap fa-3x text-purple mb-2" style="color: #6f42c1;"></i>
                            <h6 class="fw-bold mb-0">Bootstrap 5</h6>
                        </div>
                        <div class="col-6 col-md-2">
                            <i class="fab fa-html5 fa-3x text-danger mb-2"></i>
                            <h6 class="fw-bold mb-0">HTML5 / CSS3</h6>
                        </div>
                        <div class="col-6 col-md-2">
                            <i class="fas fa-server fa-3x text-secondary mb-2"></i>
                            <h6 class="fw-bold mb-0">Apache Tomcat</h6>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <%@include file="component/footer.jsp" %>
</body>
</html>