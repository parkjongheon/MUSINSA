package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class InfoUpdateCommand implements LoginInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String) session.getAttribute("sMid");
		
		MemDAO dao = new MemDAO();
		
		MemVO vo = dao.getPersonalInfor(mid);
		
		String [] email = vo.getEmail().split("@");
		String email1 = email[0];
		String email2 = email[1];
		
		String [] tel = vo.getTel().split("-");
		String tel1 = tel[0];
		String tel2 = tel[1];
		String tel3 = tel[2];
		
		String [] address = vo.getAddress().split("/");
		String roadAddress = address[0];
		String detailAddress = address[1];
		String extraAddress = address[2];
		
		request.setAttribute("vo", vo);
		request.setAttribute("email1", email1);
		request.setAttribute("email2", email2);
		request.setAttribute("tel1", tel1);
		request.setAttribute("tel2", tel2);
		request.setAttribute("tel3", tel3);
		request.setAttribute("roadAddress", roadAddress);
		request.setAttribute("detailAddress", detailAddress);
		request.setAttribute("extraAddress", extraAddress);

	}

}
