<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession, java.time.LocalDate, java.time.temporal.ChronoUnit" %>
<%
    HttpSession s = request.getSession(false);
    String email = (s != null) ? (String) session.getAttribute("user") : null;
    String pin = null;
    String name = null;

    if (email != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/library", "root", "ganesh12321");
                 PreparedStatement ps = conn.prepareStatement("SELECT pin, name FROM users WHERE email = ?")) {

                ps.setString(1, email);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        pin = rs.getString("pin");
                        name = rs.getString("name");
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Allocated Books</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #800080;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #800080;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Allocated Books</h2>
        <p><strong>Name:</strong> <%= (name != null) ? name : "Unknown" %></p>
        <p><strong>Email:</strong> <%= (email != null) ? email : "Unknown" %></p>
        <%
            if (pin != null) {
        %>
        <table>
            <thead>
                <tr>
                    <th>Book Code</th>
                    <th>Book Name</th>
                    <th>Author Name</th>
                    <th>Assign Date</th>
                    <th>Due Date</th>
                    <th>Fee</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String sql = "SELECT bookCode, bookName, authorName, assignDate, dueDate FROM books_assignments WHERE pin = ?";
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/library", "root", "ganesh12321");
                             PreparedStatement ps = conn.prepareStatement(sql)) {

                            ps.setString(1, pin);

                            try (ResultSet rs = ps.executeQuery()) {
                                while (rs.next()) {
                                    String bookCode = rs.getString("bookCode");
                                    String bookName = rs.getString("bookName");
                                    String authorName = rs.getString("authorName");
                                    java.sql.Date assignDate = rs.getDate("assignDate");
                                    java.sql.Date dueDate = rs.getDate("dueDate");
                                    
                                    // Calculate fee if due date has passed
                                    long fee = 0;
                                    LocalDate currentDate = LocalDate.now();
                                    LocalDate dueDateLocal = dueDate.toLocalDate();
                                    if (currentDate.isAfter(dueDateLocal)) {
                                        long daysLate = ChronoUnit.DAYS.between(dueDateLocal, currentDate);
                                        fee = daysLate * 2; // 2 Rs per day
                                    }
                %>
                <tr>
                    <td><%= bookCode %></td>
                    <td><%= bookName %></td>
                    <td><%= authorName %></td>
                    <td><%= assignDate %></td>
                    <td><%= dueDate %></td>
                    <td><%= fee %> Rs</td>
                </tr>
                <%
                                }
                            }
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <p>No books allocated or user not logged in.</p>
        <%
            }
        %>
    </div>
</body>
</html>
