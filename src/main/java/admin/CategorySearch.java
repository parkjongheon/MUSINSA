package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/categorySearch")
public class CategorySearch extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String brandSearch = request.getParameter("brandSearch")==null ? "" : request.getParameter("brandSearch");
		String categorySearch = request.getParameter("categorySearch")==null ? "" : request.getParameter("categorySearch");
		
		System.out.println(categorySearch);
		AdDAO dao = new AdDAO();
		
		String datas = dao.getItemList(brandSearch , categorySearch);
		
		
		response.getWriter().print(datas);
	}
}
