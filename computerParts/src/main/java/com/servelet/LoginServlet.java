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
import com.model.UserModel;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Retrieve login form parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Database connection
        Connection connection = DBConnect.getConnection();

        // Instantiate UserDao with the connection
        UserDao userDao = new UserDao(connection);

        // Call loginUser method to check if user exists with email and password
        UserModel user = userDao.loginUser(email, password); // Passing null for mobile

        if (user != null) {
            // If user exists, create a session and store the user object
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            // Redirect to user dashboard or homepage
            response.sendRedirect("home.jsp");
        } else {
            // If user doesn't exist, redirect back to the login page with an error
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
	}

}
