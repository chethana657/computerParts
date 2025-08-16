package com.servelet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.UserDao;
import com.connection.DBConnect;
import com.model.UserModel;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Retrieve registration form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        int status = 1; // Automatically set status to 1

        // Create a new UserModel object
        UserModel user = new UserModel();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setMobile(mobile);
        user.setPassword(password);
        user.setStatus(status);

        // Database connection
        Connection connection = DBConnect.getConnection();

        // Instantiate UserDao with the connection
        UserDao userDao = new UserDao(connection);

        // Call registerUser method to save the user
        boolean isRegistered = userDao.registerUser(user);

        if (isRegistered) {
            // If registration is successful, redirect to a success page
            request.setAttribute("successMessage", "Registration successful! You can now log in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // If registration fails, redirect back to the registration page with an error message
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
	}

}
