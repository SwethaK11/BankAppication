package com.bank.Customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.bank.Customer.Database;
@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        String password = request.getParameter("password");

        if (authenticateUser(request, accountNumber, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("accountNumber", accountNumber);

            // Redirect to change password if temporary password, else redirect to dashboard
            if (isTemporaryPassword(accountNumber, password)) {
                response.sendRedirect("changePassword.jsp");
            } else {
                response.sendRedirect("UserDashboardServlet");
            }
        } else {
            response.sendRedirect("userLogin.jsp?error=Authentication+failed");
        }
    }

    private boolean authenticateUser(HttpServletRequest request, String accountNumber, String password) {
        boolean isAuthenticated = false;
        String sql = "SELECT * FROM customers WHERE accountNumber = ? AND (temporaryPassword = ? OR password = ?)";

        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, accountNumber);
            statement.setString(2, password); // Check against temporary password
            statement.setString(3, password); // Check against new password

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    isAuthenticated = true;
                    // Set session attributes for user details
                    HttpSession session = request.getSession();
                    session.setAttribute("accountNumber", accountNumber);
                    session.setAttribute("fullName", resultSet.getString("fullName"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isAuthenticated;
    }

    private boolean isTemporaryPassword(String accountNumber, String password) {
        boolean isTemporary = false;
        String sql = "SELECT * FROM customers WHERE accountNumber = ? AND temporaryPassword = ?";

        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, accountNumber);
            statement.setString(2, password);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    isTemporary = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isTemporary;
    }
}
