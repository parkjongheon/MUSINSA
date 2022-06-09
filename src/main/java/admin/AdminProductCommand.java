package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.PrdDAO;
import product.PrdVO;

public class AdminProductCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		AdDAO dao = new AdDAO();
		
		ArrayList<AdVO> vos = new ArrayList<AdVO>();
		vos = dao.getBrandList();
		request.setAttribute("vos", vos);
		
		
	}

}
