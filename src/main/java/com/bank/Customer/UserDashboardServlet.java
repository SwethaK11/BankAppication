package com.bank.Customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

@WebServlet("/UserDashboardServlet")
public class UserDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");

        if (accountNumber != null) {
            try {
                // Fetch customer details and set session attributes
                fetchCustomerDetails(accountNumber, request);

                // Fetch last 10 transactions and set as request attribute
                List<Transaction> transactions = fetchTransactions(accountNumber);
                request.setAttribute("transactions", transactions);

                // Forward to userdashboard.jsp
                request.getRequestDispatcher("userdashboard.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("userLogin.jsp?error=Database error. Please try again later.");
            }
        } else {
            response.sendRedirect("userLogin.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        String password = request.getParameter("password");

        try (Connection conn = Database.getConnection()) {
            // Prepare SQL statement to fetch customer details based on accountNumber and password
            String sql = "SELECT * FROM customers WHERE accountNumber=? AND temporaryPassword=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, accountNumber);
            statement.setString(2, password);

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                // Authentication successful, set user session attributes
                HttpSession session = request.getSession();
                session.setAttribute("accountNumber", accountNumber);
                session.setAttribute("fullName", result.getString("fullName"));
                session.setAttribute("balance", result.getDouble("balance")); // Adjust as per your schema
                session.setAttribute("lastLogin", result.getString("lastLogin")); // Adjust as per your schema

                // Debug logging
                System.out.println("Balance: " + result.getDouble("balance"));
                System.out.println("Last Login: " + result.getString("lastLogin"));
                String lastLogin = result.getString("lastLogin");
                System.out.println("Raw last login from database: " + lastLogin);

                // Update lastLogin timestamp in the database
                String sqlUpdate = "UPDATE customers SET lastLogin = CURRENT_TIMESTAMP WHERE accountNumber=?";
                PreparedStatement updateStatement = conn.prepareStatement(sqlUpdate);
                updateStatement.setString(1, accountNumber);
                int rowsUpdated = updateStatement.executeUpdate();
                if (rowsUpdated > 0) {
                    System.out.println("lastLogin updated successfully for accountNumber: " + accountNumber);
                } else {
                    System.out.println("lastLogin update failed for accountNumber: " + accountNumber);
                }

                // Redirect to doGet to fetch and display user details
                response.sendRedirect("UserDashboardServlet");
            } else {
                // Authentication failed, redirect back to login page with error message
                response.sendRedirect("userLogin.jsp?error=Invalid credentials");
            }

            // Close connections
            statement.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database connection and query errors
            response.sendRedirect("userLogin.jsp?error=Database error. Please try again later.");
        }
    }

    private void fetchCustomerDetails(String accountNumber, HttpServletRequest request) throws SQLException {
        try (Connection conn = Database.getConnection()) {
            // Prepare SQL statement to fetch customer details
            String sql = "SELECT fullName, balance, DATE_FORMAT(lastLogin, '%Y-%m-%d %H:%i:%s') AS lastLogin FROM customers WHERE accountNumber=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, accountNumber);

            ResultSet result = statement.executeQuery();
            if (result.next()) {
                // Set customer details as request attributes
                request.setAttribute("fullName", result.getString("fullName"));
                request.setAttribute("balance", result.getDouble("balance"));
                request.setAttribute("lastLogin", result.getString("lastLogin"));
            }
        }
    }

    private List<Transaction> fetchTransactions(String accountNumber) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        try (Connection conn = Database.getConnection()) {
            // Prepare SQL statement to fetch transactions
            String sql = "SELECT * FROM transactions WHERE accountNumber=? ORDER BY date DESC LIMIT 10";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, accountNumber);

            ResultSet result = statement.executeQuery();
            while (result.next()) {
                Transaction transaction = new Transaction();
                transaction.setDate(result.getString("date"));
                transaction.setType(result.getString("transactionType"));
                transaction.setAmount(result.getDouble("amount"));
                transaction.setBalance(result.getDouble("balance"));
                transactions.add(transaction);
            }
        }
        return transactions;
    }
}
