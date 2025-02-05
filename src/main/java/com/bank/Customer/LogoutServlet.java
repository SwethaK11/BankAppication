package com.bank.Customer;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String accountNumber = (String) session.getAttribute("accountNumber");

            // Update last login timestamp
            if (accountNumber != null) {
                CustomerDAO customerDAO = new CustomerDAO();
                try {
					customerDAO.updateLastLogin(accountNumber, Timestamp.valueOf(LocalDateTime.now()));
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }

            // Invalidate current session
            session.invalidate();
        }
        response.sendRedirect("userLogin.jsp"); // Redirect to login page
    }
}
