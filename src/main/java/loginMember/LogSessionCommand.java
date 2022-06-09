package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogSessionCommand implements LoginInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		MemDAO dao = new MemDAO();
		
		MemVO vo = dao.session(mid);
		
		HttpSession session = request.getSession();
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sGrade", vo.getGrade());
		session.setAttribute("sMid", mid);

	}

}
