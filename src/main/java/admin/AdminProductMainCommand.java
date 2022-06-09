package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminProductMainCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdDAO dao = new AdDAO();
		int part = request.getParameter("part")==null ? 0 : Integer.parseInt(request.getParameter("part"));
		String item = request.getParameter("item")==null ? "" : request.getParameter("item");
		if(part == 3 || part == 1) {
			item = "%"+item+"%";
		}
		
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		
		int pageSize = request.getParameter("pageSize")==null ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int totRecCnt = dao.totRecCnt(part,item);
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 5;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		
		ArrayList<AdVO> vos = dao.getAllProduct(startIndexNo,pageSize,part,item);
		
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totPage", totPage);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		request.setAttribute("curScrStartNo", vos.size());
		
		request.setAttribute("vos", vos);
		
	}

}
