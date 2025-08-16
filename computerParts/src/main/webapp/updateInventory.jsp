<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.DAO.ItemDao" %>
<%@ page import="com.model.ItemModel" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Inventory Item</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f2f7fa;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 30px;
        }
        .sidebar {
            min-height: 100vh; /* Full height sidebar */
        }
        .sidebar {
            background-color: #ffffff; /* White background for sidebar */
            border-right: 1px solid #dc3545; /* Red border */
        }
        .sidebar h4 {
            color: #dc3545; /* Red color for sidebar heading */
        }
        .sidebar .nav-link {
            color: #333; /* Dark text for links */
        }
        .sidebar .nav-link:hover {
            color: #dc3545; /* Red on hover */
        }
        h2 {
            color: #dc3545; /* Red color for heading */
            text-align: center;
            margin-bottom: 20px;
        }
        .btn-primary {
            background-color: #dc3545; /* Red background for primary buttons */
            border: none;
        }
        .btn-secondary {
            background-color: #6c757d; /* Gray background for secondary button */
            border: none;
        }
        .btn-secondary:hover {
            background-color: #5a6268; /* Darker gray on hover */
        }
        .btn-primary:hover {
            background-color: #c82333; /* Darker red on hover */
        }
    </style>
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar -->
        <nav class="sidebar">
            <h4>Admin Menu</h4>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="admin_dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="inventory.jsp">Inventory Management</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="addInventory.jsp">Add Inventory</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Reports</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Settings</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Logout</a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <div class="container mt-5 ms-3">
            <h2>Update Inventory Item</h2>

            <%
                int itemId = Integer.parseInt(request.getParameter("id"));
                Connection conn = DBConnect.getConnection();
                ItemDao itemDao = new ItemDao(conn);
                ItemModel item = itemDao.getItemById(itemId); // Get item by ID

                if (item == null) {
                    response.sendRedirect("inventory.jsp");
                    return; // Stop processing if the item is not found
                }
            %>

            <form action="/computerParts/UpdateItemServlet?id=<%= itemId %>" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="itemName" class="form-label">Item Name</label>
                    <input type="text" class="form-control" id="itemName" name="itemName" value="<%= item.getItemName() %>" required>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="description" required><%= item.getDescription() %></textarea>
                </div>
                <div class="mb-3">
                    <label for="price" class="form-label">Price</label>
                    <input type="number" class="form-control" id="price" name="price" value="<%= item.getPrice() %>" step="0.01" required>
                </div>
                <div class="mb-3">
                    <label for="quantity" class="form-label">Quantity</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" value="<%= item.getQuantity() %>" required>
                </div>
                <div class="mb-3">
                    <label for="imgFile" class="form-label">Upload Image (optional)</label>
                    <input type="file" class="form-control" id="imgFile" name="imgFile">
                </div>
                <div class="mb-3">
                    <label class="form-label">Current Image</label>
                    <div>
                        <img src="<%= item.getImgURL() %>" alt="<%= item.getItemName() %>" style="width: 100px; height: auto;">
                    </div>
                </div>
                <input type="hidden" name="currentImageURL" value="<%= item.getImgURL() %>"> <!-- Hidden input for current image URL -->
                <button type="submit" class="btn btn-primary">Update Item</button>
                <a href="inventory.jsp" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
