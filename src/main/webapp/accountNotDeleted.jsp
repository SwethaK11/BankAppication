<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account Not Deleted</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image:url('images/bgpic.jpg');
            background-size: cover;
            background-position: center;
        }
        .container {
            width: 100%;
            max-width: 500px;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            box-sizing: border-box;
        }
        h2 {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        p {
            font-size: 16px;
            color: #333;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            background-color: MediumSlateBlue;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s ease-out;
        }
        .button:hover {
            background-color: #7b68ee;
            transform: translateY(-3px);
        }
        .button:focus {
            background-color: #7b68ee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Account Not Deleted</h2>
    <p>Your account cannot be deleted because it still has a positive balance.</p>
    <a href="userLogin.jsp" class="button">Go back to User Login</a>
</div>

</body>
</html>
