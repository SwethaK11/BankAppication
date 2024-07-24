package com.bank.Customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
  
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");

        if (accountNumber != null) {
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        } else {
            response.sendRedirect("userLogin.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");
        String newPassword = request.getParameter("newPassword");

        if (changePassword(accountNumber, newPassword)) {
            session.setAttribute("passwordChanged", true);
            response.sendRedirect("UserDashboardServlet");
        } else {
            response.sendRedirect("changePasswordFailed.jsp");
        }
    }

    private boolean changePassword(String accountNumber, String newPassword) {
        boolean passwordChanged = false;
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = Database.getConnection();
            String sql = "UPDATE customers SET temporaryPassword = '', password = ? WHERE accountNumber = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, newPassword); // Store hashed password in production
            statement.setString(2, accountNumber);

            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                passwordChanged = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return passwordChanged;
    }
}
