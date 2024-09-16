import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BookDAO {
    public boolean addBook(Book book) {
        boolean status = false;
        String sql = "INSERT INTO books (bookCode, bookName, authorName, noOfCopies, additionalInfo) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, book.getBookCode());
            ps.setString(2, book.getBookName());
            ps.setString(3, book.getAuthorName());
            ps.setInt(4, book.getNoOfCopies());
            ps.setString(5, book.getAdditionalInfo());

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                status = true;
            }
        } 
        catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
        return status;
    }
}
