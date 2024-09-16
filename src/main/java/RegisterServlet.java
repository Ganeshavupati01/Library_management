

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		
		 String role = request.getParameter("role");
		 String name = request.getParameter("name");
	        String pin = request.getParameter("pin");
	        long phone = Long.parseLong(request.getParameter("phone"));
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");

	        User user = new User();
	        user.setRole(role);
	        user.setName(name);
	        user.setPin(pin);
	        user.setPhone(phone);
	        user.setEmail(email);
	        user.setPassword(password);

	        UserDao userDao = new UserDao();
	        boolean isInserted = userDao.insertUser(user);

	        if (isInserted) {
	        	response.sendRedirect("login.jsp");
	            
	        } else {
	            response.getWriter().println("User registration failed!");
	        }
		
		
		
	}

}
