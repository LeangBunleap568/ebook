<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App - Edit Book</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">

    <%@include file="../component/navbar.jsp" %>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-0 rounded-0 shadow-sm p-4 bg-white">
                    <h3 class="text-center fw-bold mb-4">Edit Book Details</h3>

                    <form action="../editBooks" method="post">
                        <input type="hidden" name="id" value="${param.id}">
                        
                        <div class="mb-4">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Book Name</label>
                                    <input type="text" class="form-control rounded-0" name="bname" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Author Name</label>
                                    <input type="text" class="form-control rounded-0" name="author" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Price (៛ Riel)</label>
                                    <input type="number" step="100" class="form-control rounded-0" name="price" placeholder="e.g. 10000" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small">Book Status</label>
                                    <select class="form-select rounded-0" name="status">
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-dark rounded-0 py-2 fw-bold">Update Book</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>
