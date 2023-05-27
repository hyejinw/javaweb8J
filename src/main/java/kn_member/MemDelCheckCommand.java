package kn_member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kn_franchise.Kn_FranDAO;

public class MemDelCheckCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int idx = (int) session.getAttribute("sIdx");
		
		Kn_MemberDAO dao = new Kn_MemberDAO();
		// 회원 삭제처리(실제 삭제는 1달 후)
		int res = dao.memDel(idx);
		 
		String msg = "", url="";
		if(res == 1) {
			msg = "그동안 함께 해주셔서 감사했습니다.\\n더욱 행복한 날만 가득하시길 바랍니다😀";
			url = request.getContextPath()+"/";
		}
		else {
			msg = "탈퇴 처리가 완료되지 않았습니다. 재시도해주세요.";
			url = request.getContextPath()+"/MyPage.kn_mem";
		}
		
		session = request.getSession();
		// 세션을 끊는다.
		session.invalidate();
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
	}
}