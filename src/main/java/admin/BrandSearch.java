package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/brandSearch")
public class BrandSearch extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bSearch = request.getParameter("brandSearch")==null ? "" : request.getParameter("brandSearch");
		
		
		AdDAO dao = new AdDAO();
		
		String categorys = dao.getCategoryList(bSearch);
		
		response.getWriter().print(categorys);
		
	}
}
