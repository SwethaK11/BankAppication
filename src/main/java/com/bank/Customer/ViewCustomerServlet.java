package com.bank.Customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bank.Customer.Database;

@WebServlet("/ViewCustomerServlet")
public class ViewCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<customer> customers = new ArrayList<>();

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset=\"UTF-8\">");
        out.println("<title>View Customers</title>");
        out.println("<style>");
        out.println("body {");
        out.println("    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;");
        out.println("    background-color: #f3f4f6;");
        out.println("    margin: 0;");
        out.println("    background-image: url('images/bgpic.jpg');");
        out.println("    background-size: cover;");
        out.println("    background-position: center;");
        out.println("}");
        out.println(".navbar {");
        out.println("    background-color: rgba(255, 255, 255, 0.8);");
        out.println("    backdrop-filter: blur(10px);");
        out.println("    padding: 10px 0;");
        out.println("    width: 100%;");
        out.println("    position: fixed;");
        out.println("    top: 0;");
        out.println("    left: 0;");
        out.println("    z-index: 1000;");
        out.println("    display: flex;");
        out.println("    justify-content: space-around;");
        out.println("    align-items: center;");
        out.println("    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);");
        out.println("}");
        out.println(".navbar a {");
        out.println("    color: MediumSlateBlue;");
        out.println("    text-decoration: none;");
        out.println("    font-weight: bold;");
        out.println("    padding: 10px 20px;");
        out.println("    transition: color 0.3s background-color 0.3s;");
        out.println("}");
        out.println(".navbar a:hover {");
        out.println("    color: white;");
        out.println("    background-color: #CCCCFF;");
        out.println("}");
        out.println(".container {");
        out.println("    background-color: rgba(255, 255, 255, 0.8);");
        out.println("    backdrop-filter: blur(10px);");
        out.println("    border-radius: 20px;");
        out.println("    box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);");
        out.println("    padding: 30px;");
        out.println("    width: 95%;");
        out.println("    max-width: 1200px;");
        out.println("    text-align: center;");
        out.println("    box-sizing: border-box;");
        out.println("    margin: 80px auto 0; /* Center container horizontally and provide margin from top */");
        out.println("    overflow-x: auto;");
        out.println("}");
        out.println("h1 {");
        out.println("    color: MediumSlateBlue;");
        out.println("    margin-bottom: 20px;");
        out.println("    font-size: 36px;");
        out.println("    font-weight: bold;");
        out.println("}");
        out.println("table {");
        out.println("    width: 100%;"); /* Center the table */
        out.println("    margin: 0 auto;"); /* Center horizontally */
        out.println("    border-collapse: collapse;");
        out.println("    margin-top: 20px;");
        out.println("}");
        out.println("th, td {");
        out.println("    border: 1px solid #ddd;");
        out.println("    padding: 8px;");
        out.println("    text-align: left;");
        out.println("}");
        out.println("th {");
        out.println("    background-color: MediumSlateBlue;");
        out.println("    color: white;");
        out.println("}");
        out.println("tr:nth-child(even) {");
        out.println("    background-color: #f2f2f2;");
        out.println("}");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class=\"navbar\">");
        out.println("    <a href=\"admindashboard.jsp\">Home</a>");
        out.println("    <a href=\"adminprofile.jsp\">Profile</a>");
        out.println("    <a href=\"adminsettings.jsp\">Password Change</a>");
        out.println("    <a href=\"AdminLogoutServlet\">Logout</a>");
        out.println("</div>");
        out.println("<div class=\"container\">");
        out.println("<h1>View Customers List</h1>");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // Get connection from Database class
            connection = Database.getConnection();
            String sql = "SELECT accountNumber, fullName, address, mobileNo, email, accountType, dob FROM customers";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                customer customer = new customer();
                customer.setAccountNumber(resultSet.getString("accountNumber"));
                customer.setFullName(resultSet.getString("fullName"));
                customer.setAddress(resultSet.getString("address"));
                customer.setMobileNo(resultSet.getString("mobileNo"));
                customer.setEmail(resultSet.getString("email"));
                customer.setAccountType(resultSet.getString("accountType"));
                customer.setDob(resultSet.getDate("dob"));
                customers.add(customer);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (!customers.isEmpty()) {
            out.println("<table>");
            out.println("<thead>");
            out.println("<tr>");
            out.println("<th>Account Number</th>");
            out.println("<th>Full Name</th>");
            out.println("<th>Address</th>");
            out.println("<th>Mobile No</th>");
            out.println("<th>Email</th>");
            out.println("<th>Account Type</th>");
            out.println("<th>Date of Birth</th>");
            out.println("</tr>");
            out.println("</thead>");
            out.println("<tbody>");
            for (customer customer : customers) {
                out.println("<tr>");
                out.println("<td>" + customer.getAccountNumber() + "</td>");
                out.println("<td>" + customer.getFullName() + "</td>");
                out.println("<td>" + customer.getAddress() + "</td>");
                out.println("<td>" + customer.getMobileNo() + "</td>");
                out.println("<td>" + customer.getEmail() + "</td>");
                out.println("<td>" + customer.getAccountType() + "</td>");
                out.println("<td>" + customer.getDob() + "</td>");
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
        } else {
            out.println("<p>No customers found</p>");
        }

        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}
