package com.servelet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.ItemDao;
import com.connection.DBConnect;

/**
 * Servlet implementation class ChangeStatusServlet
 */
@WebServlet("/ChangeStatusServlet")
public class ChangeStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeStatusServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int newStatus = Integer.parseInt(request.getParameter("status")); // Get new status directly

        // Connect to the database and update the status
        Connection conn = null;
        try {
            conn = DBConnect.getConnection();
            ItemDao itemDao = new ItemDao(conn);
            itemDao.updateItemStatus(id, newStatus); // Assume this method exists in your ItemDao

            // Redirect back to inventory page with a success message
            response.sendRedirect("inventory.jsp?successMessage=Item status updated successfully");
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            response.sendRedirect("inventory.jsp?errorMessage=Error updating item status");
        } finally {
            if (conn != null) {
                try {
                    conn.close(); // Ensure the connection is closed
                } catch (Exception e) {
                    e.printStackTrace(); // Log the exception
                }
            }
        }
    }
}
