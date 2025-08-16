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

@WebServlet("/DeleteOrderServlet")
public class DeleteOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the order ID from the request
        String orderId = request.getParameter("id");

        // Create a database connection
        Connection conn = DBConnect.getConnection();

        // Create an instance of OrderDao
        OrderDao orderDao = new OrderDao(conn);

        // Delete the order using the DAO method
        boolean isDeleted = orderDao.deleteOrder(orderId);

        // Redirect to the orders page with a success or error message
        if (isDeleted) {
            response.sendRedirect("admin_allOrders.jsp");
        } else {
            response.sendRedirect("admin_allOrders.jsp");
        }
    }
}
