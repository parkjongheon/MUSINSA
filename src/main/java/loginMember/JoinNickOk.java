package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/joinNickOk")
public class JoinNickOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName");
		
		MemDAO dao = new MemDAO();
		
		int res = dao.nickOk(nickName);
		
		String data = "";
		if(res == 1) {
			data = "1";
		}
		else {
			data = nickName;
		}
		response.getWriter().write(data);
	}
}
