package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/optionDelete")
public class OptionDelete extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int opIdx = request.getParameter("opIdx")==null ? 0 : Integer.parseInt(request.getParameter("opIdx"));
		
		AdDAO dao = new AdDAO();
		
		int res = dao.setOptionDelete(opIdx);
		
		String data ="";
		if(res == 1) {
			data="1";
		}
		response.getWriter().write(data);
	}
}
