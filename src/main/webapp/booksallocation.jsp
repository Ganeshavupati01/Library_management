<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Books Allocation</title>
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

        form {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: center; /* Center the form content */
            margin-bottom: 20px;
        }

        form label {
            margin-right: 10px;
        }

        form input, form button {
            padding: 10px;
            margin-right: 10px;
        }

        form input[type="text"], form input[type="date"] {
            width: 150px;
        }

        .assignment-button {
            padding: 10px 10px; /* Smaller button size */
            background-color: #800080;
            color: white;
            border: none;
            cursor: pointer;
            margin: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
            align-self: center; /* Center the button */
        }

        .assignment-button:hover {
            background-color: #660066;
        }

        .search-form {
            display: flex;
            justify-content: center; /* Center the search form content */
            margin-bottom: 20px;
        }

        .search-form input[type="text"] {
            width: 300px;
            padding: 10px;
            margin-right: 10px;
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

        button {
            background-color: #800080;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #660066;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Books Allocation</h2>

        <!-- Form for setting PIN, Assign Date, and Due Date -->
        <form method="get" action="booksallocation.jsp">
            <label for="pin">PIN:</label>
            <input type="text" id="pin" name="pin" placeholder="Enter PIN" required value="<%= request.getParameter("pin") %>">

            <label for="assignDate">Assign Date:</label>
            <input type="date" id="assignDate" name="assignDate" required value="<%= request.getParameter("assignDate") %>">

            <label for="dueDate">Due Date:</label>
            <input type="date" id="dueDate" name="dueDate" required value="<%= request.getParameter("dueDate") %>"><br>
            <br>
            <button type="submit" class="assignment-button">Set Details</button>
        </form>

        <!-- Search form for finding a particular book -->
        <form method="get" action="booksallocation.jsp" class="search-form">
            <input type="text" name="searchQuery" placeholder="Enter Book Code or Name" value="<%= request.getParameter("searchQuery") %>">
            <input type="hidden" name="pin" value="<%= request.getParameter("pin") %>">
            <input type="hidden" name="assignDate" value="<%= request.getParameter("assignDate") %>">
            <input type="hidden" name="dueDate" value="<%= request.getParameter("dueDate") %>">
            <button type="submit" class="assignment-button">Search</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>Book Code</th>
                    <th>Book Name</th>
                    <th>Author Name</th>
                    <th>No Of Copies</th>
                    <th>Additional Info</th>
                    <th>Assign</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String pin = request.getParameter("pin");
                    String assignDate = request.getParameter("assignDate");
                    String dueDate = request.getParameter("dueDate");
                    String searchQuery = request.getParameter("searchQuery");

                    String sql = "SELECT * FROM books";
                    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                        sql += " WHERE bookCode LIKE ? OR bookName LIKE ?";
                    }

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/library", "root", "ganesh12321");
                             PreparedStatement ps = conn.prepareStatement(sql)) {

                            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                                ps.setString(1, "%" + searchQuery + "%");
                                ps.setString(2, "%" + searchQuery + "%");
                            }

                            try (ResultSet rs = ps.executeQuery()) {
                                while (rs.next()) {
                                    String bookCode = rs.getString("bookCode");
                                    String bookName = rs.getString("bookName");
                                    String authorName = rs.getString("authorName");
                                    int noOfCopies = rs.getInt("noOfCopies");
                %>
                <tr>
                    <td><%= bookCode %></td>
                    <td><%= bookName %></td>
                    <td><%= authorName %></td>
                    <td><%= noOfCopies %></td>
                    <td><%= rs.getString("additionalInfo") %></td>
                    <td>
                        <!-- Assignment form for each book -->
                        <form method="post" action="assignBook.jsp">
                            <input type="hidden" name="pin" value="<%= pin %>">
                            <input type="hidden" name="bookCode" value="<%= bookCode %>">
                            <input type="hidden" name="bookName" value="<%= bookName %>">
                            <input type="hidden" name="authorName" value="<%= authorName %>">
                            <input type="hidden" name="assignDate" value="<%= assignDate %>">
                            <input type="hidden" name="dueDate" value="<%= dueDate %>">
                            <button type="submit" <%= (pin == null || assignDate == null || dueDate == null) ? "disabled" : "" %>>Assign</button>
                        </form>
                    </td>
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
