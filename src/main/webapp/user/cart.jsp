<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.app.entity.*, com.app.dao.impl.*, com.app.db.*, java.util.*" %>

<%-- Security Check --%>
<c:if test="${empty userobj}">
    <c:redirect url="../login.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart & Checkout - Classic Modern</title>
    <%@include file="../component/rootCss.jsp" %>
    <style>
        :root {
            --ui-bg-main: #f4f6f8;
            --ui-card-bg: #ffffff;
            --ui-navy-heading: #1e293b;
            --ui-text-main: #334155;
            --ui-text-muted: #64748b;
            --ui-border-light: #cbd5e1;
            --ui-btn-primary: #0f172a;
            --ui-green-accent: #27ae60;
            --ui-danger: #dc2626;
        }

        *, *::before, *::after {
            border-radius: 0px !important;
            backdrop-filter: none !important;
            -webkit-backdrop-filter: none !important;
        }

        body {
            background-color: var(--ui-bg-main) !important;
            color: var(--ui-text-main);
            font-family: system-ui, -apple-system, sans-serif;
        }

        .ui-card {
            background: var(--ui-card-bg);
            border: 2px solid var(--ui-border-light);
        }

        .card-header-title {
            border-bottom: 2px solid var(--ui-border-light);
            padding-bottom: 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .btn-ui-primary {
            background-color: var(--ui-navy-heading);
            color: #ffffff !important;
            border: 1px solid var(--ui-navy-heading);
            font-weight: 700;
            font-size: 0.85rem;
            text-transform: uppercase;
            transition: all 0.2s ease;
        }

        .btn-ui-primary:hover:not(:disabled) {
            background-color: #0f172a;
            border-color: #0f172a;
        }

        .btn-ui-primary:disabled {
            background-color: #94a3b8;
            border-color: #94a3b8;
            color: #ffffff !important;
            cursor: not-allowed;
        }

        .btn-ui-outline {
            background-color: #ffffff;
            color: var(--ui-navy-heading) !important;
            border: 1px solid var(--ui-border-light);
            font-weight: 700;
            font-size: 0.85rem;
            text-transform: uppercase;
            transition: all 0.2s ease;
        }

        .btn-ui-outline:hover {
            background-color: var(--ui-navy-heading);
            color: #ffffff !important;
        }

        .btn-ui-remove {
            color: var(--ui-danger) !important;
            background: #fef2f2;
            border: 1px solid #fee2e2;
            padding: 4px 10px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            transition: all 0.2s ease;
        }

        .btn-ui-remove:hover {
            background: var(--ui-danger);
            color: #ffffff !important;
        }

        .ui-table {
            color: var(--ui-text-main);
            border-color: var(--ui-border-light);
        }

        .ui-table thead {
            background-color: #f8fafc;
            border-bottom: 2px solid var(--ui-border-light);
        }

        .ui-table th {
            color: var(--ui-text-muted);
            font-weight: 700;
            font-size: 0.8rem;
            text-transform: uppercase;
            padding: 12px;
        }

        .ui-table td {
            border-color: var(--ui-border-light);
            padding: 14px 12px;
            vertical-align: middle;
            font-size: 0.9rem;
        }

        .form-label {
            font-size: 0.8rem;
            color: var(--ui-text-muted);
            font-weight: 700;
            text-transform: uppercase;
        }

        .form-control, .form-select {
            background-color: #ffffff;
            border: 1px solid var(--ui-border-light);
            color: var(--ui-text-main);
            padding: 8px 12px;
            font-size: 0.9rem;
        }

        .form-control:focus, .form-select:focus {
            background-color: #ffffff;
            border-color: var(--ui-navy-heading);
            color: var(--ui-text-main);
            box-shadow: none;
        }

        .form-control[readonly] {
            background-color: #f1f5f9;
            color: var(--ui-text-muted);
        }

        .badge-status {
            background-color: var(--ui-green-accent);
            color: #ffffff;
            font-size: 0.7rem;
            padding: 4px 8px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .summary-box {
            background-color: #f8fafc;
            border: 1px solid var(--ui-border-light);
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@include file="../component/navbar.jsp" %>
    
    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp"></c:redirect>
    </c:if>

    <div class="container p-3 p-md-4 my-2 my-md-3 flex-grow-1">
        <div class="row g-4">
            
            <!-- Left Side: Cart Items List -->
            <div class="col-lg-7">
                <div class="ui-card p-4 h-100 d-flex flex-column justify-content-between">
                    <div>
                        <div class="card-header-title mb-3">
                            <h5 class="fw-bold m-0 text-uppercase" style="color: var(--ui-navy-heading);">
                                <i class="fas fa-shopping-cart me-2"></i>Shopping Cart
                            </h5>
                            <span class="badge badge-status">Active</span>
                        </div>

                        <c:if test="${not empty succMsg}">
                            <div class="alert alert-success text-center py-2 mb-3 fs-7">${succMsg}</div>
                            <c:remove var="succMsg" scope="session"/>
                        </c:if>
                        <c:if test="${not empty failedMsg}">
                            <div class="alert alert-danger text-center py-2 mb-3 fs-7">${failedMsg}</div>
                            <c:remove var="failedMsg" scope="session"/>
                        </c:if>

                        <% 
                            user u = (user) session.getAttribute("userobj");
                            if (u == null) {
                                response.sendRedirect(request.getContextPath() + "/login.jsp");
                                return;
                            }
                            java.sql.Connection conn = DBconnect.getConn();
                            if (conn == null) {
                                response.sendRedirect(request.getContextPath() + "/error.jsp");
                                return;
                            }
                            CartDAOImpl dao = new CartDAOImpl(conn);
                            List<Cart> cartList = dao.getCartByUser(u.getId());
                            if (cartList == null) cartList = new java.util.ArrayList<>();
                            Double totalPrice = 0.0;
                            java.text.DecimalFormat formatter = new java.text.DecimalFormat("#,###");
                            for(Cart c : cartList){
                                totalPrice += c.getPrice();
                            }
                        %>

                        <% if(cartList.isEmpty()) { %>
                            <div class="text-center py-5 my-3">
                                <div class="p-3 d-inline-block mb-3 border bg-light">
                                    <i class="fas fa-shopping-bag fa-2x" style="color: var(--ui-text-muted);"></i>
                                </div>
                                <h5 class="fw-bold mb-2 text-uppercase" style="color: var(--ui-navy-heading);">Your Cart is Empty</h5>
                                <p class="small mb-4" style="color: var(--ui-text-muted);">
                                    There are no items currently in your shopping cart.
                                </p>
                                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-ui-primary px-4 py-2">
                                    Browse Books
                                </a>
                            </div>
                        <% } else { %>
                            <div class="table-responsive">
                                <table class="table ui-table align-middle">
                                    <thead>
                                        <tr>
                                            <th scope="col" class="text-start">Book Title</th>
                                            <th scope="col">Author</th>
                                            <th scope="col" class="text-center">Price</th>
                                            <th scope="col" class="text-end">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for(Cart c : cartList){ %>
                                        <tr>
                                            <td class="text-start fw-bold" style="color: var(--ui-navy-heading);">
                                                <%= c.getBookName() %>
                                            </td>
                                            <td style="color: var(--ui-text-muted);"><%= c.getAuthor() %></td>
                                            <td class="text-center fw-bold" style="color: var(--ui-green-accent);">$<%= formatter.format(c.getPrice()) %></td>
                                            <td class="text-end">
                                                <a href="${pageContext.request.contextPath}/user/remove_cart?cid=<%= c.getCid() %>&uid=<%= c.getUid() %>" class="btn btn-ui-remove">
                                                    Remove
                                                </a>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="summary-box p-3 my-3 d-flex justify-content-between align-items-center">
                                <span class="fw-bold small text-uppercase" style="color: var(--ui-text-muted);">Total Amount</span>
                                <span class="fw-bold fs-5" style="color: var(--ui-navy-heading);">$<%= formatter.format(totalPrice) %></span>
                            </div>
                        <% } %>
                    </div>

                    <div class="mt-3 border-top pt-3" style="border-color: var(--ui-border-light) !important;">
                        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-ui-outline px-3 py-2">
                            <i class="fas fa-arrow-left me-1"></i> Continue Shopping
                        </a>
                    </div>
                </div>
            </div>

            <!-- Right Side: Order Checkout Form -->
            <div class="col-lg-5">
                <div class="ui-card p-4">
                    <div class="card-header-title mb-3">
                        <h5 class="fw-bold m-0 text-uppercase" style="color: var(--ui-navy-heading);">
                            <i class="fas fa-truck me-2"></i>Order Delivery
                        </h5>
                        <span class="badge badge-status">Checkout</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/user/order" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label mb-1">Full Name</label>
                                <input type="text" name="name" class="form-control" value="${userobj.name}" required placeholder="Name">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label mb-1">Email</label>
                                <input type="email" name="email" class="form-control" value="${userobj.email}" required readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label mb-1">Phone Number</label>
                                <input type="text" name="phone" class="form-control" value="${userobj.phone}" required placeholder="012 345 678">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label mb-1">Street Address</label>
                                <input type="text" name="address" class="form-control" required placeholder="Street address">
                            </div>
                            <div class="col-12">
                                <label class="form-label mb-1">Landmark / Area</label>
                                <select name="landmark" id="landmark" class="form-select" required>
                                    <option value="" disabled selected>- Select Landmark -</option>
                                    <optgroup label="Phnom Penh">
                                        <option value="Tuol Tompoung Market">Tuol Tompoung Market</option>
                                        <option value="Orussey Market">Orussey Market</option>
                                        <option value="Central Market (Phsar Thmei)">Central Market (Phsar Thmei)</option>
                                        <option value="Aeon Mall 1">Aeon Mall 1</option>
                                    </optgroup>
                                    <optgroup label="Siem Reap">
                                        <option value="Angkor Wat Temple">Angkor Wat Temple</option>
                                        <option value="Old Market (Phsar Chas)">Old Market (Phsar Chas)</option>
                                    </optgroup>
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label mb-1">City / Region</label>
                                <select name="city" id="city" class="form-select" required onchange="updateStateAndPincode()">
                                    <option value="" disabled selected>- Select City -</option>
                                    <option value="Phnom Penh" data-state="Phnom Penh" data-pincode="12000">Phnom Penh</option>
                                    <option value="Siem Reap" data-state="Siem Reap" data-pincode="17000">Siem Reap</option>
                                    <option value="Battambang" data-state="Battambang" data-pincode="02000">Battambang</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label mb-1">Province / State</label>
                                <input type="text" name="state" id="state" class="form-control" placeholder="Auto-filled" readonly required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label mb-1">Postal Code</label>
                                <input type="text" name="pincode" id="pincode" class="form-control" placeholder="Auto-filled" readonly required>
                            </div>
                            
                            <div class="col-12 mt-2">
                                <label class="form-label mb-1">Payment Method</label>
                                <div class="summary-box p-3">
                                    <div class="form-check m-0">
                                        <input class="form-check-input me-2" type="radio" name="paymentType" value="COD" id="codRadio" checked>
                                        <label class="form-check-label fw-semibold" for="codRadio" style="color: var(--ui-navy-heading);">
                                            Cash on Delivery (COD)
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 mt-3">
                                <% if(cartList.isEmpty()) { %>
                                    <button type="submit" class="btn btn-ui-primary w-100 py-2" disabled>
                                        Cart is Empty
                                    </button>
                                <% } else { %>
                                    <button type="submit" class="btn btn-ui-primary w-100 py-2">
                                        Confirm Order
                                    </button>
                                <% } %>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
    
    <%@include file="../component/footer.jsp" %>

    <script>
        function updateStateAndPincode() {
            const citySelect = document.getElementById('city');
            const selectedOption = citySelect.options[citySelect.selectedIndex];
            document.getElementById('state').value   = selectedOption.getAttribute('data-state')   || '';
            document.getElementById('pincode').value = selectedOption.getAttribute('data-pincode') || '';
        }
    </script>
</body>
</html>