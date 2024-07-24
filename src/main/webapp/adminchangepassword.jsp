<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Change Password</title>
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
            max-width: 400px;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            box-sizing: border-box;
        }
        h1 {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }
        button {
            padding: 10px 20px;
            background-color: MediumSlateBlue;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            width: 100%;
            text-transform: uppercase;
            transition: background-color 0.3s, transform 0.3s ease-out;
        }
        button:hover {
            background-color: #7b68ee;
            transform: translateY(-3px);
        }
        button:focus {
            background-color: #7b68ee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .error-msg {
            color: red;
            margin-top: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admin Change Password</h1>
        <form method="post" action="AdminChangePasswordServlet">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br>
            <label for="newPassword">Set Password:</label>
            <input type="password" id="newPassword" name="newPassword" required><br>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required><br>
            <button type="submit">Change Password</button>
        </form>
        <c:if test="${not empty error}">
            <p class="error-msg">${error}</p>
        </c:if>
    </div>
</body>
</html>
