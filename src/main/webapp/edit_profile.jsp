<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <%@include file="component/rootCss.jsp" %>
</head>
<body class="bg-light">
    <%@include file="component/navbar.jsp" %>
    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>

    <div class="container p-4 my-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <div class="text-center mb-4">
                            <div style="width:80px;height:80px;border-radius:50%;background:rgba(48,63,159,0.1);display:flex;align-items:center;justify-content:center;margin:0 auto;">
                                <i class="fas fa-user-edit fa-3x text-primary"></i>
                            </div>
                            <h4 class="fw-bold text-primary mt-3">Edit Profile</h4>
                        </div>

                        <c:if test="${not empty succMsg}">
                            <div class="alert alert-success text-center">${succMsg}</div>
                            <c:remove var="succMsg" scope="session"/>
                        </c:if>
                        <c:if test="${not empty failedMsg}">
                            <div class="alert alert-danger text-center">${failedMsg}</div>
                            <c:remove var="failedMsg" scope="session"/>
                        </c:if>

                        <form action="update_profile" method="POST">
                            <input type="hidden" name="id" value="${userobj.id}">

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Full Name</label>
                                <input type="text" name="name" class="form-control" value="${userobj.name}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Email Address</label>
                                <input type="email" name="email" class="form-control" value="${userobj.email}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Phone Number</label>
                                <input type="text" name="phone" class="form-control" value="${userobj.phone}">
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-semibold">Current Password <span class="text-danger">*</span></label>
                                <input type="password" name="password" class="form-control" placeholder="Enter current password to confirm" required>
                                <div class="form-text text-muted">Your password is required to save changes.</div>
                            </div>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary w-100 fw-bold">
                                    <i class="fas fa-save me-1"></i> Update Profile
                                </button>
                                <a href="setting.jsp" class="btn btn-outline-secondary w-100">Cancel</a>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="component/footer.jsp" %>
</body>
</html>
