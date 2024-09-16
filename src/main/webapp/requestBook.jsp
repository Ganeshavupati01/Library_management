<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.mail.*, javax.mail.internet.*, java.util.Properties" %>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Request Book</title>
   <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #800080;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        input[type="text"], textarea {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            padding: 10px;
            background-color: #800080;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #660066;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Request Book</h2>
        <form method="post" action="requestBook.jsp">
            <input type="text" name="bookName" placeholder="Enter Book Name" required>
            <input type="text" name="authorName" placeholder="Enter Author Name" required>
            <textarea name="additionalInfo" placeholder="Enter Additional Information" rows="4"></textarea>
            <button type="submit">Send Request</button>
        </form>
        <%
            if (request.getMethod().equalsIgnoreCase("post")) {
                String bookName = request.getParameter("bookName");
                String authorName = request.getParameter("authorName");
                String additionalInfo = request.getParameter("additionalInfo");

                HttpSession s = request.getSession(false);
                String senderPin = (s != null) ? (String) s.getAttribute("pin") : "Unknown";
                String senderName = (s != null) ? (String) s.getAttribute("name") : "Unknown";

                // Database connection details
                String url = "jdbc:mysql://127.0.0.1:3306/library";
                String dbUsername = "root";
                String dbPassword = "ganesh12321";

                // Get the admin email from the database
                String recipient = null;
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUsername, dbPassword);
                    String sql = "SELECT email FROM users WHERE role = 'ADMIN'";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        recipient = rs.getString("email");
                    }
                } catch (Exception e) {
                    out.println("<p>Failed to retrieve admin email: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) {
                        try { rs.close(); } catch (SQLException e) { /* Ignored */ }
                    }
                    if (ps != null) {
                        try { ps.close(); } catch (SQLException e) { /* Ignored */ }
                    }
                    if (conn != null) {
                        try { conn.close(); } catch (SQLException e) { /* Ignored */ }
                    }
                }

                if (recipient != null) {
                    String subject = "Book Request";
                    String messageContent = "Requesting the following book:\n\n" +
                                            "Book Name: " + bookName + "\n" +
                                            "Author Name: " + authorName + "\n" +
                                            "Additional Information: " + additionalInfo + "\n\n" +
                                            "Requested by: " + senderName + " (PIN: " + senderPin + ")";

                    final String emailUsername = "20093cm010@gmail.com"; // Replace with your email
                    final String emailPassword = "fisl wkqx aanw dvjp"; // Replace with your app password

                    Properties props = new Properties();
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.starttls.enable", "true");
                    props.put("mail.smtp.host", "smtp.gmail.com");
                    props.put("mail.smtp.port", "587");
                    props.put("mail.smtp.connectiontimeout", "10000");
                    props.put("mail.smtp.timeout", "10000");

                    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(emailUsername, emailPassword);
                        }
                    });

                    try {
                        Message message = new MimeMessage(mailSession);
                        message.setFrom(new InternetAddress(emailUsername));
                        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
                        message.setSubject(subject);
                        message.setText(messageContent);

                        Transport.send(message);
                        out.println("<p>Email sent successfully!</p>");
                    } catch (MessagingException e) {
                        out.println("<p>Failed to send email: " + e.getMessage() + "</p>");
                    }
                } else {
                    out.println("<p>Admin email not found. Cannot send request.</p>");
                }
            }
        %>
    </div>
</body>
</html>
