<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Management Home</title>
    <link rel="stylesheet" type="text/css" href="home_style.css">
</head>
<body>
    <div class="header">Library Management</div>
    <div class="nav">
        <a href="home.jsp">Home</a>
        <a href="#" onclick="loadIframe('account.jsp')">Account</a>
        <a href="login.jsp">Login</a>
        <a href="about.jsp">About</a>
    </div>
    <div class="main-container">
        <div class="side-nav">
            <a href="#" onclick="loadIframe('addnewbooks.jsp')">Add New Books</a>
            <a href="#" onclick="loadIframe('viewbooks.jsp')">View Books</a>
            <a href="#" onclick="loadIframe('viewstudents.jsp')">View Students Accounts</a>
             <a href="#" onclick="loadIframe('booksallocation.jsp')">Books Allocation</a>
             <a href="#" onclick="loadIframe('booksdeallocation.jsp')">Books Deallocation</a>
            <a href="#" onclick="loadIframe('crossedDueDates.jsp')">Crossed Due Dates</a>
        </div>
        <div class="content">
            <iframe id="iframeContent" src=""></iframe>
        </div>
    </div>
    <script>
        function loadIframe(page) {
            document.getElementById('iframeContent').src = page;
        }
    </script>
</body>
</html>
