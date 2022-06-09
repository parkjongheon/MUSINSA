package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

@WebServlet("/pwdSearchUpdate")
public class PwdSearchUpdate extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		SecurityUtil securityUtil = new SecurityUtil();
		pwd = securityUtil.encryptSHA256(pwd);
		
		MemDAO dao = new MemDAO();
		int res = dao.pwdUpdate(mid,pwd);
		
		String data = "";
		if(res == 1) {
			data = mid;
		}
		else {
			data = "1";
		}
		response.getWriter().write(data);
	}
}
