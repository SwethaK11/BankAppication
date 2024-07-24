<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Selection</title>
    <style>
        body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f3f4f6;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    padding: 0;
    position: relative;
    overflow: hidden;
}

body::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('images/bgpic.jpg');
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
   }

body::after {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.1); /* Adjust this value for darkness */
    z-index: -1; /* Ensure the overlay is behind the content */
}
        
        .overlay {
            background-color: rgba(255, 255, 255, 0.5); /* Adjust transparency here */
            backdrop-filter: blur(10px);
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            padding: 30px;
            width: 350px;
            text-align: center;
            box-sizing: border-box;
        }
        h2 {
            color: #333333;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: bold; /* Professional font weight */
        }
        .button-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
            align-items: center;
        }
        .button-group label {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .button-group label input[type="radio"] {
            display: none;
        }
        .button-group label button {
            background-color: MediumSlateBlue; /* Change button color */
            color: white;
            padding: 12px 40px; /* Adjusted padding for consistent width */
            border: 2px solid black; /* Add border */
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s, transform 0.3s ease-out, border-color 0.3s; /* Add border color transition */
            outline: none;
            font-size: 18px; /* Larger font size */
            font-weight: bold; /* Professional font weight */
            text-transform: uppercase;
            width: 100%; /* Ensure buttons take full width of their container */
            box-sizing: border-box; /* Include padding and border in width calculation */
        }
        .button-group label button:hover {
            background-color: #7b68ee; /* Darker shade on hover */
            transform: translateY(-3px); /* Move button up by 3px on hover */
            border-color: #663399; /* Darker border color on hover */
        }
        .button-group label button:focus {
            background-color: #7b68ee; /* Darker shade on focus */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-color: #663399; /* Darker border color on focus */
        }
    </style>
</head>
<body>
    <div class="overlay">
        <h2>Please select your login type</h2>
        <div class="button-group"> 
            <form action="adminlogin.jsp" method="post">
                <label>
                    <input type="radio" name="userType" value="admin">
                    <button type="submit" name="submit">Admin</button>
                </label>
            </form>
            <form action="userLogin.jsp" method="post">
                <label>
                    <input type="radio" name="userType" value="user">
                    <button type="submit">User</button>
                </label>
            </form>	 
        </div>
    </div>
</body>
</html>
