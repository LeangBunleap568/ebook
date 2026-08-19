<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook Store - Login</title>
    <%@include file="component/rootCss.jsp" %>
    <style>
        :root {
            --color-amber-yellow: #f5a623; 
            --color-coral-pink: #f05a66;   
            --color-emerald-green: #00b074; 
            --color-dark-slate: #2d404e;   
            --color-brand-blue: #303f9f;
            --color-brand-blue-hover: #1a237e;
            --color-light-bg: #f8fafc;     
            --color-card-white: #ffffff;   
            --color-input-bg: #f8fafc;     
            --color-input-border: #e2e8f0; 
            --color-text-dark: #1e293b;    
            --color-text-muted: #64748b;   
        }

        body, html {
            height: 100%;
            margin: 0;
            background-color: var(--color-light-bg) !important;
            color: var(--color-text-dark);
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            -webkit-font-smoothing: antialiased;
        }

        .navbar {
            padding-top: 0.5rem !important;
            padding-bottom: 0.5rem !important;
            min-height: 60px;
        }

        .login-wrapper {
            background-color: var(--color-light-bg) !important;
            padding: 60px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 120px);
        }

        .login-box {
            width: 100%;
            max-width: 440px;
            background-color: var(--color-card-white);
            padding: 40px 32px;
            border-radius: 16px;
            border: 1px solid var(--color-input-border);
            box-shadow: 0 12px 32px rgba(45, 64, 78, 0.08);
            position: relative;
            overflow: hidden;
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }

        /* Accent Line */
        .login-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background-color: var(--color-amber-yellow);
        }

        .icon-badge {
            width: 64px;
            height: 64px;
            background-color: rgba(245, 166, 35, 0.12);
            color: var(--color-amber-yellow);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 12px;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.875rem;
            color: var(--color-text-dark);
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 8px !important;
            border: 1px solid var(--color-input-border);
            background-color: var(--color-input-bg);
            padding: 11px 16px;
            font-size: 0.95rem;
            color: var(--color-text-dark);
            transition: all 0.2s ease;
        }

        .form-control:focus {
            background-color: #ffffff;
            border-color: var(--color-brand-blue);
            box-shadow: 0 0 0 4px rgba(48, 63, 159, 0.12);
        }

        /* Input Group with Password Toggle */
        .input-group-text {
            border-radius: 0 8px 8px 0 !important;
            border: 1px solid var(--color-input-border);
            border-left: none;
            background-color: var(--color-input-bg);
            color: var(--color-text-muted);
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .input-group .form-control {
            border-radius: 8px 0 0 8px !important;
        }

        .input-group:focus-within .input-group-text {
            background-color: #ffffff;
            border-color: var(--color-brand-blue);
        }

        /* Sign-in Button Style */
        .btn-signin {
            background-color: var(--color-brand-blue) !important;
            color: #ffffff !important;
            border: none;
            border-radius: 8px !important;
            padding: 11px 24px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.25s ease;
            box-shadow: 0 4px 12px rgba(48, 63, 159, 0.2);
        }

        .btn-signin:hover {
            background-color: var(--color-brand-blue-hover) !important;
            color: #ffffff !important;
            box-shadow: 0 6px 16px rgba(26, 35, 126, 0.3);
            transform: translateY(-1px);
        }

        .btn-signin:active {
            transform: translateY(0);
        }

        .alert {
            border-radius: 8px;
            font-size: 0.875rem;
            border: none;
        }

        .alert-danger {
            background-color: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .alert-success {
            background-color: #f0fdf4;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .link-brand {
            color: var(--color-brand-blue);
            transition: color 0.2s ease;
        }

        .link-brand:hover {
            color: var(--color-brand-blue-hover);
        }
    </style>
</head>
<body>

    <%@include file="component/navbar.jsp" %>

    <div class="login-wrapper">
        <div class="login-box">
            
            <div class="text-center mb-4">
                <div class="icon-badge">
                    <i class="fas fa-lock"></i>
                </div>
                <h3 class="fw-bold mb-1" style="color: var(--color-dark-slate);">Welcome Back</h3>
                <p class="text-muted small mb-0">Enter your credentials to access your account</p>
            </div>

            <%
                String failedMsg = (String) session.getAttribute("failedMsg");
                String error = (String) session.getAttribute("error");
                String succMsg = (String) session.getAttribute("succMsg");

                if (failedMsg != null) {
            %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-1"></i> <%= failedMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
            <%
                    session.removeAttribute("failedMsg");
                } else if (error != null) {
            %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-1"></i> <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
            <%
                    session.removeAttribute("error");
                }
                if (succMsg != null) {
            %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-1"></i> <%= succMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
            <%
                    session.removeAttribute("succMsg");
                }
            %>

            <form action="${pageContext.request.contextPath}/login" method="post" autocomplete="off">
                <div class="mb-3">
                    <label class="form-label" for="emailExampleInput">Email or Username</label>
                    <input type="text" name="email" id="emailExampleInput" class="form-control" placeholder="name@example.com" required autocomplete="off">
                </div>

                <div class="mb-3">
                    <label class="form-label" for="passwordExampleInput">Password</label>
                    <div class="input-group">
                        <input type="password" name="password" id="passwordExampleInput" class="form-control" placeholder="••••••••" required autocomplete="new-password">
                        <span class="input-group-text" id="togglePassword">
                            <i class="fas fa-eye-slash" id="toggleIcon"></i>
                        </span>
                    </div>
                </div>
                
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="#" class="text-decoration-none small text-muted">Need help?</a>
                    <button type="submit" class="btn btn-signin px-4">Sign in <i class="fas fa-arrow-right ms-1"></i></button>
                </div>
            </form>

            <div class="mt-4 pt-3 border-top text-center">
                <p class="small text-muted mb-0">Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp" class="fw-semibold text-decoration-none link-brand">Register here</a></p>
            </div>

        </div>
    </div>

    <%@include file="component/footer.jsp" %>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const togglePassword = document.querySelector("#togglePassword");
            const password = document.querySelector("#passwordExampleInput");
            const toggleIcon = document.querySelector("#toggleIcon");

            if (togglePassword && password && toggleIcon) {
                togglePassword.addEventListener("click", function () {
                    const type = password.getAttribute("type") === "password" ? "text" : "password";
                    password.setAttribute("type", type);
                    
                    toggleIcon.classList.toggle("fa-eye");
                    toggleIcon.classList.toggle("fa-eye-slash");
                });
            }
        });
    </script>
</body>
</html>