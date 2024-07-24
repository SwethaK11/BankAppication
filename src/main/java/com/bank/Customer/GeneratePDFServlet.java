package com.bank.Customer;
import com.bank.Customer.Database;
import java.io.IOException;
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
import javax.servlet.http.HttpSession;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@WebServlet("/GeneratePDFServlet")
public class GeneratePDFServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Retrieve existing session, don't create new
        if (session == null || session.getAttribute("accountNumber") == null) {
            response.getWriter().println("Session expired or account number not found. Please login again.");
            return;
        }

        String accountNumber = (String) session.getAttribute("accountNumber");
        String fileName = accountNumber + "_MiniStatement.pdf";

        String accountHolderName = ""; // Initialize empty
        String address = ""; // Initialize empty
        String accountType = ""; // Initialize empty
        double closingBalance = 0.0; // Initialize to 0.0

        List<Transaction> transactions = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmtAccount = null;
        PreparedStatement pstmtTransactions = null;
        ResultSet rsAccount = null;
        ResultSet rsTransactions = null;

        try {
            // Get database connection
            conn = Database.getConnection();

            // Retrieve account holder details from database
            pstmtAccount = conn.prepareStatement("SELECT fullName, address, accountType, balance FROM customers WHERE accountNumber = ?");
            pstmtAccount.setString(1, accountNumber);
            rsAccount = pstmtAccount.executeQuery();

            // Process the result set for account details
            if (rsAccount.next()) {
                accountHolderName = rsAccount.getString("fullName");
                address = rsAccount.getString("address");
                accountType = rsAccount.getString("accountType");
                closingBalance = rsAccount.getDouble("balance");
            } else {
                // Log a message if no account details were found
                System.out.println("No account details found for account number: " + accountNumber);
            }

            // Retrieve last 10 transactions
            pstmtTransactions = conn.prepareStatement(
                    "SELECT date, transactionType, amount, balance FROM transactions WHERE accountNumber = ? ORDER BY date DESC LIMIT 10");
            pstmtTransactions.setString(1, accountNumber);
            rsTransactions = pstmtTransactions.executeQuery();

            // Process transactions and add them to the list
            while (rsTransactions.next()) {
                Transaction transaction = new Transaction();
                transaction.setDate(rsTransactions.getString("date"));
                transaction.setType(rsTransactions.getString("transactionType"));
                transaction.setAmount(rsTransactions.getDouble("amount"));
                transaction.setBalance(rsTransactions.getDouble("balance"));
                transactions.add(transaction);
            }

            // Set content type for PDF
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

            // Create PDF document
            Document document = new Document(PageSize.A4.rotate()); // Landscape orientation
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Add header information with colored bank name
            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 24, Font.BOLD, new BaseColor(0, 102, 204)); // Blue color
            Paragraph header = new Paragraph("XYZ Bank - Account Statement", headerFont);
            header.setAlignment(Element.ALIGN_LEFT);
            document.add(header);

            // Add account holder information
            Font infoFont = FontFactory.getFont(FontFactory.HELVETICA, 16);
            Paragraph accountInfo = new Paragraph();
            accountInfo.add(new Phrase("Account Holder: ", infoFont));
            accountInfo.add(new Phrase(accountHolderName + "\n", FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            accountInfo.add(new Phrase("Address: ", infoFont));
            accountInfo.add(new Phrase(address + "\n\n", FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            accountInfo.add(new Phrase("Account Type: ", infoFont));
            accountInfo.add(new Phrase(accountType + "\n", FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            accountInfo.add(new Phrase("Closing Balance: $", infoFont));
            accountInfo.add(new Phrase(String.format("%.2f", closingBalance) + "\n\n", FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            document.add(accountInfo);

            // Add transaction history table
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            table.setSpacingBefore(20);
            table.addCell(createHeaderCell("Date"));
            table.addCell(createHeaderCell("Transaction Type"));
            table.addCell(createHeaderCell("Amount"));
            table.addCell(createHeaderCell("Balance"));

            for (Transaction transaction : transactions) {
                table.addCell(createCell(transaction.getDate()));
                table.addCell(createCell(transaction.getType()));
                table.addCell(createCell(String.format("%.2f", transaction.getAmount())));
                table.addCell(createCell(String.format("%.2f", transaction.getBalance())));
            }

            document.add(table);
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error generating PDF: " + e.getMessage());
        } finally {
            // Close resources in finally block
            try {
                if (rsAccount != null)
                    rsAccount.close();
                if (pstmtAccount != null)
                    pstmtAccount.close();
                if (rsTransactions != null)
                    rsTransactions.close();
                if (pstmtTransactions != null)
                    pstmtTransactions.close();
                if (conn != null)
                    conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Helper method to create PDF cell with content centered
    private PdfPCell createCell(String content) {
        PdfPCell cell = new PdfPCell(new Phrase(content, FontFactory.getFont(FontFactory.HELVETICA)));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        return cell;
    }

    // Helper method to create PDF cell for headers with content centered and bold
    private PdfPCell createHeaderCell(String content) {
        PdfPCell cell = new PdfPCell(new Phrase(content, FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBackgroundColor(new BaseColor(200, 200, 200)); // Light gray background
        return cell;
    }
}
