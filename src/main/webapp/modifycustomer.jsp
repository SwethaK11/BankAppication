<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.bank.Customer.customer" %> 
<%@ page import="com.bank.Customer.CustomerDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modify Customer Details</title>
    <style>
       body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            margin:0;
            display: flex;
            justify-content: center;
            background-image:url('images/bgpic.jpg');
            background-size: cover;
            background-size: center;
            background-position: center;
            /* Fixes the background image */
        }
        .navbar {
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            padding: 10px 0;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-around;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .navbar a {
            color: MediumSlateBlue;
            text-decoration: none;
            font-weight: bold;
            padding: 10px 20px;
            transition: color 0.3s, background-color 0.3s;
        }
        .navbar a:hover {
            color: white;
            background-color: #CCCCFF;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            padding: 30px;
            width: 70%;
            max-width: 600px;
            text-align: center;
            box-sizing: border-box;
            position: relative;
            margin-top: 80px; /* Adjusted margin-top to account for navbar */
        }
        h1 {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-group button {
            padding: 10px 15px;
            background-color: MediumSlateBlue;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-transform: uppercase;
            transition: background-color 0.3s, transform 0.3s ease-out;
            outline: none;
        }
        .form-group button:hover {
            background-color: #7b68ee;
            transform: translateY(-3px);
        }
        .form-group button:focus {
            background-color: #7b68ee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="admindashboard.jsp">Home</a>
        <a href="adminprofile.jsp">Profile</a>
        <a href="adminsettings.jsp">Password Change</a>
		<a href="AdminLogoutServlet">Logout</a>    </div>
    
    <div class="container">
        <h1>Modify Customer Details</h1>
        <!-- Search form -->
        <form method="get" action="modifycustomer.jsp">
            <div class="form-group">
                <label for="accountNumber">Enter Account Number:</label>
                <input type="text" id="accountNumber" name="accountNumber" required>
            </div>
            <div class="form-group">
                <button type="submit">Search</button>
            </div>
        </form>

        <!-- Display error message if any -->
        <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
        %>
        <p style="color: red;"><%= errorMessage %></p>
        <% } %>

        <%
        String accountNumber = request.getParameter("accountNumber");
        String driver = "com.mysql.cj.jdbc.Driver"; // Updated driver class name
        String connectionUrl = "jdbc:mysql://localhost:3306/";
        String database = "bank";
        String userid = "root";
        String password = "root";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        if (accountNumber != null && !accountNumber.isEmpty()) {
            try {
                Class.forName(driver);
                connection = DriverManager.getConnection(connectionUrl + database, userid, password);
                String sql = "SELECT * FROM customers WHERE accountNumber = ?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, accountNumber);
                resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    customer customer = new customer();
                    customer.setId(resultSet.getInt("id"));
                    customer.setFullName(resultSet.getString("fullName"));
                    customer.setAddress(resultSet.getString("address"));
                    customer.setMobileNo(resultSet.getString("mobileNo"));
                    customer.setEmail(resultSet.getString("email"));
                    customer.setAccountType(resultSet.getString("accountType"));
                    customer.setDob(resultSet.getDate("dob"));

                    request.setAttribute("customer", customer);
                } else {
                    request.setAttribute("errorMessage", "Customer not found.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
                if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            }
        }

        customer customer = (customer) request.getAttribute("customer");
        if (customer != null) {
        %>
        <form method="post" action="UpdateCustomerServlet">
            <input type="hidden" name="id" value="<%= customer.getId() %>">
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" value="<%= customer.getFullName() %>" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <textarea id="address" name="address" rows="4" required><%= customer.getAddress() %></textarea>
            </div>
            <div class="form-group">
                <label for="mobileNo">Mobile No:</label>
                <input type="text" id="mobileNo" name="mobileNo" pattern="[0-9]{10}" value="<%= customer.getMobileNo() %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email ID:</label>
                <input type="email" id="email" name="email" value="<%= customer.getEmail() %>" required>
            </div>
            <div class="form-group">
                <label for="accountType">Type of Account:</label>
                <select id="accountType" name="accountType" required>
                    <option value="Saving" <%= customer.getAccountType().equals("Saving") ? "selected" : "" %>>Saving Account</option>
                    <option value="Current" <%= customer.getAccountType().equals("Current") ? "selected" : "" %>>Current Account</option>
                </select>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" value="<%= customer.getDob() %>" required>
            </div>
            <!-- Add other fields as needed -->

            <div class="form-group">
                <button type="submit">Update Customer</button>
            </div>
        </form>
        <% } else if (accountNumber != null && !accountNumber.isEmpty()) { %>
        <!-- If customer not found -->
        <p>Customer not found.</p>
        <% } %>
    </div>
</body>
</html>
