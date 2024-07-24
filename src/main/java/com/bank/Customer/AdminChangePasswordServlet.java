package com.bank.Customer;
import com.bank.Customer.Database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminChangePasswordServlet")
public class AdminChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword.equals(confirmPassword)) {
            if (changePassword(username, newPassword)) {
                response.sendRedirect("adminchangepasswordsuccess.jsp");
            } else {
                request.setAttribute("error", "Failed to change password. Please try again.");
                request.getRequestDispatcher("adminchangepassword.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("adminchangepassword.jsp").forward(request, response);
        }
    }

    private boolean changePassword(String username, String newPassword) {
        try (Connection connection = Database.getConnection()) {
            String sql = "UPDATE admin SET password = ? WHERE username = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, newPassword);
            statement.setString(2, username);
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

   
}
