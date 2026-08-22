<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About & Team — Ebook Store</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light d-flex flex-column min-vh-100">
    <%@include file="../component/navbar.jsp" %>

    <div class="container my-5 flex-grow-1">
        <!-- Development Team Section -->
        <div class="card border-0 shadow-sm p-4 mb-4">
            <h5 class="fw-bold text-uppercase border-bottom pb-2 mb-4 text-dark">
                <i class="fas fa-code me-2"></i>Development Team
            </h5>
            <div class="row g-3 text-center">
                <div class="col-md-4">
                    <div class="p-3 border rounded bg-white h-100 d-flex flex-column justify-content-between">
                        <div>
                            <i class="fas fa-server fa-2x text-primary mb-2"></i>
                            <h6 class="fw-bold mb-1">Leang Bunleap</h6>
                            <span class="badge bg-secondary mb-2">Backend & DB</span>
                            <p class="small text-muted mb-0">Logic, Servlet Handling & Database Architecture</p>
                        </div>
                        <a href="https://t.me/bunleap_leang" target="_blank" class="btn btn-outline-primary btn-sm mt-3 w-100">
                            <i class="fab fa-telegram-plane me-1"></i> Telegram
                        </a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-3 border rounded bg-white h-100 d-flex flex-column justify-content-between">
                        <div>
                            <i class="fas fa-paint-brush fa-2x text-success mb-2"></i>
                            <h6 class="fw-bold mb-1">Net Seyha</h6>
                            <span class="badge bg-success mb-2">UI/UX & Frontend</span>
                            <p class="small text-muted mb-0">User Interface & Client-side Interactions</p>
                        </div>
                        <a href="https://t.me/net_seyha" target="_blank" class="btn btn-outline-success btn-sm mt-3 w-100">
                            <i class="fab fa-telegram-plane me-1"></i> Telegram
                        </a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-3 border rounded bg-white h-100 d-flex flex-column justify-content-between">
                        <div>
                            <i class="fas fa-vial fa-2x text-info mb-2"></i>
                            <h6 class="fw-bold mb-1">Mesothea Chonent</h6>
                            <span class="badge bg-info text-dark mb-2">QA & Assistant</span>
                            <p class="small text-muted mb-0">Project Assistance & Quality Assurance</p>
                        </div>
                        <a href="https://t.me/mesothea_chonent" target="_blank" class="btn btn-outline-info btn-sm mt-3 w-100">
                            <i class="fab fa-telegram-plane me-1"></i> Telegram
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Technologies Used Section -->
        <div class="card border-0 shadow-sm p-4">
            <h5 class="fw-bold text-uppercase border-bottom pb-2 mb-4 text-dark">
                <i class="fas fa-layer-group me-2"></i>Technologies Used
            </h5>
            <div class="row g-3 text-center">
                <div class="col-6 col-md-2">
                    <div class="p-3 border rounded bg-white">
                        <i class="fab fa-java fa-2x text-danger mb-2"></i>
                        <h6 class="fw-bold small mb-0">Java EE</h6>
                    </div>
                </div>
                <div class="col-6 col-md-2">
                    <div class="p-3 border rounded bg-white">
                        <i class="fas fa-code fa-2x text-warning mb-2"></i>
                        <h6 class="fw-bold small mb-0">JSP & Servlet</h6>
                    </div>
                </div>
                <div class="col-6 col-md-2">
                    <div class="p-3 border rounded bg-white">
                        <i class="fas fa-database fa-2x text-primary mb-2"></i>
                        <h6 class="fw-bold small mb-0">MySQL</h6>
                    </div>
                </div>
                <div class="col-6 col-md-2">
                    <div class="p-3 border rounded bg-white">
                        <i class="fab fa-bootstrap fa-2x mb-2" style="color: #6f42c1;"></i>
                        <h6 class="fw-bold small mb-0">Bootstrap 5</h6>
                    </div>
                </div>
                <div class="col-6 col-md-2">
                    <div class="p-3 border rounded bg-white">
                        <i class="fab fa-html5 fa-2x text-danger mb-2"></i>
                        <h6 class="fw-bold small mb-0">HTML5 / CSS3</h6>
                    </div>
                </div>
                <div class="col-6 col-md-2">
                    <div class="p-3 border rounded bg-white">
                        <i class="fas fa-server fa-2x text-secondary mb-2"></i>
                        <h6 class="fw-bold small mb-0">Apache Tomcat</h6>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>