package com.servelet;

import com.DAO.OrderDao;
import com.connection.DBConnect;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/UpdateOrderServlet")
public class UpdateOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String orderId = request.getParameter("orderId");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");

        // Connect to the database
        Connection con = DBConnect.getConnection();
        OrderDao orderDao = new OrderDao(con);

        // Update the order in the database
        boolean success = orderDao.updateOrder(orderId, email, mobile, address);

        if (success) {
            // Redirect back to the My Orders page with a success message
            request.getSession().setAttribute("message", "Order updated successfully!");
            response.sendRedirect("myOrders.jsp");
        } else {
            // Handle failure case
            request.setAttribute("errorMessage", "Update failed. Please try again.");
            request.getRequestDispatcher("myOrders.jsp").forward(request, response);
        }
    }
}
