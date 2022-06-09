package loginMember;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class PwdUpdateOkCommand implements LoginInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String) session.getAttribute("sMid");
		
		String pwd = request.getParameter("upwd")==null ? "" :  request.getParameter("upwd");
		
		SecurityUtil security = new SecurityUtil();
    pwd =  security.encryptSHA256(pwd);
    
    MemDAO dao = new MemDAO();
    int res = dao.pwdUpdate(mid,pwd);
    
    if(res != 1) {
    	request.setAttribute("msg","pwdSearchNo");
    	request.setAttribute("url", request.getContextPath()+"/myPage.log");
    }
    else {
    	session.invalidate();
    	request.setAttribute("msg","pwdSearchOk");
    	request.setAttribute("url", request.getContextPath()+"/login.log");     	
    }
	}

}
