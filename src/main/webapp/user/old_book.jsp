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
    <title>My Old Books — Ebook Store</title>
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
            padding: 8px 16px;
            display: inline-block;
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
        .btn-ui-danger {
            background: #fff;
            color: var(--ui-red) !important;
            border: 1px solid var(--ui-red);
            font-weight: 700;
            font-size: 0.75rem;
            text-transform: uppercase;
            padding: 4px 10px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-ui-danger:hover {
            background: var(--ui-red);
            color: #fff !important;
        }
        .table-custom {
            width: 100%;
            border-collapse: collapse;
        }
        .table-custom th {
            background: #f8fafc;
            color: var(--ui-muted);
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            border-bottom: 2px solid var(--ui-border);
            padding: 12px;
        }
        .table-custom td {
            padding: 12px;
            border-bottom: 1px solid var(--ui-border);
            vertical-align: middle;
            font-size: 0.9rem;
        }
        .tag-badge {
            background: #e2e8f0;
            color: var(--ui-navy);
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            padding: 3px 8px;
            border: 1px solid var(--ui-border);
            display: inline-block;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@include file="../component/navbar.jsp" %>

    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp" />
    </c:if>

    <div class="container p-3 p-md-4 my-auto flex-grow-1">
        <div class="ui-card p-4">
            
            <!-- Section Header -->
            <div class="section-header d-flex flex-wrap justify-content-between align-items-center gap-2">
                <div>
                    <h5 class="fw-bold m-0 text-uppercase" style="color: var(--ui-navy);">
                        <i class="fas fa-book me-2"></i>My Listed Books
                    </h5>
                    <div class="small text-muted mt-1" style="font-size: 0.75rem;">Manage your old books currently listed for sale</div>
                </div>
                <a href="${pageContext.request.contextPath}/sell_book.jsp" class="btn-ui-primary">
                    <i class="fas fa-plus me-1"></i> Sell Another Book
                </a>
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

            <%
                user u = (user) session.getAttribute("userobj");
                BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
                List<BookDtls> books = dao.getBookByOld(u.getEmail(), "Old");
            %>

            <c:choose>
                <c:when test="<%= books.isEmpty() %>">
                    <div class="text-center py-5">
                        <i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
                        <h6 class="fw-bold text-uppercase" style="color: var(--ui-navy);">No books listed yet</h6>
                        <p class="small text-muted mb-4">You have not listed any old books for sale on the platform.</p>
                        <a href="${pageContext.request.contextPath}/sell_book.jsp" class="btn-ui-primary">
                            Sell Your First Book
                        </a>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table-custom">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">#</th>
                                    <th>Book Name</th>
                                    <th>Author</th>
                                    <th>Price</th>
                                    <th>Category</th>
                                    <th class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int i = 1; for (BookDtls b : books) { %>
                                    <tr>
                                        <td class="text-muted fw-bold small"><%= i++ %></td>
                                        <td class="fw-bold" style="color: var(--ui-navy);"><%= b.getBookName() %></td>
                                        <td class="text-muted"><%= b.getAuthor() %></td>
                                        <td class="fw-bold" style="color: var(--ui-navy);">$<%= b.getPrice() %></td>
                                        <td>
                                            <span class="tag-badge"><%= b.getBookCategory() %></span>
                                        </td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/delete_old_book?em=<%= b.getEmail() %>&id=<%= b.getBookId() %>"
                                               class="btn-ui-danger"
                                               onclick="return confirm('Are you sure you want to delete this book?')">
                                                <i class="fas fa-trash-alt me-1"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>