<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.dao.impl.CartDAOImpl" %>
<%@ page import="com.ebook.db.DBconnect" %>
<%@ page import="com.ebook.entity.Cart" %>
<%@ page import="com.ebook.entity.user" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">
    <%@include file="../component/navbar.jsp" %>
    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>

    <div class="container p-4 my-4">
        <div class="row">
            <!-- Left Side: Cart Items -->
            <div class="col-md-7">
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <h4 class="text-primary fw-bold mb-4"><i class="fas fa-shopping-cart me-2"></i> Your Cart Items</h4>
                        
                        <c:if test="${not empty succMsg}">
                            <div class="alert alert-success text-center">${succMsg}</div>
                            <c:remove var="succMsg" scope="session"/>
                        </c:if>
                        <c:if test="${not empty failedMsg}">
                            <div class="alert alert-danger text-center">${failedMsg}</div>
                            <c:remove var="failedMsg" scope="session"/>
                        </c:if>

                        <% 
                            user u = (user) session.getAttribute("userobj");
                            CartDAOImpl dao = new CartDAOImpl(DBconnect.getConn());
                            List<Cart> cartList = dao.getCartByUser(u.getId());
                            Double totalPrice = 0.0;
                            for(Cart c : cartList){
                                totalPrice += c.getPrice();
                            }
                        %>

                        <% if(cartList.isEmpty()) { %>
                            <div class="alert alert-warning text-center my-4">
                                <h5><i class="fas fa-exclamation-circle me-2"></i> Your cart is empty.</h5>
                                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary mt-3">Start Shopping</a>
                            </div>
                        <% } else { %>
                            <table class="table table-striped table-hover align-middle">
                                <thead class="table-dark text-center">
                                    <tr>
                                        <th scope="col">Book Name</th>
                                        <th scope="col">Author</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for(Cart c : cartList){ %>
                                    <tr class="text-center">
                                        <td><%= c.getBookName() %></td>
                                        <td><%= c.getAuthor() %></td>
                                        <td class="text-danger fw-bold"><%= c.getPrice() %> ៛</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/remove_cart?cid=<%= c.getCid() %>&uid=<%= c.getUid() %>" class="btn btn-sm btn-danger rounded-2">
                                                <i class="fas fa-trash-alt me-1"></i> Remove
                                            </a>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <tr class="text-center table-light">
                                        <td colspan="2" class="text-end fw-bold">Total Price: ៛</td>
                                        <td class="text-success fw-bold fs-5"><%= totalPrice %> ៛</td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                            
                            <div class="d-flex justify-content-between align-items-center mt-4 border-top pt-3">
                                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-secondary"><i class="fas fa-arrow-left me-1"></i> Continue Shopping</a>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Right Side: Order Details Form -->
            <div class="col-md-5">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <h4 class="text-success fw-bold mb-4"><i class="fas fa-map-marker-alt me-2"></i> Order Details</h4>
                        <form action="${pageContext.request.contextPath}/order" method="post">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Name</label>
                                    <input type="text" name="name" class="form-control" value="${userobj.name}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" value="${userobj.email}" required readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Phone</label>
                                    <input type="text" name="phone" class="form-control" value="${userobj.phone}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Address</label>
                                    <input type="text" name="address" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Landmark</label>
                                    <input type="text" name="landmark" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">City</label>
                                    <input type="text" name="city" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">State</label>
                                    <input type="text" name="state" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Pincode</label>
                                    <input type="text" name="pincode" class="form-control" required>
                                </div>
                                <div class="col-12 mt-3">
                                    <label class="form-label d-block fw-bold">Payment Mode</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="paymentType" value="COD" id="codRadio" checked>
                                        <label class="form-check-label" for="codRadio">
                                            Cash on Delivery (COD)
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12 mt-4">
                                    <% if(cartList.isEmpty()) { %>
                                        <button type="submit" class="btn btn-warning w-100" disabled>Order Now</button>
                                    <% } else { %>
                                        <button type="submit" class="btn btn-warning w-100 fw-bold shadow-sm">Order Now</button>
                                    <% } %>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    
    <%@include file="../component/footer.jsp" %>
</body>
</html>


