package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DropMemberOkCommand implements LoginInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String) session.getAttribute("sMid");
		
		MemDAO dao = new MemDAO();
		
		int res = dao.dropMemberOk(mid);
		
		if(res == 1 ) {
			session.invalidate();
			request.setAttribute("msg", "dropMemberOk");
			request.setAttribute("url", "main.log");
		}

	}

}
