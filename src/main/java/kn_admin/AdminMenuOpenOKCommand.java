package kn_admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminMenuOpenOKCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String sw = request.getParameter("sw")==null ? "NO" : request.getParameter("sw");
		
		Kn_AdminDAO dao = new Kn_AdminDAO();
		String res = dao.setMenuOpenClose(idx, sw);
		
		response.getWriter().write(res);

	}

}
