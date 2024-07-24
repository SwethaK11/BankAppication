package com.bank.Customer;
import java.io.IOException;
import java.io.Serializable;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginSelectionServlet")
public class LoginSelectionServlet extends HttpServlet implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userType = request.getParameter("userType");

        if ("admin".equals(userType)) {
            // Redirect to admin login page
            response.sendRedirect("adminLogin.jsp");
        } else if ("user".equals(userType)) {
            // Redirect to user login page
            response.sendRedirect("userLogin.jsp");
        } else {
            // Handle invalid selection scenario
            response.sendRedirect("loginSelection.jsp"); // Redirect back to selection page
        }
    }
}

