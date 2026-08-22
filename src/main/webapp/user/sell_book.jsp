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
    <title>Sell Old Book — Ebook Store</title>
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
        .section-header { 
            border-bottom: 2px solid var(--ui-border); 
            padding-bottom: 12px; 
            margin-bottom: 20px; 
        }
        .form-control, .input-group-text {
            border: 1px solid var(--ui-border);
            font-size: 0.875rem;
            background-color: #fff;
        }
        .form-control:focus {
            border-color: var(--ui-navy);
            box-shadow: none;
        }
        .input-group-text {
            background-color: #f8fafc;
            color: var(--ui-muted);
            font-weight: 600;
        }
        .btn-ui-primary { 
            background: var(--ui-navy); 
            color: #fff !important; 
            font-weight: 700; 
            font-size: 0.85rem; 
            text-transform: uppercase; 
            border: none;
            padding: 10px 16px;
            display: block;
            width: 100%;
            text-align: center;
            text-decoration: none;
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
            padding: 8px 16px;
        }
        .btn-ui-outline:hover { 
            background: var(--ui-navy); 
            color: #fff !important; 
        }
        .alert-ui-success {
            background: #f0fdf4;
            color: var(--ui-green);
            border: 1px solid var(--ui-green);
            font-size: 0.825rem;
            font-weight: 600;
            padding: 10px 14px;
        }
        .alert-ui-danger {
            background: #fef2f2;
            color: var(--ui-red);
            border: 1px solid var(--ui-red);
            font-size: 0.825rem;
            font-weight: 600;
            padding: 10px 14px;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <%@include file="../component/navbar.jsp" %>

    <div class="container p-3 p-md-4 my-auto flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">

                <%-- Main Technical Card --%>
                <div class="ui-card p-4 p-md-5">

                    <%-- Header Section --%>
                    <div class="section-header text-center">
                        <div class="d-inline-block p-3 mb-2" style="background: #f8fafc; border: 1px solid var(--ui-border);">
                            <i class="fas fa-book-open fa-2x" style="color: var(--ui-navy);"></i>
                        </div>
                        <h5 class="fw-bold text-uppercase m-0" style="color: var(--ui-navy);">Sell Your Book</h5>
                        <div class="small text-muted mt-1" style="font-size: 0.75rem;">Fill in the technical details to list your used book for sale</div>
                    </div>

                    <%-- Flash Messages --%>
                    <c:if test="${not empty succMsg}">
                        <div class="alert-ui-success text-center mb-4" role="alert">
                            <i class="fas fa-check-circle me-1"></i> ${succMsg}
                        </div>
                        <c:remove var="succMsg" scope="session"/>
                    </c:if>
                    
                    <c:if test="${not empty failedMsg}">
                        <div class="alert-ui-danger text-center mb-4" role="alert">
                            <i class="fas fa-exclamation-circle me-1"></i> ${failedMsg}
                        </div>
                        <c:remove var="failedMsg" scope="session"/>
                    </c:if>

                    <%-- Form --%>
                    <form action="${pageContext.request.contextPath}/user/add_old_book" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="email" value="${userobj.email}">
                        <input type="hidden" name="categories" value="Old">
                        <input type="hidden" name="status" value="Active">

                        <%-- Book Name --%>
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-uppercase text-muted" style="font-size: 0.75rem;">
                                Book Title <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-book"></i></span>
                                <input type="text" name="bname" class="form-control" placeholder="e.g. Java Programming" required>
                            </div>
                        </div>

                        <%-- Author Name --%>
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-uppercase text-muted" style="font-size: 0.75rem;">
                                Author Name <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user-edit"></i></span>
                                <input type="text" name="author" class="form-control" placeholder="e.g. James Rachels" required>
                            </div>
                        </div>

                        <%-- Price in KHR --%>
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-uppercase text-muted" style="font-size: 0.75rem;">
                                Price (USD) <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text fw-bold">$</span>
                                <input type="number" step="0.01" name="price" class="form-control" placeholder="e.g. 5.00" min="0" required>
                            </div>
                        </div>

                        <%-- Image Upload --%>
                        <div class="mb-4">
                            <label class="form-label small fw-bold text-uppercase text-muted" style="font-size: 0.75rem;">
                                Book Cover Photo <span class="text-danger">*</span>
                            </label>
                            <input type="file" name="bimg" class="form-control" accept="image/*" required>
                        </div>

                        <%-- Submit Button --%>
                        <button type="submit" class="btn-ui-primary mb-3">
                            <i class="fas fa-plus-circle me-1"></i> Post Book for Sale
                        </button>
                        
                        <div class="text-center">
                            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-ui-outline w-100">
                                <i class="fas fa-arrow-left me-1"></i> Cancel & Back
                            </a>
                        </div>
                    </form>

                </div>

            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>