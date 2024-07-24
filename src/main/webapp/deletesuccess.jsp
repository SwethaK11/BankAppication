<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Successful</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-image:url('images/bgpic.jpg');
            background-size: cover;
            background-position: center;
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
            margin-top: 30px; /* Added margin top for space */
        }
        h1 {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
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
    <div class="container">
        <h1>Customer Deleted Successfully!</h1>
        <a href="admindashboard.jsp" class="btn">Go back to Dashboard</a>
    </div>
</body>
</html>
