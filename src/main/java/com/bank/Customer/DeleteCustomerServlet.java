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
import com.bank.Customer.Database;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = Database.getConnection();
            String sql = "DELETE FROM customers WHERE accountNumber = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, accountNumber);
            
            int rowsDeleted = preparedStatement.executeUpdate();
            if (rowsDeleted > 0) {
                // Delete successful
                response.sendRedirect("deletesuccess.jsp"); // Redirect to admin dashboard or success page
            } else {
                // Customer not found or deletion failed
                response.sendRedirect("deleteerror.jsp"); // Redirect to error page
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to error page on exception
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
