package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/idEmailSearchOk")
public class IdEmailSearchOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		
		MemDAO dao = new MemDAO();
		
		
		String data = "";
		
		MemVO vo = dao.idEmailSearch(email);
		
		if(vo.getMid() == null) {
			data = "1";
		}
		else {
			data = vo.getMid();
		}
		response.getWriter().write(data);
	}
}
