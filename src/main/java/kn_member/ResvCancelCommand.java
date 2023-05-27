package kn_member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kn_admin.Kn_AdminDAO;

public class ResvCancelCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		Kn_MemberDAO dao = new Kn_MemberDAO();
		
		String res = dao.setResvCancelOk(idx);
		
		response.getWriter().write(res);
		
	}
}
