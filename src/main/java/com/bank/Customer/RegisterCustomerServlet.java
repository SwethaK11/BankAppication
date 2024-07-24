package com.bank.Customer;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.bank.Customer.Database;

@WebServlet("/RegisterCustomerServlet")
@MultipartConfig(maxFileSize = 16177215)
public class RegisterCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String mobileNo = request.getParameter("mobileNo");
        String email = request.getParameter("email");
        String accountType = request.getParameter("accountType");
        String initialBalanceStr = request.getParameter("balance");
        int initialBalance = (initialBalanceStr != null && !initialBalanceStr.isEmpty()) ? Integer.parseInt(initialBalanceStr) : 1000;
        String dob = request.getParameter("dob");
        String idProofType = request.getParameter("idProofType");
        Part idProof = request.getPart("idProof");

        String accountNumber = generateAccountNumber();
        String temporaryPassword = generateTemporaryPassword();

        try (Connection connection = Database.getConnection()) {
            String sql = "INSERT INTO customers (fullName, address, mobileNo, email, accountType, balance, dob, idProofType, idProof, accountNumber, temporaryPassword) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, fullName);
            statement.setString(2, address);
            statement.setString(3, mobileNo);
            statement.setString(4, email);
            statement.setString(5, accountType);
            statement.setInt(6, initialBalance);
            statement.setString(7, dob);
            statement.setString(8, idProofType);
            statement.setBlob(9, idProof.getInputStream());
            statement.setString(10, accountNumber);
            statement.setString(11, temporaryPassword);

            int row = statement.executeUpdate();
            if (row > 0) {
                // Forward to registration-success.jsp with account number and temporary password
                request.setAttribute("accountNumber", accountNumber);
                request.setAttribute("temporaryPassword", temporaryPassword);
                request.getRequestDispatcher("registration-success.jsp").forward(request, response);
            } else {
                response.getWriter().println("Customer registration failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Customer registration failed: " + e.getMessage());
        }
    }

    private String generateAccountNumber() {
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 10; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }

    private String generateTemporaryPassword() {
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        for (int i = 0; i < 8; i++) {
            sb.append(characters.charAt(random.nextInt(characters.length())));
        }
        return sb.toString();
    }
}
