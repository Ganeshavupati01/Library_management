<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="reg_style.css">
</head>
<body>
    <div>
        <h1 class="title">Library Management</h1>
        <div class="container">
            <h2>Login</h2>
            <form class="form-container" action="login" method="post">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <button type="submit">Login</button>
            </form>
            <div class="link-container">
                <a href="register.jsp">Create new account</a>
            </div>
        </div>
    </div>
</body>
</html>
