package com.bank.Customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserChangePasswordServlet")
public class UserChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword.equals(confirmPassword)) {
            try (Connection connection = Database.getConnection()) {
                String sql = "UPDATE customers SET password = ? WHERE accountNumber = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, newPassword);
                preparedStatement.setString(2, accountNumber);

                int rowsUpdated = preparedStatement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("userPasswordChangeSuccess.jsp");
                } else {
                    response.sendRedirect("userPasswordChangeFailed.jsp");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("userPasswordChangeFailed.jsp");
            }
        } else {
            response.sendRedirect("userPasswordChangeFailed.jsp");
        }
    }
}
