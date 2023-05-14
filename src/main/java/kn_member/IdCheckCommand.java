package kn_member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IdCheckCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");

		Kn_MemberDAO dao = new Kn_MemberDAO();
		Kn_MemberVO vo = dao.getMidCheck(mid);
		
		if(vo.getMid() == null) {
			request.setAttribute("res", 1);   // 사용 가능한 아이디
		}
		else {
			request.setAttribute("res", 0);   // 이미 사용 중인 아이디
		}
		request.setAttribute("mid", mid);

	}

}
