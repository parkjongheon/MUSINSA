package product;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loginMember.MemDAO;
import loginMember.MemVO;

public class ProductSellCommand implements PrdInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tot = request.getParameter("tot")==null ? "" : request.getParameter("tot"); 
		
		String[] totprd = tot.split("/");
		request.setAttribute("totprd", totprd);
		
		// 사용자 정보
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		MemDAO memdao = new MemDAO();
		MemVO memvo = memdao.getPersonalInfor(mid);
		request.setAttribute("memvo", memvo);
		
		// 상품정보
		int prdIdx = request.getParameter("prdIdx")==null ? 0 :Integer.parseInt(request.getParameter("prdIdx"));
		PrdDAO prddao = new PrdDAO();
		PrdVO prdvo = prddao.prdProduct(prdIdx);
		
		System.out.println(prdIdx);
		request.setAttribute("prdvo", prdvo);
	}
}
