package com.bank.Customer;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.bank.Customer.Database;
@WebServlet("/DownloadPDFServlet")
public class DownloadPDFServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = (String) request.getSession().getAttribute("userId");

        String sql = "SELECT * FROM transactions WHERE user_id = ? ORDER BY transaction_id DESC LIMIT 10";

        try (Connection connection = Database.getConnection(); // Use centralized database connection
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, userId);
            ResultSet resultSet = statement.executeQuery();

            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            PdfWriter writer = new PdfWriter(byteArrayOutputStream);
            PdfDocument pdfDoc = new PdfDocument(writer);
            Document document = new Document(pdfDoc);

            // Add title to the PDF document
            document.add(new Paragraph("Transaction History").setFontSize(18));

            Table table = new Table(5);

            // Add table headers
            table.addCell(new Cell().add("Transaction ID"));
            table.addCell(new Cell().add("Date"));
            table.addCell(new Cell().add("Type"));
            table.addCell(new Cell().add("Amount"));
            table.addCell(new Cell().add("Balance"));

            // Add rows to the table
            while (resultSet.next()) {
                table.addCell(new Cell().add(resultSet.getString("transaction_id")));
                table.addCell(new Cell().add(resultSet.getString("date")));
                table.addCell(new Cell().add(resultSet.getString("type")));
                table.addCell(new Cell().add(resultSet.getString("amount")));
                table.addCell(new Cell().add(resultSet.getString("balance")));
            }

            // Add table to the document
            document.add(table);
            document.close();

            // Write the PDF to the response
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=transactions.pdf");
            response.setContentLength(byteArrayOutputStream.size());
            response.getOutputStream().write(byteArrayOutputStream.toByteArray());

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error.");
        }
    }
}
