<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Customer</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-image:url('images/bgpic.jpg');
            background-size: contain;
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
            transition: color 0.3s background-color 0.3s;
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
            width: 100%; /* Adjusted width */
            max-width: 600px; /* Added max-width for responsiveness */
            text-align: center;
            box-sizing: border-box;
            position: relative;
            margin: 100px auto 0; /* Margin top to create space below the navbar */
        }
        h1 {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input,
        .form-group textarea,
        .form-group select {
            width: calc(100% - 20px);
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        .form-group input[type="file"] {
            width: auto;
            padding: 5px;
        }
        .btn {
            padding: 10px 20px;
            background-color: MediumSlateBlue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s ease-out, border-color 0.3s;
            outline: none;
            font-size: 16px;
            font-weight: bold;
            text-transform: uppercase;
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
        .header {
            background-color: MediumSlateBlue;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 70px;
            font-weight: bold;
            margin-bottom: 20px;
            display: inline-block; /* Ensure it stays inline with content */
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <a href="admindashboard.jsp">Home</a>
        <a href="adminprofile.jsp">Profile</a>
        <a href="adminsettings.jsp">Password Change</a>
        <a href="AdminLogoutServlet">Logout</a>
    </div>

    <!-- Container for Add Customer Form -->
    <div class="container">
        <div class="header">Add Customer</div>
        <h1>Add New Customer</h1>
        <form method="post" action="RegisterCustomerServlet" enctype="multipart/form-data">
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <textarea id="address" name="address" rows="4" required></textarea>
            </div>
            <div class="form-group">
                <label for="mobileNo">Mobile No:</label>
                <input type="text" id="mobileNo" name="mobileNo" pattern="[0-9]{10}" required>
            </div>
            <div class="form-group">
                <label for="email">Email ID:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="accountType">Type of Account:</label>
                <select id="accountType" name="accountType" required>
                    <option value="Saving">Saving Account</option>
                    <option value="Current">Current Account</option>
                </select>
            </div>
            <div class="form-group">
                <label for="initialBalance">Initial Balance (minimum 1000):</label>
                <input type="number" id="initialBalance" name="initialBalance" min="1000" required>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" max="<%= java.time.LocalDate.now().minusYears(15) %>" required>
            </div>
            <div class="form-group">
                <label for="idProofType">ID Proof Type:</label>
                <select id="idProofType" name="idProofType" required>
                    <option value="Aadhar">Aadhar</option>
                    <option value="PAN">PAN</option>
                </select>
            </div>
            <div class="form-group">
                <label for="idProof">ID Proof (PDF, JPG, JPEG, PNG):</label>
                <input type="file" id="idProof" name="idProof" accept=".pdf,.jpg,.jpeg,.png" required>
            </div>
            <div class="form-group">
                <button type="submit" class="btn">Register Customer</button>
            </div>
        </form>
    </div>
</body>
</html>
