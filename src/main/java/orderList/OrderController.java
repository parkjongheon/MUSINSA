package orderList;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loginMember.LogGetOut;


@SuppressWarnings("serial")
@WebServlet("*.ord")
public class OrderController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		OrderInterface command = null;
		String viewPage = "/WEB-INF";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1 , uri.lastIndexOf("."));
		
		HttpSession session = request.getSession();
		int sGrade = session.getAttribute("sGrade")==null? 99 : (int) session.getAttribute("sGrade");
		
		if(sGrade > 4 || sGrade < 0) {
			command = new ordGetOut();
			command.execute(request, response);
			viewPage ="/message/message.jsp";
		}
		else if(com.equals("orderOk")) {
			command = new OrderOkCommand();
			command.execute(request, response);
			viewPage ="/message/message.jsp";
		}
		else if(com.equals("orderOkpage")){
			viewPage +="/product/orderOkpage.jsp";
		}
		else if(com.equals("orderUpdate")){
			command = new OrderUpdateCommand();
			command.execute(request, response);
			return;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
