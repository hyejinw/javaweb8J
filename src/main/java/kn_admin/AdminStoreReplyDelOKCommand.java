package kn_admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kn_store.Kn_StoreDAO;
import kn_store.Kn_StoreReplyVO;

public class AdminStoreReplyDelOKCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int replyIdx = request.getParameter("idx")==null? 0: Integer.parseInt(request.getParameter("idx"));
		int storeIdx = request.getParameter("storeIdx")==null? 0: Integer.parseInt(request.getParameter("storeIdx"));
		
		Kn_StoreDAO dao = new Kn_StoreDAO();
		String res = dao.setReplyDelete(replyIdx);
		
		response.getWriter().write(res);
		
		
		// StoreReplyInputCommand에도 있는 내용
		// 댓글 총 평점 구하기 (1.해당 메뉴에 매겨진 평점 총합, 2.평점 개수)  == 댓글을 삭제하면 평점도 바뀌는 게 맞다.
		Kn_StoreReplyVO vo = dao.getTotStoreRate(storeIdx);
		int menuRate;  // java.lang.ArithmeticException: / by zero 오류 때문!  0으로 나누기는 안 된다.
		
		if(vo.getStoreRateCnt() != 0) {
			menuRate = Math.round(vo.getStoreRateCnt() / vo.getStoreRateCnt());
		}
		else {
			menuRate = 0;
		}
		
		dao.setStoreRate(menuRate, storeIdx);
	}

}
