<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Successful</title>
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
            background-size: contain;
            background-position: center;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            padding: 30px;
            width: 70%; /* Adjusted width */
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
        .success-message {
            font-size: 24px;
            color: #28a745;
            margin-bottom: 20px;
        }
        .details {
            font-size: 18px;
            margin-bottom: 10px;
            text-align: center; /* Align details text left */
        }
        .details p {
            margin: 5px 0;
        }
        .highlight {
            font-weight: bold;
            color: #333;
            text-align:center;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: MediumSlateBlue;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            border: 2px solid black; /* Add border */
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s ease-out, border-color 0.3s; /* Add border color transition */
            outline: none;
            font-size: 16px; /* Reduced font size */
            font-weight: bold; /* Professional font weight */
            text-transform: uppercase;
            box-sizing: border-box; /* Include padding and border in width calculation */
        }
        .btn:hover {
            background-color: #7b68ee; /* Darker shade on hover */
            transform: translateY(-3px); /* Move button up by 3px on hover */
            border-color: #663399; /* Darker border color on hover */
        }
        .btn:focus {
            background-color: #7b68ee; /* Darker shade on focus */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-color: #663399; /* Darker border color on focus */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="success-message">Registration Successful!</h1>
        <div class="details">
            <p>Your account has been created successfully.</p>
            <p><span class="highlight">Account Number:</span> ${accountNumber}</p>
            <p><span class="highlight">Temporary Password:</span> ${temporaryPassword}</p>
        </div>
        <p>Please remember to change your password after logging in.</p>
        <a href="admindashboard.jsp" class="btn">Back to Admin Dashboard</a>
    </div>
</body>
</html>
