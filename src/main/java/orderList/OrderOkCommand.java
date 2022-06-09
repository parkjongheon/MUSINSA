package orderList;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loginMember.MemDAO;
import loginMember.MemVO;
import product.PrdDAO;

public class OrderOkCommand implements OrderInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ordMid = request.getParameter("ordMid") == null ? "" : request.getParameter("ordMid");
		String ordName = request.getParameter("ordName") == null ? "" : request.getParameter("ordName");
		String ordBrandName = request.getParameter("ordBrandName") == null ? "" : request.getParameter("ordBrandName");
		String ordPrdName = request.getParameter("ordPrdName") == null ? "" : request.getParameter("ordPrdName");
		String ordTel = request.getParameter("ordTel") == null ? "" : request.getParameter("ordTel");
		String ordAddress = request.getParameter("ordAddress") == null ? "" : request.getParameter("ordAddress");
		String ordPost = request.getParameter("ordPost") == null ? "" : request.getParameter("ordPost");
		String ordMemo = request.getParameter("ordMemo") == null ? "" : request.getParameter("ordMemo");
		int totPrice = request.getParameter("totPrice") == null ? 0 : Integer.parseInt(request.getParameter("totPrice"));
		int point = request.getParameter("point") == null ? 0 : Integer.parseInt(request.getParameter("point"));
		String prdOption = request.getParameter("prdOption") == null ? "" : request.getParameter("prdOption");
		String prdIdxCount = request.getParameter("prdIdxCount") == null ? "" : request.getParameter("prdIdxCount");
		String pickName = request.getParameter("pickName") == null ? "" : request.getParameter("pickName");
		
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		int sgrade = (int) session.getAttribute("sGrade");
		
		OrderVO orvo = new OrderVO();
		orvo.setMid(ordMid);
		orvo.setSellName(ordName);
		orvo.setPrdBrand(ordBrandName);
		orvo.setPrdName(ordPrdName);
		orvo.setPrdOption(prdOption);
		orvo.setPickName(pickName);
		orvo.setPickTel(ordTel);
		orvo.setPickAddress(ordAddress);
		orvo.setPickPost(ordPost);
		orvo.setPickMemo(ordMemo);
		orvo.setTotPrice(totPrice);
		OrderDAO ordao = new OrderDAO();
		int res2 = ordao.setOrderList(orvo);
		if(res2 == 1) {
			System.out.println("주문 성공");
		}
		MemDAO memdao = new MemDAO();
		MemVO memvo = new MemVO();
		memvo.setMid(ordMid);
		memvo.setPoint(point);
		memvo.setTotPrice(totPrice);	
		int res1 = memdao.orderMemUpdate(memvo);
		if(res1 == 1) {
			System.out.println("적립성공");
		}
		if(sgrade != 0) {
			int grade = 0;
			
			int useTotPrice = memdao.getTotInfo(mid);
			if(useTotPrice >= 300000) {
				grade = 4;
			}
			else if(useTotPrice >= 100000) {
				grade = 3;
			}
			else if(useTotPrice >= 50000) {
				grade = 2;
			}
			else if(useTotPrice >= 0) {
				grade = 1;
			}
			int no = memdao.setGradeUpdate(grade,mid);	
			session.setAttribute("sGrade", grade);
		}
		
		
		
		
		int prdCount = 0;
		OrderDAO dao = new OrderDAO();
		String idxCount [] = prdIdxCount.split("/");
		int res = 0;
		for(int i =0; i<idxCount.length; i++) {
			String[] IdxCountSlide = idxCount[i].split("_");
			prdCount = prdCount + Integer.parseInt(IdxCountSlide[1]);
			
			res =	dao.setCountUpdate(IdxCountSlide[0],IdxCountSlide[1]);
			if(res == 1) {
				System.out.println("재고수정성공");
			}
			else {
				System.out.println("실패");
			}
		}
		
		PrdDAO prddao = new PrdDAO();
		int res3 = prddao.setSellCount(ordPrdName,prdCount);
		
		
		
		if(res == 1 && res1 == 1 && res2 == 1) {
			request.setAttribute("msg", "orderOk");
			request.setAttribute("url", request.getContextPath()+"/orderOkpage.ord");
		}
		else {
			request.setAttribute("msg", "orderNo");
			request.setAttribute("url", request.getContextPath()+"/prdProductMain.prd");
		}
		
	}

}
