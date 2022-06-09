package loginMember;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.AdVO;
import orderList.OrderVO;

public class MyPageCommand implements LoginInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		MemDAO dao = new MemDAO();
		String mid = (String) session.getAttribute("sMid");
		
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		
		int pageSize = request.getParameter("pageSize")==null ? 4 : Integer.parseInt(request.getParameter("pageSize"));
		int totRecCnt = dao.totRecCnt(mid);
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 5;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		
		

		
		
		
		
		
		
		
		String grade = "";
		MemVO vo = dao.getPersonalInfor(mid);
		if(vo.getGrade() == 4) {
			grade = "Platinum";
		}
		else if(vo.getGrade() == 3) {
			grade = "Gold";
		}
		else if(vo.getGrade() == 2) {
			grade = "silver";
		}
		else if(vo.getGrade() == 1) {
			grade = "Bronze";
		}
		else {
			grade = "ADMIN";
		}
		
		ArrayList<OrderVO> ordvos = dao.getMyorderList(mid,startIndexNo,pageSize);
		
		
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totPage", totPage);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		request.setAttribute("curScrStartNo", ordvos.size());
		
		request.setAttribute("ordvos", ordvos);
		request.setAttribute("grade", grade);
		request.setAttribute("vo", vo);
	}

}
