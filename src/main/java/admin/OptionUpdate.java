package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/optionUpdate")
public class OptionUpdate extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int opValue = request.getParameter("opValue")==null ? 0 : Integer.parseInt(request.getParameter("opValue"));
		int opId = request.getParameter("opId")==null ? 0 : Integer.parseInt(request.getParameter("opId"));
		
		AdDAO dao = new AdDAO();
		
		int res = dao.setOptionUpdate(opValue,opId);
		
		String data = "";
		if(res == 1) {
			data = "1";
		}
		response.getWriter().write(data);
	}
}
