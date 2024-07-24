<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bank.Customer.Transaction" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mini Statement</title>
    <style>
         body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image:url('images/bgpic.jpg');
            background-size: cover;
            background-position: center;
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
        }
        .container {
            width: 100%;
            max-width: 600px;
            margin-top: 80px; /* Adjust based on navbar height */
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            box-sizing: border-box;
        }
        .header {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 36px;
            font-weight: bold;
        }
        .transactions {
            background-color: white;
            padding: 20px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            transition: 0.3s;
            border-radius: 5px;
        }
        .transactions h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        .transactions ul {
            list-style-type: none;
            padding: 0;
            text-align: center;
        }
        .transactions li {
            margin-bottom: 10px;
        }
        .footer {
            background-color: #333;
            color: #f2f2f2;
            text-align: center;
            padding: 10px;
            width: 100%;
        }
        dialog-button {
    padding: 10px 20px;
    background-color: MediumSlateBlue;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    text-transform: uppercase;
    transition: background-color 0.3s, transform 0.3s ease-out;
    margin-top: 10px;
    display: inline-block;
    text-decoration: none; /* Remove underline */
    text-align: center; /* Center text */
}

dialog-button:hover {
    background-color: #7b68ee;
    transform: translateY(-3px);
}

dialog-button:focus {
    background-color: #7b68ee;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
    </style>
</head>
<body>

<div class="navbar">
    <a href="UserDashboardServlet">Home</a>
    <a href="userprofile.jsp">Profile</a>
    <a href="ministatement.jsp">Mini Statement</a> <!-- Added link to mini statement page -->
    <a href="userLogin.jsp">Logout</a> <!-- Logout link -->
</div>

<div class="container">
    <div class="header">
        <h1>Mini Statement</h1>
    </div>
    <div class="transactions">
        <h3>Last 10 Transactions</h3>
        <ul>
            <!-- Use JSTL to iterate over transactions -->
            <c:forEach items="${transactions}" var="transaction">
                <li>${transaction.date} - ${transaction.type} - Amount: $${transaction.amount} - Balance: $${transaction.balance}</li>
            </c:forEach>
            <!-- Show message if no transactions -->
            <c:if test="${empty transactions}">
                <li>Print Your MiniStatement</li>
            </c:if>
        </ul>
        <!-- Form to generate PDF -->
        <form action="GeneratePDFServlet" method="post">
            <input type="hidden" name="data" value="transactions">
            <button type="submit" class="dialog-button">Print as PDF</button>
        </form>
    </div>
</div>

</body>
</html>
