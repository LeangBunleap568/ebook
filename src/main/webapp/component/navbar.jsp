<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Custom Style for Modern Hover Effect -->
<style>
    .navbar-nav .nav-link {
        position: relative;
        transition: color 0.3s ease-in-out;
    }
    
    /* Hover Underline Animation */
    .navbar-nav .nav-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: 4px;
        left: 0;
        background-color: #ffc107; /* ពណ៌លឿងស្រដៀងនឹងปຸ່ມ Setting ឬអាចប្តូរតាមតម្រូវការ */
        transition: width 0.3s ease-in-out;
    }

    .navbar-nav .nav-link:hover::after,
    .navbar-nav .nav-link.active::after {
        width: 100%;
    }

    .navbar-nav .nav-link:hover {
        color: #ffc107 !important;
    }

    /* Button Smooth Hover Effect */
    .navbar .btn {
        transition: all 0.2s ease-in-out;
    }

    .navbar .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    }
</style>

<!-- Top Header Bar -->
<div class="container-fluid px-4 py-3 bg-white border-bottom">
    <div class="row align-items-center">
        <div class="col-md-3 text-primary">
            <h4 class="fw-bold mb-0">Ebook Store</h4>
        </div>
        <div class="col-md-6">
            <form class="d-flex" role="search">
                <input class="form-control rounded-0 me-2" type="search" placeholder="Search books..." aria-label="Search">
                <button class="btn btn-outline-primary rounded-0 px-3" type="submit">Search</button>
            </form>
        </div>
        <div class="col-md-3 text-end">
            <c:if test="${empty userobj}">
                <a href="login.jsp" class="btn btn-outline-dark btn-sm rounded-0 px-3 me-1">Login</a>
                <a href="register.jsp" class="btn btn-dark btn-sm rounded-0 px-3">Register</a>
            </c:if>
            <c:if test="${not empty userobj}">
                <a href="#" class="btn btn-success btn-sm rounded-0 px-3 me-1">${userobj.name}</a>

            </c:if>
        </div>
    </div>
</div>

<!-- Main Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark rounded-0 shadow-sm" style="background-color: #303f9f !important;">
    <div class="container-fluid px-4">
        <button class="navbar-toggler rounded-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain" aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item me-2">
                    <a class="nav-link text-white active" aria-current="page" href="index.jsp">Home</a>
                </li>
                <li class="nav-item me-2">
                    <a class="nav-link text-white" href="#">Recent Book</a>
                </li>
                <li class="nav-item me-2">
                    <a class="nav-link text-white" href="#">New Book</a>
                </li>
                <li class="nav-item me-2">
                    <a class="nav-link text-white" href="#">Old Book</a>
                </li>
            </ul>
            
            <div class="d-flex align-items-center gap-2">
                <a href="#" class="btn btn-light btn-sm text-dark rounded-0 px-3">Contact Us</a>
                <a href="#" class="btn btn-warning btn-sm text-dark rounded-0 px-3">Setting</a>
            </div>
        </div>
    </div>
</nav>