package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/optionInput")
public class OptionInput extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String color = request.getParameter("color") == null ? "" : request.getParameter("color");
		String size = request.getParameter("size") == null ? "" : request.getParameter("size");
		int count = request.getParameter("count") == null ? 0 : Integer.parseInt(request.getParameter("count"));
		int index = 0;
		
		if(size.equals("XXL")) {
			index = 1;
		}
		else if(size.equals("XL")) {
			index = 2;
		}
		else if(size.equals("L")) {
			index = 3;
		}
		else if(size.equals("M")) {
			index = 4;
		}
		else if(size.equals("S")) {
			index = 5;
		}
		
		AdDAO dao = new AdDAO();
		AdVO vo = new AdVO();
		
		
		vo.setName(name);
		vo.setColor(color);
		vo.setSize(size);
		vo.setCount(count);
		
		String data = "";
		int res = dao.setOption(vo,index);
		
		if(res == 1) {
			data = "1";
		}
		else {
			data ="no";
		}
		response.getWriter().write(data);
	}
}
