<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="reg_style.css">
</head>
<body>
    <div class="wrapper">
        <div class="left-side">
            <h1 class="title">Library Management</h1>
        </div>
        <div class="right-side">
            <div class="container">
                <form action="RegisterServlet" method="post">
                    <div class="input-group">
                        <label for="role">Role:</label>
                        <div class="radio-group">
                            <label for="admin">
                                <input type="radio" id="admin" name="role" value="ADMIN" checked> Admin
                            </label>
                            <label for="user">
                                <input type="radio" id="user" name="role" value="USER"> User
                            </label>
                        </div>
                    </div>
                     <div class="input-group">
                        <label for="name">NAME:</label>
                        <input type="text" name="name" id="name" required>
                    </div>
                    <div class="input-group">
                        <label for="pin">PIN:</label>
                        <input type="text" name="pin" id="pin" required>
                    </div>
                    <div class="input-group">
                        <label for="phone">Phone Number:</label>
                        <input type="number" name="phone" id="phone" required>
                    </div>
                    <div class="input-group">
                        <label for="email">Email:</label>
                        <input type="email" name="email" id="email" required>
                    </div>
                    <div class="input-group">
                        <label for="password">Password:</label>
                        <input type="password" name="password" id="password" required>
                    </div>
                    <button type="submit">Register</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
