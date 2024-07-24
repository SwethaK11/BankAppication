<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deposit Amount</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: lightblue;
            margin: 0;
            padding: 0;
        }
        .container {
            padding: 20px;
        }
        .header {
            text-align: center;
            padding: 20px;
        }
        .card {
            background-color: white;
            padding: 20px;
            margin: 20px auto;
            width: 50%;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            transition: 0.3s;
            border-radius: 5px;
        }
        .card h3 {
            text-align: center;
        }
        .card p {
            text-align: center;
        }
        .card form {
            text-align: center;
        }
        .card input[type="number"] {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .card input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .card input[type="submit"]:hover {
            background-color: #45a049;
        }
        .message {
            text-align: center;
            padding: 20px;
        }
        .message.success {
            color: green;
        }
        .message.error {
            color: red;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Deposit Amount</h1>
    </div>
    <div class="card">
        <h3>Enter the amount to deposit</h3>
        <form method="post" action="DepositServlet">
            <input type="number" name="amount" placeholder="Enter amount" required>
            <input type="submit" value="Submit">
        </form>
    </div>

    <div class="message" id="responseMessage">
        <% 
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null && messageType != null) {
        %>
            <p class="<%= messageType %>"><%= message %></p>
        <% } %>
    </div>
</div>

</body>
</html>
