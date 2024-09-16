<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Books</title>
   
   	<style>
   	
   		body {
    font-family: Arial, sans-serif;
    background-color: #f3f3f3;
    margin: 0;
    padding: 20px;
}

.container {
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    max-width: 800px;
    margin: 0 auto;
}

h2 {
    color: #800080;
    margin-bottom: 20px;
}

form {
    margin-bottom: 20px;
}

form input[type="text"] {
    padding: 10px;
    width: calc(100% - 22px);
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-right: 10px;
}

form button {
    padding: 10px 20px;
    background-color: #800080;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

form button:hover {
    background-color: #660066;
}

table {
    width: 100%;
    border-collapse: collapse;
}

table, th, td {
    border: 1px solid #ddd;
}

th, td {
    padding: 10px;
    text-align: left;
}

th {
    background-color: #f3f3f3;
}

tr:nth-child(even) {
    background-color: #f9f9f9;
}
   		
   	
   	</style>
   
</head>
<body>
    <div class="container">
        <h2>View Books</h2>
        <form method="get" action="viewbooks.jsp">
            <input type="text" name="search" placeholder="Search by Book Code, Name, or Author" value="<%= request.getParameter("search") %>">
            <button type="submit">Search</button>
        </form>
        <table>
            <thead>
                <tr>
                    <th>Book Code</th>
                    <th>Book Name</th>
                    <th>Author Name</th>
                    <th>No Of Copies</th>
                    <th>Additional Info</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String searchQuery = request.getParameter("search");
                    String sql = "SELECT * FROM books";
                    boolean hasSearchQuery = searchQuery != null && !searchQuery.trim().isEmpty();
                    if (hasSearchQuery) {
                        sql += " WHERE bookCode LIKE ? OR bookName LIKE ? OR authorName LIKE ?";
                    }

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "ganesh12321");
                             PreparedStatement ps = conn.prepareStatement(sql)) {

                            if (hasSearchQuery) {
                                String queryParam = "%" + searchQuery + "%";
                                ps.setString(1, queryParam);
                                ps.setString(2, queryParam);
                                ps.setString(3, queryParam);
                            }

                            try (ResultSet rs = ps.executeQuery()) {
                                while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("bookCode") %></td>
                    <td><%= rs.getString("bookName") %></td>
                    <td><%= rs.getString("authorName") %></td>
                    <td><%= rs.getInt("noOfCopies") %></td>
                    <td><%= rs.getString("additionalInfo") %></td>
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
