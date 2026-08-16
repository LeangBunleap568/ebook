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
                                    <select name="landmark" id="landmark" class="form-select" required>
                                        <option value="" disabled selected>— Select Landmark —</option>
                                        <optgroup label="Phnom Penh">
                                            <option value="Tuol Tompoung Market">Tuol Tompoung Market</option>
                                            <option value="Orussey Market">Orussey Market</option>
                                            <option value="Central Market (Phsar Thmei)">Central Market (Phsar Thmei)</option>
                                            <option value="Olympic Market">Olympic Market</option>
                                            <option value="Boeng Keng Kang Market">Boeng Keng Kang Market</option>
                                            <option value="Aeon Mall 1">Aeon Mall 1</option>
                                            <option value="Aeon Mall 2">Aeon Mall 2</option>
                                            <option value="Royal Palace Area">Royal Palace Area</option>
                                        </optgroup>
                                        <optgroup label="Siem Reap">
                                            <option value="Angkor Wat Temple">Angkor Wat Temple</option>
                                            <option value="Old Market (Phsar Chas)">Old Market (Phsar Chas)</option>
                                            <option value="Pub Street Area">Pub Street Area</option>
                                        </optgroup>
                                        <optgroup label="Battambang">
                                            <option value="Battambang Market">Battambang Market</option>
                                            <option value="Bamboo Train Area">Bamboo Train Area</option>
                                        </optgroup>
                                        <optgroup label="Sihanoukville">
                                            <option value="Serendipity Beach">Serendipity Beach</option>
                                            <option value="Ochheuteal Beach">Ochheuteal Beach</option>
                                        </optgroup>
                                        <optgroup label="Kampot">
                                            <option value="Kampot Riverside">Kampot Riverside</option>
                                        </optgroup>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">City</label>
                                    <select name="city" id="city" class="form-select" required onchange="updateStateAndPincode()">
                                        <option value="" disabled selected>— Select City —</option>
                                        <option value="Phnom Penh" data-state="Phnom Penh" data-pincode="12000">Phnom Penh</option>
                                        <option value="Siem Reap" data-state="Siem Reap" data-pincode="17000">Siem Reap</option>
                                        <option value="Battambang" data-state="Battambang" data-pincode="02000">Battambang</option>
                                        <option value="Sihanoukville" data-state="Preah Sihanouk" data-pincode="18000">Sihanoukville</option>
                                        <option value="Kampot" data-state="Kampot" data-pincode="07000">Kampot</option>
                                        <option value="Kampong Cham" data-state="Kampong Cham" data-pincode="04000">Kampong Cham</option>
                                        <option value="Kampong Chhnang" data-state="Kampong Chhnang" data-pincode="05000">Kampong Chhnang</option>
                                        <option value="Kampong Speu" data-state="Kampong Speu" data-pincode="06000">Kampong Speu</option>
                                        <option value="Kandal" data-state="Kandal" data-pincode="10000">Kandal</option>
                                        <option value="Takeo" data-state="Takeo" data-pincode="08000">Takeo</option>
                                        <option value="Prey Veng" data-state="Prey Veng" data-pincode="12310">Prey Veng</option>
                                        <option value="Svay Rieng" data-state="Svay Rieng" data-pincode="15000">Svay Rieng</option>
                                        <option value="Pursat" data-state="Pursat" data-pincode="09000">Pursat</option>
                                        <option value="Koh Kong" data-state="Koh Kong" data-pincode="16000">Koh Kong</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Province / State</label>
                                    <input type="text" name="state" id="state" class="form-control" placeholder="Auto-filled from City" readonly required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Postal Code</label>
                                    <input type="text" name="pincode" id="pincode" class="form-control" placeholder="Auto-filled from City" readonly required>
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


