

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addBook
 */
@WebServlet("/addBook")
public class addBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addBook() {
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
		String bookCode = request.getParameter("bookCode");
        String bookName = request.getParameter("bookName");
        String authorName = request.getParameter("authorName");
        int noOfCopies = Integer.parseInt(request.getParameter("noOfCopies"));
        String additionalInfo = request.getParameter("additionalInfo");

        Book book = new Book();
        book.setBookCode(bookCode);
        book.setBookName(bookName);
        book.setAuthorName(authorName);
        book.setNoOfCopies(noOfCopies);
        book.setAdditionalInfo(additionalInfo);

        BookDAO bookDAO = new BookDAO();
        boolean result = bookDAO.addBook(book);

        if (result) {
            response.sendRedirect("success.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
	}

}
