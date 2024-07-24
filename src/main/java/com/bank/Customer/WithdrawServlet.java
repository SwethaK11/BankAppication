package com.bank.Customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/WithdrawServlet")
public class WithdrawServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Database.getConnection(); // Use Database class for connection
            conn.setAutoCommit(false);

            // Check if sufficient balance is available
            String checkBalanceSQL = "SELECT balance FROM customers WHERE accountNumber = ?";
            pstmt = conn.prepareStatement(checkBalanceSQL);
            pstmt.setString(1, accountNumber);
            double currentBalance = 0.0;
            var resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                currentBalance = resultSet.getDouble("balance");
            }

            if (currentBalance >= amount) {
                // Update the account balance
                String updateBalanceSQL = "UPDATE customers SET balance = balance - ? WHERE accountNumber = ?";
                pstmt = conn.prepareStatement(updateBalanceSQL);
                pstmt.setDouble(1, amount);
                pstmt.setString(2, accountNumber);
                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated == 1) {
                    // Record the transaction
                    String transactionSQL = "INSERT INTO transactions (accountNumber, transactionType, amount, balance, date) VALUES (?, ?, ?, (SELECT balance FROM customers WHERE accountNumber = ?), ?)";
                    pstmt = conn.prepareStatement(transactionSQL);
                    pstmt.setString(1, accountNumber);
                    pstmt.setString(2, "Withdrawal");
                    pstmt.setDouble(3, amount);
                    pstmt.setString(4, accountNumber);
                    pstmt.setString(5, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                    pstmt.executeUpdate();

                    conn.commit();
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("{\"message\": \"Withdrawal successful!\"}");
                } else {
                    conn.rollback();
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"message\": \"Withdrawal failed!\"}");
                }
            } else {
                // Insufficient balance
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\": \"Insufficient balance!\"}");
            }
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"message\": \"Database error!\"}");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
