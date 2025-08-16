package com.servelet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.UserDao;
import com.connection.DBConnect;
import com.model.UserModel;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateProfileServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Initialize variables
        int userId = 0;
        boolean isUpdated = false;

        try {
            // Retrieve parameters from the form
            userId = Integer.parseInt(request.getParameter("userId"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");

            // Create a UserModel object to hold the data
            UserModel user = new UserModel();
            user.setUserId(userId);
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setMobile(mobile);

            // Database connection
            Connection connection = DBConnect.getConnection();
            try {
                // Instantiate UserDao with the connection
                UserDao userDao = new UserDao(connection);

                // Call updateUser method to update the user details
                isUpdated = userDao.updateUser(user);
            } finally {
                // Close the connection if applicable
                if (connection != null) {
                    connection.close();
                }
            }

            // Check the result of the update operation
            if (isUpdated) {
                // Update the session with the new user information
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);
                request.setAttribute("successMessage", "Profile updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid user ID format.");
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            e.printStackTrace(); // Log the error for debugging
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            e.printStackTrace(); // Log the error for debugging
        }

        // Redirect back to profile page
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
