package com.bank.Customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Import the Database class
import com.bank.Customer.Database;

@WebServlet("/MiniStatementServlet")
public class MiniStatementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");

        if (accountNumber == null || accountNumber.isEmpty()) {
            response.getWriter().println("Account number not found in session.");
            return;
        }

        List<Transaction> transactions = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = Database.getConnection(); // Use Database class to get connection
            pstmt = conn.prepareStatement(
                    "SELECT date, transactionType, amount, balance FROM transactions WHERE accountNumber = ? ORDER BY date DESC LIMIT 10");
            pstmt.setString(1, accountNumber);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setDate(rs.getString("date"));
                transaction.setType(rs.getString("transactionType"));
                transaction.setAmount(rs.getDouble("amount"));
                transaction.setBalance(rs.getDouble("balance"));
                transactions.add(transaction);
            }

            // Set transactions attribute for JSP rendering
            request.setAttribute("transactions", transactions);

            // Forward to JSP for displaying transactions
            request.getRequestDispatcher("miniStatement.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error fetching transactions: " + e.getMessage());
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
