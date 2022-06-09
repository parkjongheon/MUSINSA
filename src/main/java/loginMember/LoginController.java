package loginMember;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialException;

import product.GetOut;


@WebServlet("*.log")
public class LoginController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LoginInterface command = null;
		String viewPage = "/WEB-INF";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1 , uri.lastIndexOf("."));	
		HttpSession session = request.getSession();
		int sGrade = session.getAttribute("sGrade")==null? 99 : (int) session.getAttribute("sGrade");
		
		if(com.equals("login")) {
			viewPage +="/login/login.jsp";
		}
		else if(com.equals("logSession")) {
			command = new LogSessionCommand();
			command.execute(request, response);
			viewPage ="/";
		}
		else if(com.equals("main")){
			viewPage ="/";
		}
		else if(com.equals("join")) {
			viewPage +="/join/join.jsp";
		}
		else if(com.equals("joinOk")) {
			command = new JoinOkCommand();
			command.execute(request, response);
			viewPage ="/message/message.jsp";
		}
		else if(com.equals("pwdUpdate")) {
			viewPage +="/myPage/myPagePwdUpdate.jsp";
		}
		else if(com.equals("pwdUpdateOk")) {
			command = new PwdUpdateOkCommand();
			command.execute(request, response);
			viewPage ="/message/message.jsp";
		}
		else if(com.equals("passCheck")) {
			viewPage +="/myPage/myPageCheck.jsp";
		}
		else if(com.equals("idSearch")) {
			viewPage +="/login/idSearch.jsp";
		}
		else if(com.equals("idSearchOk")) {
			viewPage +="/login/idSearchOk.jsp";
		}
		else if(com.equals("pwdSearch")) {
			viewPage +="/login/pwdSearch.jsp";
		}
		else if(com.equals("pwdSearchOk")) {
			viewPage +="/login/pwdSearchOk.jsp";
		}
		else if(sGrade > 4 || sGrade < 0) {
			command = new LogGetOut();
			command.execute(request, response);
			viewPage ="/message/message.jsp";
		}
		else if(com.equals("logOut")) {
			command = new LogOutCommand();
			command.execute(request, response);
			viewPage ="/message/message.jsp";
		}
		else if(com.equals("myPage")) {
			command = new MyPageCommand();
			command.execute(request, response);
			viewPage +="/myPage/myPage.jsp";
		}
		else if(com.equals("infoUpdate")) {
			command = new InfoUpdateCommand();
			command.execute(request, response);
			viewPage +="/myPage/myPageInfoUpdate.jsp";
		}
		else if(com.equals("infoUpdateOk")) {
			command = new InfoUpdateOkCommand();
			command.execute(request, response);
			viewPage ="/message/message.jsp";
		}
		else if(com.equals("dropMember")) {
			viewPage +="/login/dropMember.jsp";
		}
		else if(com.equals("dropMemberOk")) {
			command = new DropMemberOkCommand();
			command.execute(request, response);
			viewPage ="/message/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
