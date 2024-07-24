<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer List</title>
    <style>
        /* Center align heading */
        h1 {
            text-align: center;
        }	

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px; /* Adjust spacing as needed */
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Customer List</h1>

    <table>
        <thead>
            <tr>
                <th>Account Number</th>
                <th>Full Name</th>
                <th>Address</th>
                <th>Mobile No</th>
                <th>Email</th>
                <th>Account Type</th>
                <th>Date of Birth</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="customer" items="${customers}">
                <tr>
                    <td>${customer.accountNumber}</td>
                    <td>${customer.fullName}</td>
                    <td>${customer.address}</td>
                    <td>${customer.mobileNo}</td>
                    <td>${customer.email}</td>
                    <td>${customer.accountType}</td>
                    <td>${customer.dob}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>