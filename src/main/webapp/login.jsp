<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In — Ebook Store</title>
    <%@include file="component/rootCss.jsp" %>
    <style>
        :root {
            --ui-primary: #2d6a4f;        /* ពណ៌បៃតងចាស់ល្មម ច្បាស់ភ្នែក (Deep Forest Green) */
            --ui-primary-hover: #1b4332;
            --ui-bg-light: #f4f6f8;       /* Background ប្រផេះស្រាល */
            --ui-card-border: #cbd5e1;    /* Border ប្រផេះច្បាស់ */
            --ui-text-dark: #1e293b;      /* អក្សរខ្មៅប្រផេះចាស់ (High Contrast) */
            --ui-text-muted: #64748b;     /* អក្សររងច្បាស់ល្មម */
            --ui-input-border: #94a3b8;   /* ព្រំប្រទល់ Input ច្បាស់ */
        }

        /* Modern Classic Sharp Corners (បុរាណជ្រុងៗ 100%) */
        *, *::before, *::after {
            border-radius: 0 !important;
        }

        body, html {
            min-height: 100%;
            margin: 0;
            background-color: var(--ui-bg-light) !important;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            color: var(--ui-text-dark);
        }

        .workspace-wrapper {
            padding: 40px 20px;
            min-height: calc(100vh - 120px);
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        .ui-card {
            width: 100%;
            max-width: 420px;
            background: #ffffff;
            border: 2px solid var(--ui-card-border);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .ui-card-header {
            padding: 16px 20px;
            border-bottom: 2px solid var(--ui-card-border);
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--ui-text-dark);
            background-color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .counter-badge {
            background-color: var(--ui-primary);
            color: #ffffff;
            font-size: 0.7rem;
            font-weight: 700;
            padding: 3px 8px;
            letter-spacing: 1px;
        }

        .breadcrumb-text {
            color: var(--ui-text-muted);
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .breadcrumb-text a {
            color: var(--ui-text-dark);
            text-decoration: none;
        }

        .breadcrumb-text a:hover {
            color: var(--ui-primary);
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--ui-text-dark);
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            font-size: 0.9rem;
            border: 1px solid var(--ui-input-border) !important;
            padding: 10px 14px;
            background-color: #ffffff;
            color: var(--ui-text-dark);
        }

        .form-control:focus {
            border-color: var(--ui-primary) !important;
            box-shadow: 0 0 0 1px var(--ui-primary) !important;
            outline: none;
        }

        .btn-ui-action {
            background-color: var(--ui-primary);
            color: #ffffff;
            font-size: 0.9rem;
            font-weight: 700;
            border: none;
            padding: 10px 24px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: background-color 0.2s ease;
        }

        .btn-ui-action:hover {
            background-color: var(--ui-primary-hover);
            color: #ffffff;
        }

        .alert {
            font-size: 0.85rem;
            padding: 10px 14px;
            font-weight: 600;
        }

        .text-link {
            color: var(--ui-primary);
            font-weight: 700;
            text-decoration: none;
        }

        .text-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <%@include file="component/navbar.jsp" %>

    <div class="workspace-wrapper">
        <div style="width: 100%; max-width: 420px;">
            
            <div class="breadcrumb-text mb-3">
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a> &gt; <span class="text-secondary">Sign In</span>
            </div>

            <div class="ui-card">
                <div class="ui-card-header">
                    <span>Sign In</span>
                    <span class="counter-badge">SECURE</span>
                </div>

                <div class="p-4">
                    <%-- Session Feedback Messages --%>
                    <%
                        String failedMsg = (String) session.getAttribute("failedMsg");
                        String error = (String) session.getAttribute("error");
                        String succMsg = (String) session.getAttribute("succMsg");

                        if (failedMsg != null) {
                    %>
                            <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                                <i class="fas fa-exclamation-circle me-1"></i> <%= failedMsg %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                    <%
                            session.removeAttribute("failedMsg");
                        } else if (error != null) {
                    %>
                            <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                                <i class="fas fa-exclamation-circle me-1"></i> <%= error %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                    <%
                            session.removeAttribute("error");
                        }
                        if (succMsg != null) {
                    %>
                            <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                                <i class="fas fa-check-circle me-1"></i> <%= succMsg %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                    <%
                            session.removeAttribute("succMsg");
                        }
                    %>

                  <form action="${pageContext.request.contextPath}/user/login" method="post">
                        <div class="mb-3">
                            <label class="form-label" for="emailExampleInput">Email Address</label>
                            <input type="email" name="email" id="emailExampleInput" class="form-control" placeholder="name@example.com" required autocomplete="off">
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="passwordExampleInput">Password</label>
                            <input type="password" name="password" id="passwordExampleInput" class="form-control" placeholder="••••••••" required autocomplete="new-password">
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center mt-4">
                            <a href="#" class="text-decoration-none small text-dark fw-bold">Forgot password?</a>
                            <button type="submit" class="btn btn-ui-action">
                                Sign In <i class="fas fa-arrow-right ms-1"></i>
                            </button>
                        </div>
                    </form>
                </div>

                <div class="bg-light p-3 border-top text-center" style="border-top-color: var(--ui-card-border) !important;">
                    <span class="small text-dark fw-semibold">Don't have an account? </span>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="small text-link">
                        Sign Up
                    </a>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>