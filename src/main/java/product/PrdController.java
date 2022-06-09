package product;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loginMember.LogOutCommand;

@WebServlet("*.prd")
public class PrdController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrdInterface command = null;
		String viewPage = "/WEB-INF";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1 , uri.lastIndexOf("."));
		HttpSession session = request.getSession();
		int sGrade = session.getAttribute("sGrade")==null? 99 : (int) session.getAttribute("sGrade");
		
		if(com.equals("prdProductMain")) {
			command = new PrdProductMainCommand();
			command.execute(request, response);
			viewPage += "/product/prdMain.jsp";
		}
		else if(com.equals("prdProduct")){
			command = new PrdProductCommand();
			command.execute(request, response);
			viewPage += "/product/prdProduct.jsp";
		}
		else if(sGrade > 4 || sGrade < 0){
			command = new GetOut();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("productSell")){
			command = new ProductSellCommand();
			command.execute(request, response);
			viewPage += "/product/prdProductSell.jsp";
		}
	
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
