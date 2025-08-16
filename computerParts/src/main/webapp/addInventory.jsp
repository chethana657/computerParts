<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Inventory</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Add your custom styles here */
        body {
            background-color: #f2f7fa;
            font-family: Arial, sans-serif;
        }

        /* Sidebar Styles */
        .sidebar {
            min-height: 100vh; /* Full height sidebar */
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

        /* Button Styles */
        .btn-primary {
            background-color: #dc3545; /* Red color */
            border-color: #dc3545; /* Red border */
        }
        .btn-primary:hover {
            background-color: #c82333; /* Darker red on hover */
            border-color: #bd2130; /* Darker red border on hover */
        }

        /* Container Styles */
        .container {
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

<div class="d-flex">
    <!-- Sidebar -->
    <nav class="sidebar p-3">
        <h4>Admin Menu</h4>
        <ul class="nav flex-column">
            <li class="nav-item">
                    <a class="nav-link active" href="admin_dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="inventory.jsp">Inventory Management</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="addInventory.jsp">Add Inventory</a>
                </li>
                
            <li class="nav-item">
                        <a class="nav-link" href="admin_allOrders.jsp">All Orders</a>
                    </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Settings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Logout</a>
            </li>
        </ul>
    </nav>

    <div class="container flex-grow-1 mt-5">
        <h2 class="text-center">Add New Item to Inventory</h2>
        
        <form action="/computerParts/AddInventoryServlet" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="itemName" class="form-label">Item Name:</label>
                <input type="text" id="itemName" name="itemName" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Description:</label>
                <textarea id="description" name="description" class="form-control" required></textarea>
            </div>

            <div class="mb-3">
                <label for="price" class="form-label">Price:</label>
                <input type="number" id="price" name="price" step="0.01" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="quantity" class="form-label">Quantity:</label>
                <input type="number" id="quantity" name="quantity" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="imgFile" class="form-label">Item Image:</label>
                <input type="file" id="imgFile" name="imgFile" class="form-control" accept="image/*" required>
            </div>

            <button type="submit" class="btn btn-primary">Add Item</button>
        </form>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
