<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.bank.Customer.customer" %>
<%@ page import="com.bank.Customer.CustomerDAO" %>



<!DOCTYPE html>
<html>
<head>
    <title>Update Customer Details</title>
</head>



<body>
    <div>
        <%
        String idString = request.getParameter("id");
        int id = idString != null && !idString.isEmpty() ? Integer.parseInt(idString) : 0;

        // Retrieve other parameters from the form
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String mobileNo = request.getParameter("mobileNo");
        String email = request.getParameter("email");
        String accountType = request.getParameter("accountType");
        String dob = request.getParameter("dob");

        // Create a Customer object with updated details
        customer customer = new customer();
        customer.setId(id);
        customer.setFullName(fullName);
        customer.setAddress(address);
        customer.setMobileNo(mobileNo);
        customer.setEmail(email);
        customer.setAccountType(accountType);
        //customer.setDob(dob);

        // Update customer details using CustomerDAO
        CustomerDAO customerDAO = new CustomerDAO();
        boolean isUpdated = customerDAO.updateCustomer(customer);
        %>
        
        <% if (isUpdated) { %>
        <p style="color: green;">Customer details updated successfully!</p>
        <% } else { %>
        <p style="color: red;">Error updating customer details.</p>
        <% } %>
        
        <p><a href="modifycustomer.jsp">Back to Modify Customer</a></p>
    </div>
</body>
</html>