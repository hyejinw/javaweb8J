package kn_member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PwdFinderOkCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		
		Kn_MemberDAO dao = new Kn_MemberDAO();
		
		String pwd = dao.getPwdFinder(mid, email);
		
		request.setAttribute("pwd", pwd);
		request.setAttribute("mid", mid);
		request.setAttribute("email", email);


	}

}
