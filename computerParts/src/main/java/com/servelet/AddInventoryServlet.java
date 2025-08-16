package com.servelet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.DAO.ItemDao;
import com.connection.DBConnect;
import com.model.ItemModel;

@WebServlet("/AddInventoryServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB threshold
                 maxFileSize = 1024 * 1024 * 10,      // 10MB max file size
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB max request size
public class AddInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR = "./upload"; // Folder to store images

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemName = request.getParameter("itemName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Handle file upload
        Part filePart = request.getPart("imgFile");
        String fileName = getFileName(filePart);

        // Get the path to store the uploaded image
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);

        // Log the upload path for debugging
        System.out.println("Upload Path: " + uploadPath);

        // Check if directory exists and create if not
        if (!uploadDir.exists()) {
            boolean dirCreated = uploadDir.mkdirs(); // Creates the directory structure
            System.out.println("Upload directory created: " + dirCreated);
        }

        // Save the file to the specified directory
        String filePath = uploadPath + File.separator + fileName;
        System.out.println("File Path: " + filePath); // Log file path for debugging

        try {
            filePart.write(filePath); // Write the uploaded file to disk
            System.out.println("File uploaded successfully to: " + filePath);
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("File upload failed: " + e.getMessage());
        }

        // Save the image URL relative to the application context
        String imgURL = UPLOAD_DIR + File.separator + fileName;

        // Set status to 1 (active)
        int status = 1;

        // Create a new ItemModel object with the item details
        ItemModel newItem = new ItemModel();
        newItem.setItemName(itemName);
        newItem.setDescription(description);
        newItem.setPrice(price);
        newItem.setQuantity(quantity);
        newItem.setStatus(status);
        newItem.setImgURL(imgURL);

        // Save item details to the database
        Connection conn = DBConnect.getConnection();
        ItemDao itemDao = new ItemDao(conn);
        boolean isAdded = itemDao.addItem(newItem);

        if (isAdded) {
            // Redirect to inventory page after adding the item
            request.setAttribute("successMessage", "Item added successfully.");
            request.getRequestDispatcher("inventory.jsp").forward(request, response);
        } else {
            // Redirect to error page if item not added
            request.setAttribute("errorMessage", "Failed to add item.");
            request.getRequestDispatcher("addInventory.jsp").forward(request, response);
        }
    }

    // Extract the filename from the file part
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 2, content.length() - 1).replace("\"", ""); // Remove quotes
            }
        }
        return "default.jpg"; // Default filename if not provided
    }
}
