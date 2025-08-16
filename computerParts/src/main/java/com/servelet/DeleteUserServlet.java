package com.servelet;

import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.UserDao;
import com.connection.DBConnect;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the user ID from the request
        String userIdStr = request.getParameter("userId");
        
        // Convert the user ID to an integer
        int userId = Integer.parseInt(userIdStr);

        // Database connection
        Connection connection = DBConnect.getConnection();
        UserDao userDao = new UserDao(connection);

        // Delete the user from the database
        boolean isDeleted = userDao.deleteUser(userId);

        // Set a message in the session based on the deletion outcome
        HttpSession session = request.getSession();
        if (isDeleted) {
            session.setAttribute("message", "User deleted successfully!");
        } else {
            session.setAttribute("errorMessage", "Failed to delete the user. Please try again.");
        }
        
        // Redirect back to the admin dashboard
        response.sendRedirect(request.getContextPath() + "/admin_dashboard.jsp");
    }
}
