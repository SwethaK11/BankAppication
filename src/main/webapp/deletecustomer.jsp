<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Customer</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            display: flex;
            justify-content: center;
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
            width: 60%; /* Adjusted width */
            max-width: 600px; /* Added max-width for responsiveness */
            text-align: center;
            box-sizing: border-box;
            position: relative;
            margin: 100px auto 0; /* Adjusted margin top for space below the navbar */
        }
        h1 {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        label {
            display: block;
            margin-bottom: 10px;
            color: #333; /* Darker text color */
            font-weight: bold; /* Bold label text */
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc; /* Light border */
            border-radius: 4px; /* Rounded corners */
            font-size: 16px; /* Slightly larger font */
        }
        .btn {
            padding: 10px 15px;
            background-color: MediumSlateBlue; /* Button color */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-transform: uppercase; /* Uppercase button text */
            transition: background-color 0.3s, transform 0.3s ease-out;
            outline: none; /* Remove outline */
            width: 100%; /* Full width button */
            margin-top: 20px; /* Margin top for spacing */
        }
        .btn:hover {
            background-color: #7b68ee; /* Darker shade on hover */
            transform: translateY(-3px); /* Move button up by 3px on hover */
        }
        .btn:focus {
            background-color: #7b68ee; /* Darker shade on focus */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="admindashboard.jsp">Home</a>
        <a href="adminprofile.jsp">Profile</a>
        <a href="adminsettings.jsp">Password Change</a>
        <a href="AdminLogoutServlet.jsp">Logout</a>
    </div>
    <div class="container">
        <h1>Delete Customer</h1>
        <form action="DeleteCustomerServlet" method="post">
            <label for="accountNumber">Account Number:</label>
            <input type="text" id="accountNumber" name="accountNumber" required>
            <input type="submit" class="btn" value="Delete Customer">
        </form>
    </div>
</body>
</html>
