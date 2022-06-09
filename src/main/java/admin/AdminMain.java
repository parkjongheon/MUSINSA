package admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loginMember.MemDAO;
import loginMember.MemVO;

public class AdminMain implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		int grade = (int) session.getAttribute("sGrade");
		
		PrintWriter out =  new PrintWriter(System.out);
		
		if(grade != 0) {
			out.println("<script>");
			out.println("alert('접근불가');");
			out.println("location.href='"+request.getContextPath()+"/main.log';");
			out.println("</script>");
			return;
		}
		
		MemDAO dao = new MemDAO();
		
		int prdCount = dao.prdCount();
		int userCount = dao.userCount();
		int delUserCount = dao.delUserCount();
		int orderCount = dao.orderCount(1);
		int orderAllCount = dao.orderCount(0);
		
		
		// 유저리스트 페이징처리
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		
		
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		int totRecCnt = dao.userCount();
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		ArrayList<MemVO> vos = dao.getAdInfor(startIndexNo,pageSize);
		
		
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", vos.size());
		
		request.setAttribute("orderAllCount", orderAllCount);
		request.setAttribute("orderCount", orderCount);
		request.setAttribute("vos", vos);
		request.setAttribute("prdCount", prdCount);		
		request.setAttribute("userCount", userCount);
		request.setAttribute("delUserCount", delUserCount);
	}
}
