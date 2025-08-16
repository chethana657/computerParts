package com.servelet;

import com.DAO.OrderDao;
import com.model.OrderModel;
import com.connection.DBConnect;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/ChangeOrderStatusServlet")
public class ChangeOrderStatusServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));

        try {
            Connection conn = DBConnect.getConnection();
            OrderDao orderDao = new OrderDao(conn);
            OrderModel order = orderDao.getOrderById(orderId); // Retrieve the order by ID

            if (order != null) { // Ensure the order exists
                // Toggle status
                int newStatus = (order.getStatus() == 2) ? 1 : 2; // Toggle between 1 and 0
                orderDao.updateOrderStatus(orderId, newStatus); // Update the order status

                response.sendRedirect("admin_allOrders.jsp"); // Redirect back to orders page
            } else {
                response.sendRedirect("error.jsp"); // Redirect to error page if order not found
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page
        }
    }
}
