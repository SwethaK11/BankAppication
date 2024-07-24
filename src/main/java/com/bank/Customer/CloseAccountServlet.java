package com.bank.Customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.bank.Customer.Database;

@WebServlet("/CloseAccountServlet")
public class CloseAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");

        try (Connection connection = Database.getConnection()) {
            // Check account balance
            String balanceQuery = "SELECT balance FROM customers WHERE accountNumber = ?";
            PreparedStatement balanceStmt = connection.prepareStatement(balanceQuery);
            balanceStmt.setString(1, accountNumber);
            ResultSet balanceRs = balanceStmt.executeQuery();
            
            if (balanceRs.next()) {
                double balance = balanceRs.getDouble("balance");
                
                if (balance > 0) {
                    // Balance is not zero
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"Please withdraw all the amount before closing the account.\"}");
                    return;
                }
            }

            // Proceed to delete account
            String deleteQuery = "DELETE FROM customers WHERE accountNumber = ?";
            PreparedStatement deleteStmt = connection.prepareStatement(deleteQuery);
            deleteStmt.setString(1, accountNumber);
            int rowsAffected = deleteStmt.executeUpdate();

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            if (rowsAffected > 0) {
                response.getWriter().write("{\"success\": true}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Account closure failed. Please try again.\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"An error occurred. Please try again.\"}");
        }
    }
}
