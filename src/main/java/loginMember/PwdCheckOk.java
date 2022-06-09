package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

@WebServlet("/pwdCheckOk")
public class PwdCheckOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String) session.getAttribute("sMid");
		
		String pwd = request.getParameter("pwd");
		
		SecurityUtil securityUtil = new SecurityUtil();
		pwd = securityUtil.encryptSHA256(pwd);
		
		MemDAO dao = new MemDAO();
		
		MemVO vo = dao.LoginOk(mid, pwd);
		
		String data ="";
		if(vo.getNickName() == null) {
			data = "2";
		}
		else {
			data ="1";
		}
		response.getWriter().write(data);
	}
}
