<%@ page import="java.io.*, java.sql.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*, javax.servlet.jsp.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Settings</title>
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
            padding: 30px;
            width: 90%;
            max-width: 500px;
            text-align: center;
            box-sizing: border-box;
        }

        h1 {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 36px;
            font-weight: bold;
        }

        label {
            display: block;
            margin: 10px 0 5px;
        }

        input[type=password] {
            padding: 10px;
            margin: 10px 0;
            width: 100%;
            box-sizing: border-box;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button {
            padding: 10px;
            margin: 10px 0;
            width: 100%;
            box-sizing: border-box;
            border-radius: 5px;
            border: none;
            background-color: MediumSlateBlue;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .message {
            margin-top: 20px;
            text-align: center;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }

        .back-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            margin-bottom: 20px;
            text-decoration: none;
        }

        .back-button:hover {
            background-color: #e53935;
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
    </style>
</head>
<body>
    <div class="navbar">
        <a href="admindashboard.jsp">Home</a>
        <a href="adminprofile.jsp">Profile</a>
        <a href="adminsettings.jsp">Password Change</a>
        <a href="AdminLogoutServlet">Logout</a> 
    </div>

    <div class="container">
        <h1>Password Change</h1>

        <c:if test="${not empty errorMessage}">
            <div class="message error">${errorMessage}</div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="message success">${successMessage}</div>
        </c:if>

        <form action="AdminSettingsServlet" method="post">
            <label for="currentPassword">Current Password:</label>
            <input type="password" id="currentPassword" name="currentPassword" required><br>

            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required><br>

            <label for="confirmPassword">Confirm New Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required><br>

            <button type="submit">Change Password</button>
        </form>
    </div>
</body>
</html>
