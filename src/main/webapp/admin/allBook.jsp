<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook App - All Books</title>
    <%@include file="../component/rootCss.jsp" %>
</head>
<body class="bg-light">

    <%@include file="../component/navbar.jsp" %>

    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold mb-0">All Books Inventory</h3>
            <a href="addBook.jsp" class="btn btn-dark btn-sm rounded-0 px-3">
                <i class="fas fa-plus"></i> Add New Book
            </a>
        </div>

        <div class="card border-0 rounded-0 shadow-sm p-4 bg-white">
            <div class="table-responsive">
                <table class="table align-middle table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">Cover</th>
                            <th scope="col">Title</th>
                            <th scope="col">Author</th>
                            <th scope="col">Category</th>
                            <th scope="col">Price (៛)</th>
                            <th scope="col">Status</th>
                            <th scope="col" class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNrdS1L8kXE59xg8bUsf5c7NXLBzjaAzoOU8rad0hcFZN6E0XvfgHfmUQ5&s=10" style="width: 40px; height: 50px; object-fit: cover;" alt="Cover"></td>
                            <td class="fw-bold">Java Programming</td>
                            <td>John Doe</td>
                            <td><span class="badge bg-secondary rounded-0">Recent</span></td>
                            <td>100,000 ៛</td>
                            <td><span class="text-success small fw-bold">Active</span></td>
                            <td class="text-center">
                                <a href="editBook.jsp?id=1" class="btn btn-sm btn-primary rounded-0 py-0 px-2" style="font-size: 12px;">Edit</a>
                                <a href="delete_book?id=1" class="btn btn-sm btn-danger rounded-0 py-0 px-2" style="font-size: 12px;">Delete</a>
                            </td>
                        </tr>
                        <tr>
                            <td><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5f5rrgQ-UrqMVfC7GQZrNfhYfW0ggDzr2TFwpICP9Ww&s=10" style="width: 40px; height: 50px; object-fit: cover;" alt="Cover"></td>
                            <td class="fw-bold">Java Spring Boot</td>
                            <td>Piseth Java</td>
                            <td><span class="badge bg-secondary rounded-0">New</span></td>
                            <td>300,000 ៛</td>
                            <td><span class="text-success small fw-bold">Active</span></td>
                            <td class="text-center">
                                <a href="editBook.jsp?id=2" class="btn btn-sm btn-primary rounded-0 py-0 px-2" style="font-size: 12px;">Edit</a>
                                <a href="delete_book?id=2" class="btn btn-sm btn-danger rounded-0 py-0 px-2" style="font-size: 12px;">Delete</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <%@include file="../component/footer.jsp" %>
</body>
</html>