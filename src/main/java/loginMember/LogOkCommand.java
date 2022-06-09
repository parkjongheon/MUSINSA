package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

@WebServlet("/logOk")
public class LogOkCommand extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String idSave = request.getParameter("idSave")==null ? "off" : "on";
		
		
		
		Cookie cookieMid = new Cookie("cMid", mid); 
		if(idSave.equals("on")) {
			cookieMid.setMaxAge(60*60*24*7);	
		}
		else {
			cookieMid.setMaxAge(0);	
		}
		response.addCookie(cookieMid);
		
		SecurityUtil securityUtil = new SecurityUtil();
		pwd = securityUtil.encryptSHA256(pwd);
		
		MemDAO dao = new MemDAO();
		
		MemVO vo =  dao.LoginOk(mid, pwd);
		
		String data = "";
		if(vo.getNickName() ==  null) {
			data = "1";
		}
		else {
			data = mid;
		}
		response.getWriter().write(data);
	}
}
