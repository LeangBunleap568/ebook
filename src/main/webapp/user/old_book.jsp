<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.dao.impl.BookDAOImpl" %>
<%@ page import="com.ebook.db.DBconnect" %>
<%@ page import="com.ebook.entity.BookDtls" %>
<%@ page import="com.ebook.entity.user" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Old Books</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">
    <%@include file="../component/navbar.jsp" %>

    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp" />
    </c:if>

    <div class="container py-4 my-3">
        
        <%-- Top Header Bar --%>
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold m-0"><i class="fas fa-book me-2 text-primary"></i>My Listed Books</h4>
              
            </div>
            <a href="sell_book.jsp" class="btn btn-warning btn-sm fw-bold shadow-sm px-3">
                <i class="fas fa-plus me-1"></i> Sell Another Book
            </a>
        </div>

        <%-- Notification Alerts --%>
        <c:if test="${not empty succMsg}">
            <div class="alert alert-success alert-dismissible fade show text-center small mb-4" role="alert">
                ${succMsg}
                <c:remove var="succMsg" scope="session"/>
            </div>
        </c:if>
        <c:if test="${not empty failedMsg}">
            <div class="alert alert-danger alert-dismissible fade show text-center small mb-4" role="alert">
                ${failedMsg}
                <c:remove var="failedMsg" scope="session"/>
            </div>
        </c:if>

        <%
            user u = (user) session.getAttribute("userobj");
            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
            List<BookDtls> books = dao.getBookByOld(u.getEmail(), "Old");
        %>

        <c:choose>
            <c:when test="<%= books.isEmpty() %>">
                <div class="card p-5 text-center border-0 shadow-sm rounded-3">
                    <i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
                    <h5 class="fw-bold text-secondary">No books listed yet</h5>
                  
                    <div>
                        <a href="sell_book.jsp" class="btn btn-warning btn-sm fw-bold px-4">Sell Your First Book</a>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light text-secondary small">
                                    <tr>
                                        <th class="ps-4">#</th>
                                        <th>Book Name</th>
                                        <th>Author</th>
                                        <th>Price</th>
                                        <th>Category</th>
                                        <th class="text-end pe-4">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int i = 1; for (BookDtls b : books) { %>
                                        <tr>
                                            <td class="ps-4 text-muted small"><%= i++ %></td>
                                            <td class="fw-bold text-dark"><%= b.getBookName() %></td>
                                            <td class="text-muted"><%= b.getAuthor() %></td>
                                            <td class="fw-bold text-primary"><%= b.getPrice() %> ៛</td>
                                            <td>
                                                <span class="badge bg-warning text-dark border"><%= b.getBookCategory() %></span>
                                            </td>
                                            <td class="text-end pe-4">
                                                <a href="../delete_old_book?em=<%= b.getEmail() %>&id=<%= b.getBookId() %>"
                                                   class="btn btn-sm btn-outline-danger border-0 rounded-2"
                                                   onclick="return confirm('Are you sure you want to delete this book?')">
                                                    <i class="fas fa-trash-alt me-1"></i> Delete
                                                </a>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>