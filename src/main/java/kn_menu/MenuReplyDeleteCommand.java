package kn_menu;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MenuReplyDeleteCommand implements MenuInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int replyIdx = request.getParameter("replyIdx")==null? 0: Integer.parseInt(request.getParameter("replyIdx"));
		int menuIdx = request.getParameter("menuIdx")==null? 0: Integer.parseInt(request.getParameter("menuIdx"));
		
		Kn_MenuDAO dao = new Kn_MenuDAO();
		String res = dao.setReplyDelete(replyIdx);
		
		response.getWriter().write(res);
		
		
		// MenuReplyInputCommand에도 있는 내용
		// 댓글 총 평점 구하기 (1.해당 메뉴에 매겨진 평점 총합, 2.평점 개수)  == 댓글을 삭제하면 평점도 바뀌는 게 맞다.
		Kn_MenuReplyVO vo = dao.getTotMenuRate(menuIdx);
		int menuRate;  // java.lang.ArithmeticException: / by zero 오류 때문!  0으로 나누기는 안 된다.
		
		if(vo.getMenuRateCnt() != 0) {
			menuRate = Math.round(vo.getMenuRateTot() / vo.getMenuRateCnt());
		}
		else {
			menuRate = 0;
		}
		
		dao.setMenuRate(menuRate, menuIdx);
	}
}
