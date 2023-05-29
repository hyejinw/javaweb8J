package kn_member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IdFinderOkCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String tel = request.getParameter("tel")==null ? "" : request.getParameter("tel");
		
		Kn_MemberDAO dao = new Kn_MemberDAO();
		
		String mid = dao.getIdFinder(email, tel);
		
		request.setAttribute("mid", mid);
		request.setAttribute("email", email);
		request.setAttribute("tel", tel);

	}

}
