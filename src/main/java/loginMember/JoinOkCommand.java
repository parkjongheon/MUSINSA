package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class JoinOkCommand implements LoginInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("midOk")==null ? "1" : request.getParameter("midOk");
		String pwd = request.getParameter("jpwd")==null ? "2" : request.getParameter("jpwd");
		String name = request.getParameter("name")==null ? "3" : request.getParameter("name");
		String nickName = request.getParameter("nickNameOk")==null ? "4" : request.getParameter("nickNameOk");
		String gender  = request.getParameter("gender")==null ? "5" : request.getParameter("gender");
		String tel = request.getParameter("tel")==null ? "6" : request.getParameter("tel");
		String address = request.getParameter("address")==null ? "7" : request.getParameter("address");
		String post = request.getParameter("postcode")==null ? "8" : request.getParameter("postcode");
		String email = request.getParameter("emailOk")==null ? "9" : request.getParameter("emailOk");
		String birthDay = request.getParameter("birthday")==null ? "10" : request.getParameter("birthday");
	
		
		// 비밀번호 암호화처리(sha256)
    SecurityUtil security = new SecurityUtil();
    pwd =  security.encryptSHA256(pwd);
    MemDAO dao = new MemDAO();
    MemVO vo = new MemVO();
    vo.setMid(mid);
    vo.setPwd(pwd);
    vo.setName(name);
    vo.setNickName(nickName);
    vo.setGender(gender);
    vo.setTel(tel);
    vo.setAddress(address);
    vo.setPost(post);
    vo.setEmail(email);
    vo.setBirthday(birthDay);
    System.out.println(vo);
    int res = dao.joinOk(vo);
    
    if(res == 1) {
    	request.setAttribute("msg", "joinOk");
    	
    }
    else {
    	request.setAttribute("msg", "joinNo");
    	
    }
		request.setAttribute("url", "login.log");
	}


}
