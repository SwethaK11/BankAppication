<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.bank.Customer.Database" %> <!-- Update with the actual package name of your Database class -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('images/bgpic.jpg');
            background-size: cover;
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
            padding: 20px;
            width: 70%;
            max-width: 600px;
            text-align: center;
            box-sizing: border-box;
            margin-top: 80px; /* To avoid overlap with the fixed navbar */
        }
        h1 {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 20px;
            border: 2px solid MediumSlateBlue;
        }
        .profile-details {
            text-align: left;
            margin-top: 20px;
        }
        .profile-details div {
            margin-bottom: 10px;
            font-size: 18px;
            color: #333;
        }
        .profile-details label {
            font-weight: bold;
            margin-right: 10px;
        }
        .back-button {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: MediumSlateBlue;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
            font-weight: bold;
        }
        .back-button:hover {
            background-color: #7b68ee;
        }
        .back-button svg {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="admindashboard.jsp">Home</a>
        <a href="adminprofile.jsp">Profile</a>
        <a href="adminsettings.jsp">Password Change</a>
        <a href="AdminLogoutServlet">Logout</a>
    </div>

       

    <div class="container">
        <h1>Admin Profile</h1>
        <img src="images/profilepic.png" alt="Profile Image" class="profile-img">
        <div class="profile-details">
            <%
                String username = (String) session.getAttribute("username");

                if (username == null) {
                    response.sendRedirect("adminLogin.jsp");
                }

                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    // Get database connection using the Database class
                    con = Database.getConnection();

                    String query = "SELECT fullname, dob, username, email, mobileNo, address FROM admin WHERE username = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, username);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        %>
                        <div><label>Full Name:</label> <%= rs.getString("fullname") %></div>
                        <div><label>Date of Birth:</label> <%= rs.getDate("dob") %></div>
                        <div><label>Username:</label> <%= rs.getString("username") %></div>
                        <div><label>Email:</label> <%= rs.getString("email") %></div>
                        <div><label>Mobile Number:</label> <%= rs.getString("mobileNo") %></div>
                        <div><label>Address:</label> <%= rs.getString("address") %></div>
                        
                        <%
                    } else {
                        %>
                        <p>No user found.</p>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (ps != null) try { ps.close(); } catch (SQLException e) {}
                    if (con != null) try { con.close(); } catch (SQLException e) {}
                }
            %>
        </div>
    </div>
</body>
</html>
