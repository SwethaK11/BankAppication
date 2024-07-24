<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.bank.Customer.customer" %> 
<%@ page import="com.bank.Customer.CustomerDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('images/bgpic.jpg');
            background-size: cover;
            background-position: center;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            padding: 20px;
            width: 70%;
            max-width: 600px;
            text-align: center;
            box-sizing: border-box;
        }
        h1 {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 20px;
            border: 2px solid MediumSlateBlue;
        }
        .profile-details {
            text-align: left;
            margin-top: 20px;
        }
        .profile-details div {
            margin-bottom: 10px;
            font-size: 18px;
            color: #333;
        }
        .profile-details label {
            font-weight: bold;
            margin-right: 10px;
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
            transition: color 0.3s background-color 0.3s;
        }
        .navbar a:hover {
            color: white;
            background-color: #CCCCFF;
        }}
    </style>
</head>
<body>
<div class="navbar">
    <a href="UserDashboardServlet">Home</a>
    <a href="userprofile.jsp">Profile</a>
    <a href="ministatement.jsp">Mini Statement</a>
    <a href="LogoutServlet">Logout</a>
</div>

    <div class="container">
        <h1>User Profile</h1>
        <img src="images/profilepic.png" alt="Profile Image" class="profile-img">
        <%
            String accountNumber = (String) session.getAttribute("accountNumber");
	            if (accountNumber != null && !accountNumber.isEmpty()) {
                customer customer = CustomerDAO.getCustomerByAccountNumber(accountNumber);
                if (customer != null) {
        %>
        <div class="profile-details">
            <div><label>Full Name:</label> <%= customer.getFullName() %></div>
            <div><label>Address:</label> <%= customer.getAddress() %></div>
            <div><label>Mobile No:</label> <%= customer.getMobileNo() %></div>
            <div><label>Email:</label> <%= customer.getEmail() %></div>
            <div><label>Account Type:</label> <%= customer.getAccountType() %></div>
            <div><label>Date of Birth:</label> <%= customer.getDob() %></div>
            <div><label>Account Number:</label> <%= customer.getAccountNumber() %></div>
        </div>
        <%
                } else {
                    out.println("<p>Customer details not found.</p>");
                }
            } else {
                out.println("<p>Account number not found in session.</p>");
            }
        %>
    </div>
</body>
</html>
