package product;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PrdProductCommand implements PrdInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		PrdDAO dao = new PrdDAO();
		
		PrdVO vo = dao.prdProduct(idx);
		String tag = vo.getTagContent();
		
		String []tagContent = tag.split("#");
		
		request.setAttribute("tagContent", tagContent);
		request.setAttribute("vo", vo);
		
		ArrayList<PrdVO> vos = dao.prdProductOption(idx);
		
		
		
		
		if(vos.size() > 1) {
			request.setAttribute("vos", vos);			
		}
		else {
			ArrayList<PrdVO> cvos = dao.prdProductOptionColor(idx);		
			request.setAttribute("cvos", cvos);	
			PrdVO cvo = dao.prdProductColor(idx);
			request.setAttribute("cvo", cvo);	
		}

	}

}
