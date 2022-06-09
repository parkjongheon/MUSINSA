package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/joinIdOk")
public class JoinIdOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		MemDAO dao = new MemDAO();
		
		int res = dao.joinIdOk(mid);
		
		
		String data = "";
		if(res == 1) {
			data = "1";
		}
		else {
			data = mid;
		}
		response.getWriter().write(data);
	}
}
