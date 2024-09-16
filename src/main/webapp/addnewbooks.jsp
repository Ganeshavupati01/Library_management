<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Book</title>
    <link rel="stylesheet" type="text/css" href="book_form_style.css">
</head>
<body>
    <div class="form-container">
        <h2>Add New Book</h2>
        <form action="addBook" method="post">
            <label for="bookCode">Book Code:</label>
            <input type="text" id="bookCode" name="bookCode" required>

            <label for="bookName">Book Name:</label>
            <input type="text" id="bookName" name="bookName" required>

            <label for="authorName">Author Name:</label>
            <input type="text" id="authorName" name="authorName" required>

            <label for="noOfCopies">No Of Copies:</label>
            <input type="number" id="noOfCopies" name="noOfCopies" required>

            <label for="additionalInfo">Additional Info:</label>
            <textarea id="additionalInfo" name="additionalInfo"></textarea>

            <input type="submit" value="Add Book">
        </form>
    </div>
</body>
</html>
