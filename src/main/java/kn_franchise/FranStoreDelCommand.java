package kn_franchise;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FranStoreDelCommand implements FranInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memIdx = request.getParameter("memIdx")== null ? 0 : Integer.parseInt(request.getParameter("memIdx"));
		
		Kn_FranDAO dao = new Kn_FranDAO();
		// 매장 삭제처리(실제 삭제는 1달 후)
		int res = dao.franStoreDel(memIdx);
		int res2 = 0;
		
		// 매장회원 삭제처리(실제 삭제는 1달 후)
		if(res == 1) {
			res2 = dao.franMemDel(memIdx);
		}
		 
		String msg = "", url="";
		if(res2 == 1) {
			msg = "그동안 함께 해주셔서 감사했습니다.\\n더욱 행복한 날만 가득하시길 바랍니다😀";
			url = request.getContextPath()+"/";
		}
		else {
			msg = "삭제 처리가 완료되지 않았습니다. 재시도해주세요.";
			url = request.getContextPath()+"/FranStore.kn_fr";
		}
		
		HttpSession session = request.getSession();
		// 세션을 끊는다.
		session.invalidate();
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
	}


}
