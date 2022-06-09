package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/pwdSearch")
public class PwdSearch extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String tel = request.getParameter("tel")==null ? "" : request.getParameter("tel");
		
		
		MemDAO dao = new MemDAO();
		
		int res = dao.pwdSearch(mid, email, name, tel);
		String data = "";
		if(res == 1) {
			data = mid;
		}
		else {
			data ="1";
		}
		response.getWriter().write(data);
	}
}
