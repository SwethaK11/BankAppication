package com.bank.Customer;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String mobileNo = request.getParameter("mobileNo");
        String email = request.getParameter("email");
        String accountType = request.getParameter("accountType");
        String dobString = request.getParameter("dob");

        Date dob = Date.valueOf(dobString);

        customer customer = new customer();
        customer.setId(id);
        customer.setFullName(fullName);
        customer.setAddress(address);
        customer.setMobileNo(mobileNo);
        customer.setEmail(email);
        customer.setAccountType(accountType);
        customer.setDob(dob);

        CustomerDAO customerDAO = new CustomerDAO();
        boolean isSuccess = customerDAO.updateCustomer(customer);

        if (isSuccess) {
            response.sendRedirect("success.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
