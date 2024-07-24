package com.bank.Customer;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminSettingsServlet")
public class AdminSettingsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate the input
        if (newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New passwords do not match.");
            request.getRequestDispatcher("adminsettings.jsp").forward(request, response);
            return;
        }

        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Get database connection
            con = Database.getConnection();

            // Check current password
            String query = "SELECT password FROM admin WHERE username = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");

                if (!dbPassword.equals(currentPassword)) {
                    request.setAttribute("errorMessage", "Current password is incorrect.");
                    request.getRequestDispatcher("adminsettings.jsp").forward(request, response);
                    return;
                }

                // Update password
                query = "UPDATE admin SET password = ? WHERE username = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, newPassword);
                ps.setString(2, username);
                int rowsUpdated = ps.executeUpdate();

                if (rowsUpdated > 0) {
                    request.setAttribute("successMessage", "Password updated successfully.");
                } else {
                    request.setAttribute("errorMessage", "Failed to update password.");
                }
            } else {
                request.setAttribute("errorMessage", "User not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error.");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (ps != null) try { ps.close(); } catch (SQLException e) {}
            if (con != null) try { con.close(); } catch (SQLException e) {}
        }

        request.getRequestDispatcher("adminsettings.jsp").forward(request, response);
    }
}
