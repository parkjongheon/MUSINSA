package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/idTelSearchOk")
public class IdTelSearchOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name") ==null ? "" : request.getParameter("name");
		String tel = request.getParameter("tel") == null ? "" : request.getParameter("tel");
		
		MemDAO dao = new MemDAO();
		MemVO vo = dao.idSearch(name,tel);
		
		String data = "";
		if(vo.getMid() == null) {
			data = "1";
		}
		else {
			data = vo.getMid();
		}
		response.getWriter().write(data);
	}
}
