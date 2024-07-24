package com.bank.Customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class CustomerDAO {

    // Method to get customer by account number
    public static customer getCustomerByAccountNumber(String accountNumber) {
        customer customer = null;
        String sql = "SELECT * FROM customers WHERE accountNumber = ?";
        
        try (Connection connection = Database.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            
            preparedStatement.setString(1, accountNumber);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    customer = new customer();
                    customer.setId(resultSet.getInt("id"));
                    customer.setFullName(resultSet.getString("fullName"));
                    customer.setAddress(resultSet.getString("address"));
                    customer.setMobileNo(resultSet.getString("mobileNo"));
                    customer.setEmail(resultSet.getString("email"));				
                    customer.setAccountType(resultSet.getString("accountType"));
                    customer.setDob(resultSet.getDate("dob"));
                    customer.setAccountNumber(resultSet.getString("accountNumber")); // Ensure account number is set
                    // Set other attributes as needed
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    // Method to update customer details
    public boolean updateCustomer(customer customer) {
        boolean isSuccess = false;
        StringBuilder queryBuilder = new StringBuilder("UPDATE customers SET ");

        // Track if any fields are being updated
        boolean isFirst = true;

        // Check each field and append to query if not null
        if (customer.getFullName() != null) {
            queryBuilder.append(isFirst ? "" : ", ").append("fullName = ?");
            isFirst = false;
        }
        if (customer.getAddress() != null) {
            queryBuilder.append(isFirst ? "" : ", ").append("address = ?");
            isFirst = false;
        }
        if (customer.getMobileNo() != null) {
            queryBuilder.append(isFirst ? "" : ", ").append("mobileNo = ?");
            isFirst = false;
        }
        if (customer.getEmail() != null) {
            queryBuilder.append(isFirst ? "" : ", ").append("email = ?");
            isFirst = false;
        }
        if (customer.getAccountType() != null) {
            queryBuilder.append(isFirst ? "" : ", ").append("accountType = ?");
            isFirst = false;
        }
        if (customer.getDob() != null) {
            queryBuilder.append(isFirst ? "" : ", ").append("dob = ?");
            isFirst = false;
        }

        // Add WHERE clause
        queryBuilder.append(" WHERE id = ?");

        String query = queryBuilder.toString();

        try (Connection connection = Database.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            int parameterIndex = 1;

            // Set parameters for fields that are being updated
            if (customer.getFullName() != null) {
                preparedStatement.setString(parameterIndex++, customer.getFullName());
            }
            if (customer.getAddress() != null) {
                preparedStatement.setString(parameterIndex++, customer.getAddress());
            }
            if (customer.getMobileNo() != null) {
                preparedStatement.setString(parameterIndex++, customer.getMobileNo());
            }
            if (customer.getEmail() != null) {
                preparedStatement.setString(parameterIndex++, customer.getEmail());
            }
            if (customer.getAccountType() != null) {
                preparedStatement.setString(parameterIndex++, customer.getAccountType());
            }
            if (customer.getDob() != null) {
                preparedStatement.setDate(parameterIndex++, customer.getDob());
            }

            // Set ID parameter
            preparedStatement.setInt(parameterIndex, customer.getId());

            // Execute update
            isSuccess = preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    public void updateLastLogin(String accountNumber, Timestamp timestamp) throws SQLException {
        String sql = "UPDATE customers SET lastLogin = ? WHERE accountNumber = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setTimestamp(1, timestamp);
            statement.setString(2, accountNumber);
            statement.executeUpdate();
        }
    }
}
