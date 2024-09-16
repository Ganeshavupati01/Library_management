<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crossed Due Dates</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            padding: 20px;
            margin: 0;
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
            margin-bottom: 20px;
            text-align: center;
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
        <h2>Students with Crossed Due Dates</h2>

        <table>
            <thead>
                <tr>
                    <th>PIN</th>
                    <th>Book Code</th>
                    <th>Book Name</th>
                    <th>Due Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Get current date
                    java.util.Date currentDate = new java.util.Date(System.currentTimeMillis());

                    String sql = "SELECT pin, bookCode, bookName, dueDate FROM books_assignments WHERE dueDate < ?";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/library", "root", "ganesh12321");
                             PreparedStatement ps = conn.prepareStatement(sql)) {

                            ps.setDate(1, new java.sql.Date(currentDate.getTime()));

                            try (ResultSet rs = ps.executeQuery()) {
                                while (rs.next()) {
                                    String pin = rs.getString("pin");
                                    String bookCode = rs.getString("bookCode");
                                    String bookName = rs.getString("bookName");
                                    java.sql.Date dueDate = rs.getDate("dueDate");
                %>
                <tr>
                    <td><%= pin %></td>
                    <td><%= bookCode %></td>
                    <td><%= bookName %></td>
                    <td><%= dueDate %></td>
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
    </div>
</body>
</html>
