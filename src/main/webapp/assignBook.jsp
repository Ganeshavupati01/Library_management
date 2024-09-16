<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String pin = request.getParameter("pin");
    String bookCode = request.getParameter("bookCode");
    String bookName = request.getParameter("bookName");
    String authorName = request.getParameter("authorName");
    String assignDate = request.getParameter("assignDate");
    String dueDate = request.getParameter("dueDate");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/library", "root", "ganesh12321")) {
            // Insert into book_assignments table
            String insertSql = "INSERT INTO books_assignments (pin, bookCode, bookName, authorName, assignDate, dueDate) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                ps.setString(1, pin);
                ps.setString(2, bookCode);
                ps.setString(3, bookName);
                ps.setString(4, authorName);
                ps.setDate(5, Date.valueOf(assignDate));
                ps.setDate(6, Date.valueOf(dueDate));
                ps.executeUpdate();
            }

            // Update the noOfCopies in books table
            String updateSql = "UPDATE books SET noOfCopies = noOfCopies - 1 WHERE bookCode = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                ps.setString(1, bookCode);
                ps.executeUpdate();
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }

    // Redirect back to booksallocation.jsp with the entered parameters
    response.sendRedirect("booksallocation.jsp?pin=" + pin + "&assignDate=" + assignDate + "&dueDate=" + dueDate);
%>
