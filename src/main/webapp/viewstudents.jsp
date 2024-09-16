<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Students</title>
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

        .search-form {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .search-form input[type="text"] {
            width: 300px;
            padding: 10px;
            margin-right: 10px;
        }

        .search-form button {
            padding: 10px 10px;
            background-color: #800080;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .search-form button:hover {
            background-color: #660066;
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
        <h2>View Students' Book Assignments</h2>

        <!-- Search form for searching based on PIN -->
        <form method="get" action="viewstudents.jsp" class="search-form">
            <input type="text" name="searchPin" placeholder="Enter PIN to Search" value="<%= request.getParameter("searchPin") %>">
            <button type="submit">Search</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>PIN</th>
                    <th>Book Code</th>
                    <th>Book Name</th>
                    <th>Author Name</th>
                    <th>Assign Date</th>
                    <th>Due Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String searchPin = request.getParameter("searchPin");

                    String sql = "SELECT * FROM books_assignments";
                    if (searchPin != null && !searchPin.trim().isEmpty()) {
                        sql += " WHERE pin LIKE ?";
                    }

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/library", "root", "ganesh12321");
                             PreparedStatement ps = conn.prepareStatement(sql)) {

                            if (searchPin != null && !searchPin.trim().isEmpty()) {
                                ps.setString(1, "%" + searchPin + "%");
                            }

                            try (ResultSet rs = ps.executeQuery()) {
                                while (rs.next()) {
                                    String pin = rs.getString("pin");
                                    String bookCode = rs.getString("bookCode");
                                    String bookName = rs.getString("bookName");
                                    String authorName = rs.getString("authorName");
                                    java.sql.Date assignDate = rs.getDate("assignDate");
                                    java.sql.Date dueDate = rs.getDate("dueDate");
                %>
                <tr>
                    <td><%= pin %></td>
                    <td><%= bookCode %></td>
                    <td><%= bookName %></td>
                    <td><%= authorName %></td>
                    <td><%= assignDate %></td>
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
