
// UserDao.java
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserDao {
    public boolean insertUser(User user) {
        String sql = "INSERT INTO users (role, name, pin, phone, email, password) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getRole());
            ps.setString(2, user.getName());
            ps.setString(3, user.getPin());
            ps.setString(4, String.valueOf(user.getPhone())); // Convert long to string
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getPassword());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
