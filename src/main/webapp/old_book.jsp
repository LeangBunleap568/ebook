<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ebook.dao.impl.BookDAOImpl" %>
<%@ page import="com.db.DBconnect" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="com.entity.user" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Old Books</title>
    <%@include file="component/rootCss.jsp" %>
</head>
<body class="bg-light">
    <%@include file="component/navbar.jsp" %>
    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>

    <div class="container p-4 my-4">
        <div class="card shadow-sm border-0">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="text-primary fw-bold m-0"><i class="fas fa-book me-2"></i> My Listed Old Books</h4>
                    <a href="sell_book.jsp" class="btn btn-warning btn-sm fw-bold">
                        <i class="fas fa-plus me-1"></i> Sell Another Book
                    </a>
                </div>

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
                    BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
                    List<BookDtls> books = dao.getBookByOld(u.getEmail(), "Old");
                %>

                <% if (books.isEmpty()) { %>
                    <div class="alert alert-warning text-center my-4">
                        <h5><i class="fas fa-exclamation-circle me-2"></i> You have not listed any old books yet.</h5>
                        <a href="sell_book.jsp" class="btn btn-warning mt-3">Sell Your First Book</a>
                    </div>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover align-middle text-center">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Book Name</th>
                                    <th>Author</th>
                                    <th>Price</th>
                                    <th>Category</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int i = 1; for (BookDtls b : books) { %>
                                <tr>
                                    <td><%= i++ %></td>
                                    <td><%= b.getBookName() %></td>
                                    <td><%= b.getAuthor() %></td>
                                    <td class="text-danger fw-bold"><%= b.getPrice() %> ៛</td>
                                    <td><span class="badge bg-warning text-dark"><%= b.getBookCategory() %></span></td>
                                    <td>
                                        <a href="delete_old_book?em=<%= b.getEmail() %>&id=<%= b.getBookId() %>"
                                           class="btn btn-sm btn-danger rounded-2"
                                           onclick="return confirm('Are you sure you want to delete this book?')">
                                            <i class="fas fa-trash-alt me-1"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>

            </div>
        </div>
    </div>

    <%@include file="component/footer.jsp" %>
</body>
</html>
