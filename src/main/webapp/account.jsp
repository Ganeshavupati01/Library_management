<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession s = request.getSession(false);
    String email = (s != null) ? (String) s.getAttribute("user") : "Guest";
    String pin = (s != null) ? (String) s.getAttribute("pin") : "Unknown";
    String name = (s != null) ? (String) s.getAttribute("name") : "Unknown";
    String phone = (s != null) ? (String) s.getAttribute("phone") : "Unknown";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            padding: 20px;
        }
        .info {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .info h2 {
            color: #800080;
        }
    </style>
</head>
<body>
    <div class="info">
        <h2>Account Information</h2>
        <p><strong>Email:</strong> <%= email %></p>
        <p><strong>Pin:</strong> <%= pin %></p>
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Phone:</strong> <%= phone %></p>
    </div>
</body>
</html>
