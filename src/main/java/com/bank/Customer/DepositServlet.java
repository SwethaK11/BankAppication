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
import com.bank.Customer.Database;

@WebServlet("/DepositServlet")
public class DepositServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Database.getConnection();
            conn.setAutoCommit(false);

            // Update the account balance
            String updateBalanceSQL = "UPDATE customers SET balance = balance + ? WHERE accountNumber = ?";
            pstmt = conn.prepareStatement(updateBalanceSQL);
            pstmt.setDouble(1, amount);
            pstmt.setString(2, accountNumber);
            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated == 1) {
                // Record the transaction
                String transactionSQL = "INSERT INTO transactions (accountNumber, transactionType, amount, balance, date) VALUES (?, ?, ?, (SELECT balance FROM customers WHERE accountNumber = ?), ?)";
                pstmt = conn.prepareStatement(transactionSQL);
                pstmt.setString(1, accountNumber);
                pstmt.setString(2, "Deposit");
                pstmt.setDouble(3, amount);
                pstmt.setString(4, accountNumber);
                pstmt.setString(5, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                pstmt.executeUpdate();

                conn.commit();
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\": \"Deposit successful!\"}");
            } else {
                conn.rollback();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"message\": \"Deposit failed!\"}");
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
