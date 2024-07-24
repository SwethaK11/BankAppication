package com.bank.Customer;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ModifyCustomerServlet")
public class ModifyCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");

        customer customer = CustomerDAO.getCustomerByAccountNumber(accountNumber);

        if (customer != null) {
            request.setAttribute("customer", customer);
            RequestDispatcher dispatcher = request.getRequestDispatcher("modifycustomer.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Customer not found.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
