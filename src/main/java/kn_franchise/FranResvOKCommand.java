package kn_franchise;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kn_admin.Kn_AdminDAO;

public class FranResvOKCommand implements FranInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		Kn_FranDAO dao = new Kn_FranDAO();
		
		String res = dao.setResvOk(idx);
		
		response.getWriter().write(res);
		
	}


}
