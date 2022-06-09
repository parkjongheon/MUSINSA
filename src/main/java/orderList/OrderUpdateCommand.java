package orderList;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class OrderUpdateCommand implements OrderInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int info = request.getParameter("info")==null ? 0 : Integer.parseInt(request.getParameter("info"));
		
		OrderDAO dao = new OrderDAO();
		
		int res = dao.setOrderUpdate(idx,info);
		
		String data ="";
		
		if(res == 1) {
			data = "1";
		}
		
		response.getWriter().write(data);
	}

}
