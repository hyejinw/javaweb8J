package kn_admin;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminMenuDelOKCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String menuPhoto = request.getParameter("menuPhoto")==null ? "" : request.getParameter("menuPhoto");
		System.out.println("menuPhoto : " + menuPhoto);
		
		String realPath = request.getServletContext().getRealPath("/images/kn_menu/");
	
				
		Kn_AdminDAO dao = new Kn_AdminDAO();
		
		String res = dao.setMenuDelOk(idx);

		File file = new File(realPath + menuPhoto);
		
		// 파일 삭제!
		if(res.equals("1")) {
			if(file.exists()) {
				file.delete();
				res = "1";
			}
			else {
				res = "0";
			}
		}
		response.getWriter().write(res);

	}

}
