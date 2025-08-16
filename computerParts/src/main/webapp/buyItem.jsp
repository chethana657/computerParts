<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.ItemModel" %>
<%@ page import="com.model.PaymentModel" %>
<%@ page import="com.DAO.ItemDao" %>
<%@ page import="com.DAO.PaymentDao" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.model.UserModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Item</title>
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
        .item-details, .payment-details {
            border: 1px solid #ddd;
            padding: 20px;
            background-color: #fff;
        }
    </style>
    <script>
        function updateTotalPrice() {
            const quantityInput = document.getElementById("quantity");
            const price = parseFloat(document.getElementById("itemPrice").innerText); // Get the item price from innerText
            const quantity = parseInt(quantityInput.value);
            const totalPrice = (price * quantity).toFixed(2); // Calculate total price

            // Update the total price input field
            document.getElementById("totalPrice").value = totalPrice; // Set the total price value
        }

        function increaseQuantity() {
            const quantityInput = document.getElementById("quantity");
            quantityInput.value = parseInt(quantityInput.value) + 1;
            updateTotalPrice(); // Update total price when quantity changes
        }

        function decreaseQuantity() {
            const quantityInput = document.getElementById("quantity");
            const currentQuantity = parseInt(quantityInput.value);
            if (currentQuantity > 1) {
                quantityInput.value = currentQuantity - 1;
                updateTotalPrice(); // Update total price when quantity changes
            }
        }

        document.addEventListener("DOMContentLoaded", function() {
            updateTotalPrice(); // Initialize total price on page load
        });
    </script>
</head>
<body>

<div class="container">
    <div class="row">
        <%
            // Get current session and check user login
            UserModel currentUser = (UserModel) session.getAttribute("currentUser");

            if (currentUser == null) {
                // Redirect to login if no user is logged in
                response.sendRedirect("login.jsp");
                return; // Ensure we stop further processing
            }

            // Get the item ID from the request
            String itemId = request.getParameter("id");
            if (itemId == null || itemId.isEmpty()) {
                response.sendRedirect("errorPage.jsp"); // Redirect to error page if itemId is missing
                return;
            }
            
            // Database connection
            Connection con = DBConnect.getConnection();
            ItemDao itemDao = new ItemDao(con);
            PaymentDao paymentDao = new PaymentDao(con);
            
            // Fetch the item details by itemId
            ItemModel item = itemDao.getItemById(Integer.parseInt(itemId));
            if (item == null) {
                response.sendRedirect("errorPage.jsp"); // Redirect if item not found
                return;
            }
            
            // Fetch payment methods for the current user
            List<PaymentModel> paymentMethods = paymentDao.getPaymentsByUserId(currentUser.getUserId());
        %>
        
        <div class="col-md-6">
            <div class="item-details">
                <h3>Item Details</h3>
                <img src="<%= item.getImgURL() %>" class="img-fluid" alt="<%= item.getItemName() %>" style="height: 200px; object-fit: cover;">
                <h4><%= item.getItemName() %></h4>
                <p><%= item.getDescription() %></p>
                <p><strong>Price:</strong> $<span id="itemPrice"><%= item.getPrice() %></span></p>
                <p><strong>Quantity Available:</strong> <%= item.getQuantity() %></p>
            </div>
        </div>

        <div class="col-md-6">
            <div class="payment-details">
                <h3>Confirm Payment</h3>
                <form action="/computerParts/CreateOrderServlet" method="post">
                    <!-- Hidden fields to store item and user details -->
                    <input type="hidden" name="itemId" value="<%= item.getInventoryId() %>">
                    <input type="hidden" name="userId" value="<%= currentUser.getUserId() %>">

                    <!-- Quantity selection -->
                    <div class="mb-3">
                        <label for="quantity" class="form-label">Quantity:</label>
                        <div class="input-group">
                            <button type="button" class="btn btn-outline-secondary" onclick="decreaseQuantity()">-</button>
                            <input type="number" id="quantity" name="quantity" class="form-control" value="1" min="1" onchange="updateTotalPrice()">
                            <button type="button" class="btn btn-outline-secondary" onclick="increaseQuantity()">+</button>
                        </div>
                    </div>

                    <!-- Total Price Display -->
                    <div class="mb-3">
                        <label for="totalPrice" class="form-label">Total Price:</label>
                        <input type="text" id="totalPrice" name="totalPrice" class="form-control" readonly>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" id="email" name="email" value="<%= currentUser.getEmail() %>" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label for="mobile" class="form-label">Mobile:</label>
                        <input type="text" id="mobile" name="mobile" value="<%= currentUser.getMobile() %>" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">Address:</label>
                        <textarea id="address" name="address" class="form-control" rows="3" required></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="paymentMethod" class="form-label">Select Payment Method:</label>
                        <select id="paymentMethod" name="paymentMethodId" class="form-select" required>
                            <option value="">-- Select Payment Method --</option>
                            <%
                                // Display available payment methods
                                for (PaymentModel payment : paymentMethods) {
                            %>
                                <option value="<%= payment.getPaymentId() %>">
                                    <%= "**** **** **** " + payment.getCardNumber().substring(payment.getCardNumber().length() - 4) %>
                                </option>
                            <%
                                }
                            %>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-success">Confirm Payment</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
