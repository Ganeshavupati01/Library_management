import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public login() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                String role = rs.getString("role");
                session.setAttribute("user", email);
                session.setAttribute("pin", rs.getString("pin"));
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("phone", rs.getString("phone"));
                session.setAttribute("role", role);

                if ("USER".equalsIgnoreCase(role)) {
                    response.sendRedirect("home1.jsp");
                } else if ("ADMIN".equalsIgnoreCase(role)) {
                    response.sendRedirect("home2.jsp");
                } else {
                    response.getWriter().println("Invalid role!");
                }
            } else {
                response.getWriter().println("Invalid email or password!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred while processing your request.");
        }
    }
}
