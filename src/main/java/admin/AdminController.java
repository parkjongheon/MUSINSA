package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loginMember.LogGetOut;


@WebServlet("*.ad")
public class AdminController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPage = "/WEB-INF";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1 , uri.lastIndexOf("."));
		
		HttpSession session = request.getSession();
		int sGrade = session.getAttribute("sGrade")==null? 99 : (int) session.getAttribute("sGrade");
		
		if(sGrade != 0) {
			command = new adGetOut();
			command.execute(request, response);
			viewPage ="/message/message.jsp";
		}
		else if(com.equals("adminMain")) {
			command = new AdminMain();
			command.execute(request, response);
			viewPage +="/admin/adminMain.jsp";
		}
		else if(com.equals("adminProductMain")) {
			command = new AdminProductMainCommand();
			command.execute(request, response);
			viewPage +="/admin/adminProductMain.jsp";
		}
		else if(com.equals("adminProduct")) {
			command = new AdminProductCommand();
			command.execute(request, response);
			viewPage +="/admin/adminProduct.jsp";
		}
		else if(com.equals("adProductInput")) {
			command = new AdProductInputCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("adPrdBrandInput")) {
			command = new AdPrdBrandInputCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("prdOptionSearch")) {
			command = new PrdOptionSearchCommand();
			command.execute(request, response);
			viewPage +="/admin/prdOptionSearch.jsp";
		}
		else if(com.equals("adOrderList")) {
			command = new AdOrderListCommand();
			command.execute(request, response);
			viewPage +="/admin/adminOrderMain.jsp";
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
