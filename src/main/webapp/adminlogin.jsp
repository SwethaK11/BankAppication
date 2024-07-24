<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login Form</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-image: url('images/bgpic.jpg');
            background-size: cover;
            background-position: center;
            position: relative; /* Added for absolute positioning of the Back button */
        }
        .overlay {
            background-color: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            padding: 30px;
            width: 350px;
            text-align: center;
            box-sizing: border-box;
        }
        h1 {
            color: #333333;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: bold;
        }
        label {
            display: block;
            margin-bottom: 10px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .btn {
            background-color: MediumSlateBlue;
            color: white;
            padding: 12px 40px;
            border: 2px solid black;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s, transform 0.3s ease-out, border-color 0.3s;
            outline: none;
            font-size: 18px;
            font-weight: bold;
            text-transform: uppercase;
            width: 100%;
            box-sizing: border-box;
        }
        .btn:hover {
            background-color: #7b68ee;
            transform: translateY(-3px);
            border-color: #663399;
        }
        .btn:focus {
            background-color: #7b68ee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-color: #663399;
        }
        .error-msg {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
        .forgot-password {
            margin-top: 15px;
            font-size: 14px;
        }
        .forgot-password a {
            color: MediumSlateBlue;
            text-decoration: none;
        }
        .forgot-password a:hover {
            text-decoration: underline;
        }
        	
        .backbtn:hover {
            background-color: #7b68ee;
            transform: translateY(-3px);
        }
        .backbtn:focus {
            background-color: #7b68ee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .backbtn {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 10px 20px;
            background-color: #F4F6F7;
            color: black;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-transform: uppercase;
            transition: background-color 0.3s, transform 0.3s ease-out;
            display: inline-block;
            margin: 10px 5px;
        }
    </style>
</head>
<body>
    <button type="button" class="backbtn" onclick="window.location.href='loginSelection.jsp'">Back</button>
    <div class="overlay">
        <h1>Admin Login</h1>
        <form method="post" action="LoginServlet">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" placeholder="Enter Username" required><br><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Enter Password" required><br><br>
            <button type="submit" class="btn">Login</button>
            <c:if test="${not empty error}">
                <p class="error-msg">${error}</p>
            </c:if>
            <input type="checkbox" checked>Remember Me
            <div class="forgot-password">
                Forgot <a href="adminchangepassword.jsp">password?</a>
            </div>
        </form>
    </div>
</body>
</html>
