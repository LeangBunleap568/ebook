<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — Ebook Store</title>
    <%@include file="component/rootCss.jsp" %>
    <style>
        :root {
            --ui-primary: #2d6a4f;        /* ពណ៌បៃតងចាស់ល្មម ច្បាស់ភ្នែក (Deep Forest Green) */
            --ui-primary-hover: #1b4332;
            --ui-bg-light: #f4f6f8;       /* Background ប្រផេះស្រាល */
            --ui-card-border: #cbd5e1;    /* Border ច្បាស់ */
            --ui-text-dark: #1e293b;      /* អក្សរខ្មៅប្រផេះចាស់ ច្បាស់ខ្លាំង */
            --ui-text-muted: #64748b;     /* អក្សររងច្បាស់ល្មម */
            --ui-input-border: #94a3b8;   /* ព្រំប្រទល់ Input ច្បាស់ */
        }

        /* ស្ទាយបុរាណជ្រុងៗ 100% */
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
            max-width: 440px;
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

        .alert-inline {
            display: none;
            margin-bottom: 15px;
            padding: 10px 14px;
            border: 1px solid #f5c2c7;
            background-color: #f8d7da;
            color: #842029;
            font-size: 0.85rem;
            font-weight: 600;
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
        <div style="width: 100%; max-width: 440px;">
            
            <!-- Breadcrumb Navigation -->
            <div class="breadcrumb-text mb-3">
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a> &gt; <span class="text-secondary">Register</span>
            </div>

            <!-- Register Card -->
            <div class="ui-card">
                <div class="ui-card-header">
                    <span>Create Account</span>
                    <span class="counter-badge">NEW USER</span>
                </div>

                <div class="p-4">
                    <%-- Session Alert Messages --%>
                    <%
                        String error = (String) session.getAttribute("error");
                        String succMsg = (String) session.getAttribute("succMsg");
                        if (error != null) {
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

                    <div id="formAlert" class="alert-inline" role="alert"></div>

                    <form action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateRegisterForm();">
                        
                        <div class="mb-3">
                            <label class="form-label" for="name">Full Name</label>
                            <input type="text" id="name" name="name" class="form-control" placeholder="John Doe" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="email">Email Address</label>
                            <input type="email" id="email" name="email" class="form-control" placeholder="name@example.com" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone" class="form-control" placeholder="012 345 678" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="password">Password</label>
                            <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="confirm_password">Confirm Password</label>
                            <input type="password" id="confirm_password" name="confirm_password" class="form-control" placeholder="••••••••" required>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mt-4">
                            <a href="${pageContext.request.contextPath}/login.jsp" class="text-decoration-none small text-dark fw-bold">Back to Login</a>
                            <button type="submit" class="btn btn-ui-action">
                                Register <i class="fas fa-arrow-right ms-1"></i>
                            </button>
                        </div>
                    </form>
                </div>

                <div class="bg-light p-3 border-top text-center" style="border-top-color: var(--ui-card-border) !important;">
                    <span class="small text-dark fw-semibold">Already have an account? </span>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="small text-link">
                        Sign In
                    </a>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function validateRegisterForm() {
            const alertBox = document.getElementById('formAlert');
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const pw = document.getElementById('password').value;
            const cpw = document.getElementById('confirm_password').value;

            if (!name || !email || !phone || !pw || !cpw) {
                alertBox.textContent = 'Please fill in all fields.';
                alertBox.style.display = 'block';
                return false;
            }

            if (pw !== cpw) {
                alertBox.textContent = 'Passwords do not match.';
                alertBox.style.display = 'block';
                return false;
            }

            alertBox.style.display = 'none';
            return true;
        }
    </script>
</body>
</html>