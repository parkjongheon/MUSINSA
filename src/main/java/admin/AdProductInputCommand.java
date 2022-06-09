package admin;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.RequestContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdProductInputCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/product/");
		int maxSize = 1024 * 1024 * 20;
		String encoding = "UTF-8";
		
	// 파일 업로드 처리
			MultipartRequest multipartRequest = new MultipartRequest(request,realPath,maxSize,encoding, new DefaultFileRenamePolicy()); 
			
			// 업로드된 파일의 정보를 db에 처리하기 위한 작업
			Enumeration fileNames = multipartRequest.getFileNames();
			
			String originalFileName = "";
			String filesystemname = "";
			
			while(fileNames.hasMoreElements()) {
				String file = (String)fileNames.nextElement();
				
				if(multipartRequest.getOriginalFileName(file)!=null) {
					originalFileName += multipartRequest.getOriginalFileName(file) + "/";
					filesystemname += multipartRequest.getFilesystemName(file) + "/";				
				}
			}
			originalFileName = originalFileName.substring(0,originalFileName.length()-1);
			filesystemname = filesystemname.substring(0,filesystemname.length()-1);
			
			
			// 전송폼의 값들 모두 받아오기
			String brand = multipartRequest.getParameter("brand")==null ? "" : multipartRequest.getParameter("brand");
			String name = multipartRequest.getParameter("product")==null ? "" : multipartRequest.getParameter("product");
			String category = multipartRequest.getParameter("category")==null ? "" : multipartRequest.getParameter("category");
			String tagContent = multipartRequest.getParameter("tagContent")==null ? "" : multipartRequest.getParameter("tagContent");
			int sPrice = multipartRequest.getParameter("sPrice")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("sPrice"));
			int rPrice = multipartRequest.getParameter("rPrice")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("rPrice"));
			int count = multipartRequest.getParameter("count")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("count"));
			
			
			
			String[] ori = originalFileName.split("/");
			String[] fs = filesystemname.split("/");
			
			String fName = ori[1];
			String fSName = fs[1];
			String fContent = ori[0];
			String fSContent = fs[0];
			
			
			AdVO vo = new AdVO();
			vo.setBrand(brand);
			vo.setName(name);
			vo.setCategory(category);
			vo.setsPrice(sPrice);
			vo.setrPrice(rPrice);
			vo.setCount(count);
			vo.setfName(fName);
			vo.setfSName(fSName);
			vo.setfContent(fContent);
			vo.setfSContent(fSContent);
			vo.setTagContent(tagContent);
			
			int pag = multipartRequest.getParameter("pag")==null ? 1 : Integer.parseInt(multipartRequest.getParameter("pag"));
			int pageSize = multipartRequest.getParameter("pageSize")==null ? 15 : Integer.parseInt(multipartRequest.getParameter("pageSize"));
			int part = multipartRequest.getParameter("part")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("part"));
			String item = multipartRequest.getParameter("sitem")==null ? "" : multipartRequest.getParameter("sitem");
			
			
			AdDAO dao = new AdDAO();
			int res = dao.setProductInput(vo);
			
			if(res == 1) {
				request.setAttribute("msg", "등록완료");
			}
			else {
				request.setAttribute("msg", "등록실패");
			}
			request.setAttribute("url", "adminProduct.ad?pag="+pag+"&pageSize="+pageSize+"&part="+part+"&item="+item);
			
	}

}
