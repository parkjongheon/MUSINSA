package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PrdOptionSearchCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int sw = request.getParameter("sw")==null ? 0 : Integer.parseInt(request.getParameter("sw"));
		
		
		AdDAO dao = new AdDAO();
		
		AdVO vo = dao.getPrdOption(idx);
		request.setAttribute("vo", vo);
		
		ArrayList<AdVO> vos = dao.getPrdOptionAll(idx);
		request.setAttribute("vos", vos);
		request.setAttribute("sw", sw);
		request.setAttribute("idx", idx);
		
		
	}

}
