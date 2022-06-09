package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/joinEmailOk")
public class JoinEmailOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email1 = request.getParameter("email1")==null ? "1" : request.getParameter("email1");
		String email2 = request.getParameter("email2")==null ? "2" : request.getParameter("email2");
		
		String email = email1+"@"+email2;
		MemDAO dao = new MemDAO();
		
		int res = dao.joinEmailOk(email);
		
		String data = ""; 
		if(res == 1) {
			data = "1";
		}
		else {
			data = email;
		}
		response.getWriter().write(data);
	}
}
