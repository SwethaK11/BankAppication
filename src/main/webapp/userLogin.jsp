<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login Form</title>
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
            background-image: url('images/bgpic.jpg');
            background-size: cover;
            background-position: center;
            position: relative; /* Added for absolute positioning of the Back button */
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
        h1 {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            text-align: left;
        }
        input[type="text"], input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .subbtn, .cancelbtn {
            padding: 10px 20px;
            background-color: MediumSlateBlue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-transform: uppercase;
            transition: background-color 0.3s, transform 0.3s ease-out;
            display: inline-block;
            margin: 10px 5px;
        }
        .subbtn:hover, .cancelbtn:hover, .backbtn:hover {
            background-color: #7b68ee;
            transform: translateY(-3px);
        }
        .subbtn:focus, .cancelbtn:focus, .backbtn:focus {
            background-color: #7b68ee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .container2 {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
        }
        .error-msg {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
        a {
            color: MediumSlateBlue;
        }
        a:hover {
            text-decoration: underline;
        }
        .remember-me {
            text-align: left;
            margin-top: 10px;
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
    <div class="container">
        <h1>User Login</h1>
        <form method="post" action="UserLoginServlet">
            <div class="container2">
                <label for="accountNumber">Account Number:</label>
                <input type="text" id="accountNumber" name="accountNumber" placeholder="Enter Account Number" required><br>
                
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter Password" required><br>
                
                <button type="submit" class="subbtn">Login</button>
                <button type="button" class="cancelbtn">Cancel</button><br>
                
                <div class="remember-me">
                    <input type="checkbox" checked> Remember Me
                </div><br>
                
                <div>
                    Forgot <a href="userChangePassword.jsp">password?</a>
                </div>
            </div>
        </form>

        <% 
            if (request.getParameter("error") != null) { 
        %>
            <p class="error-msg"><%= request.getParameter("error") %></p>
        <% 
            } 
        %>
    </div>
</body>
</html>
