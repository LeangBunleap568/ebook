<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${empty userobj}">
    <c:redirect url="../login.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile — Ebook Store</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        :root { 
            --ui-bg: #f4f6f8; 
            --ui-card: #ffffff; 
            --ui-navy: #1e293b; 
            --ui-text: #334155; 
            --ui-muted: #64748b; 
            --ui-border: #cbd5e1; 
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
            text-align: center;
            text-decoration: none;
            padding: 8px;
        }
        .btn-ui-outline:hover { 
            background: var(--ui-navy); 
            color: #fff !important; 
        }
        .form-label { 
            font-size: 0.8rem; 
            color: var(--ui-muted); 
            font-weight: 700; 
            text-transform: uppercase; 
        }
        .form-control { 
            border: 1px solid var(--ui-border); 
            padding: 10px 12px; 
            font-size: 0.9rem; 
        }
        .form-control:focus {
            border-color: var(--ui-navy);
            box-shadow: none;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@include file="../component/navbar.jsp" %>

    <div class="container p-3 p-md-4 my-auto flex-grow-1 d-flex align-items-center justify-content-center">
        <div class="row w-100 justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">
                <div class="ui-card p-4">
                    
                    <!-- Section Header -->
                    <div class="section-header d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold m-0 text-uppercase" style="color: var(--ui-navy);">
                            <i class="fas fa-user-edit me-2"></i>Edit Profile
                        </h5>
                        <span class="badge bg-dark">Account</span>
                    </div>

                    <!-- Alert Messages -->
                    <c:if test="${not empty succMsg}">
                        <div class="alert alert-success text-center p-2 mb-3 small fw-bold">${succMsg}</div>
                        <c:remove var="succMsg" scope="session"/>
                    </c:if>
                    <c:if test="${not empty failedMsg}">
                        <div class="alert alert-danger text-center p-2 mb-3 small fw-bold">${failedMsg}</div>
                        <c:remove var="failedMsg" scope="session"/>
                    </c:if>

                    <!-- Profile Form -->
                    <form action="${pageContext.request.contextPath}/user/update_profile" method="POST" class="row g-3">
                        <input type="hidden" name="id" value="${userobj.id}">

                        <div class="col-12">
                            <label class="form-label mb-1">Full Name</label>
                            <input type="text" name="name" class="form-control" value="${userobj.name}" required placeholder="Enter full name">
                        </div>

                        <div class="col-12">
                            <label class="form-label mb-1">Email Address</label>
                            <input type="email" name="email" class="form-control" value="${userobj.email}" required placeholder="name@example.com">
                        </div>

                        <div class="col-12">
                            <label class="form-label mb-1">Phone Number</label>
                            <input type="text" name="phone" class="form-control" value="${userobj.phone}" placeholder="Enter phone number">
                        </div>

                        <div class="col-12">
                            <label class="form-label mb-1">Current Password <span class="text-danger">*</span></label>
                            <input type="password" name="password" class="form-control" placeholder="Enter current password to confirm" required autocomplete="current-password">
                            <div class="small text-muted mt-1" style="font-size: 0.75rem;">Your password is required to save changes.</div>
                        </div>

                        <div class="col-12 mt-4">
                            <div class="row g-2">
                                <div class="col-6">
                                    <a href="${pageContext.request.contextPath}/setting.jsp" class="btn-ui-outline w-100">Cancel</a>
                                </div>
                                <div class="col-6">
                                    <button type="submit" class="btn btn-ui-primary w-100 py-2">
                                        <i class="fas fa-save me-1"></i> Update
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>