package kn_member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("sName");
		
		session.invalidate();
		request.setAttribute("msg", name+"님 로그아웃 되었습니다.");
		request.setAttribute("url", request.getContextPath() + "/");
		
	}

}
