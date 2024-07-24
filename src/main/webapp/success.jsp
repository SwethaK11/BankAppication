<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Successful</title>
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
        a {
            display: inline-block;
            padding: 10px 20px;
            background-color: MediumSlateBlue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            text-transform: uppercase;
            transition: background-color 0.3s, transform 0.3s ease-out;
        }
        a:hover {
            background-color: #7b68ee;
            transform: translateY(-3px);
        }
        a:focus {
            background-color: #7b68ee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Customer details updated successfully!</h1>
        <a href="modifycustomer.jsp">Go back</a>
    </div>
</body>
</html>
