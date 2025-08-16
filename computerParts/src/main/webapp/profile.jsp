<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffe5e5; /* Light red background */
        }
        h2, h3 {
            color: #dc3545; /* Red color for headings */
        }
        .btn-red {
            background-color: #dc3545; /* Red button */
            color: white; /* White text on red buttons */
            border: none;
            width: 200px; /* Set a specific width for buttons */
        }
        .btn-red:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        .form-label {
            color: #6c757d; /* Subtle gray for labels */
        }
        .container {
            border: 1px solid #dc3545; /* Red border around container */
            border-radius: 5px; /* Rounded corners */
            padding: 20px; /* Padding for the container */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Shadow for depth */
        }
        #changePasswordForm {
            display: none; /* Initially hide the change password form */
        }
        .sidebar {
            background-color: #dc3545; /* Red background for sidebar */
            height: 100vh; /* Full height */
            padding: 15px; /* Padding for sidebar */
        }
        .sidebar a {
            color: white; /* White text for sidebar links */
            text-decoration: none; /* No underline */
            padding: 10px; /* Padding for links */
            display: block; /* Make links block level */
        }
        .sidebar a:hover {
            background-color: #c82333; /* Darker red on hover */
        }
    </style>
    <script>
        function toggleChangePassword() {
            var checkBox = document.getElementById("changePasswordCheck");
            var form = document.getElementById("changePasswordForm");
            form.style.display = checkBox.checked ? "block" : "none"; // Show or hide based on checkbox
        }
    </script>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 sidebar">
                <h4 class="text-center">Menu</h4>
                <a href="home.jsp">Home</a>
                <a href="profile.jsp">Profile</a>
                <a href="myOrders.jsp">My Orders</a>
                <a href="addPaymentMethod.jsp">Add Payment</a> <!-- Link to Add Payment page -->
                <a href="myPaymentMethod.jsp">My Payments</a> <!-- Link to My Payments page -->
                <a href="logout.jsp">Logout</a>
            </div>
            <div class="col-md-10">
                <div class="container mt-5">
                    <h2 class="text-center">User Profile</h2>

                    <!-- Retrieve the user object from session -->
                    <c:set var="currentUser" value="${sessionScope.currentUser}" />
                    
                    <c:if test="${not empty currentUser}">
                        <h3 class="mt-4">Profile Details</h3>
                        <form action="/computerParts/UpdateProfileServlet" method="post">
                            <input type="hidden" name="userId" value="${currentUser.userId}">
                            
                            <div class="mb-3">
                                <label for="firstName" class="form-label">First Name:</label>
                                <input type="text" id="firstName" name="firstName" value="${currentUser.firstName}" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="lastName" class="form-label">Last Name:</label>
                                <input type="text" id="lastName" name="lastName" value="${currentUser.lastName}" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email:</label>
                                <input type="email" id="email" name="email" value="${currentUser.email}" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="mobile" class="form-label">Mobile:</label>
                                <input type="text" id="mobile" name="mobile" value="${currentUser.mobile}" class="form-control" required>
                            </div>

                            <button type="submit" class="btn btn-red">Update</button>
                        </form>

                        <h3 class="mt-4">
                            <input type="checkbox" id="changePasswordCheck" onclick="toggleChangePassword()"> Change Password
                        </h3>
                        <form id="changePasswordForm" action="/computerParts/ChangePasswordServlet" method="post">
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current Password:</label>
                                <input type="password" id="currentPassword" name="currentPassword" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password:</label>
                                <input type="password" id="newPassword" name="newPassword" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm New Password:</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                            </div>

                            <button type="submit" class="btn btn-red">Change Password</button>
                        </form>
                    </c:if>

                    <c:if test="${empty currentUser}">
                        <p class="mt-4">No user is currently logged in.</p>
                    </c:if>

                    <div class="mt-4">
                        <form action="/computerParts/DeleteUserServlet" method="post" style="display:inline;">
                            <input type="hidden" name="userId" value="${currentUser.userId}">
                            <button type="submit" class="btn btn-warning">Delete Account</button> <!-- Delete account button -->
                        </form>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
