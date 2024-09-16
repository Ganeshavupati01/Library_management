<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.net.URLEncoder" %>
<%
    String pin = request.getParameter("pin");
    String bookCode = request.getParameter("bookCode");
    String searchPin = request.getParameter("searchPin");

    String deleteSql = "DELETE FROM books_assignments WHERE pin = ? AND bookCode = ?";
    String updateSql = "UPDATE books SET noOfCopies = noOfCopies + 1 WHERE bookCode = ?";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/library", "root", "ganesh12321")) {
            // Deallocate the book assignment
            try (PreparedStatement deletePs = conn.prepareStatement(deleteSql)) {
                deletePs.setString(1, pin);
                deletePs.setString(2, bookCode);
                deletePs.executeUpdate();
            }

            // Increment the number of copies in the books table
            try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                updatePs.setString(1, bookCode);
                updatePs.executeUpdate();
            }

            // Redirect back to booksdeallocation.jsp with searchPin parameter
            response.sendRedirect("booksdeallocation.jsp?searchPin=" + URLEncoder.encode(searchPin, "UTF-8"));
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
