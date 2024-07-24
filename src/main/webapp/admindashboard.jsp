<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
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
        .overlay {
			    background-color: rgba(255, 255, 255, 0.5); /* Adjust transparency here */
			    backdrop-filter: blur(10px);
			    border-radius: 20px;
			    box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
			    padding: 50px;
			    width: 400px;
			    text-align: center;
			    box-sizing: border-box;
			    margin: auto; /* Center the overlay horizontally */
			    position: relative; /* Position relative for centering */
			    top: 35%; /* Move overlay down */
			    transform: translateY(-50%); /* Center vertically */
}
        h1 {
            color: #333333;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: bold; /* Professional font weight */
        }
        .button-group {
            display: flex;
            flex-direction: column;
            gap: 15px; /* Space between buttons */
            align-items: center;
        }
        .button-group form {
            width: 100%;
        }
        .button-group label {
            display: flex;
            align-items: center;
            gap: 10px;
            width: 100%;
        }
        .button-group label input[type="submit"] {
            display: none;
        }
        .button-group label button {
            flex: 1;
            background-color: MediumSlateBlue; /* Change button color */
            color: white;
            padding: 10px 30px; /* Adjusted padding for consistent width */
            border: 2px solid black; /* Add border */
            cursor: pointer;
            border-radius: 20px;
            transition: background-color 0.3s, transform 0.3s ease-out, border-color 0.3s; /* Add border color transition */
            outline: none;
            font-size: 16px; /* Reduced font size */
            font-weight: bold; /* Professional font weight */
            text-transform: uppercase;
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
    </form>   
     </div>
    <div class="overlay">
        <h1>Welcome to Admin Dashboard</h1>
        <div class="button-group">
            <form action="addcustomer.jsp" method="post">
                <label>
                    <input type="submit" name="userType" value="Add Customer">
                    <button type="submit">Add Customer</button>
                </label>
            </form>
            <form action="modifycustomer.jsp" method="post">
                <label>
                    <input type="submit" name="userType" value="Modify Customer">
                    <button type="submit">Modify Customer</button>
                </label>
            </form>
            <form action="ViewCustomerServlet" method="get">
                <label>
                    <input type="submit" name="userType" value="View Customers">
                    <button type="submit">View Customers</button>
                </label>
            </form>
            <form action="deletecustomer.jsp" method="post">
                <label>
                    <input type="submit" name="userType" value="Delete Customer">
                    <button type="submit">Delete Customer</button>
                </label>
            </form>
        </div>
    </div>
</body>
</html>
