package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/brandCheck")
public class BrandCheck extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String brand = request.getParameter("brand")==null ? "" : request.getParameter("brand");
		
		AdDAO dao = new AdDAO();
		
		int res = dao.brandCheck(brand);
		
		if(res == 1) {
			response.getWriter().write(brand);
		}
		else {
			response.getWriter().write("1");
		}
	}
}
