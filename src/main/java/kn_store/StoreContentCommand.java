package kn_store;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kn_menu.Kn_MenuReplyVO;
import kn_menu.Kn_MenuVO;

public class StoreContentCommand implements StoreInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		Kn_StoreDAO dao = new Kn_StoreDAO();
		
		Kn_StoreVO vo = dao.getStoreContent(idx);
		
		request.setAttribute("vo", vo);
		
		// 매장에 달린 댓글들
		ArrayList<Kn_StoreReplyVO> replyVos = dao.getStoreReply(idx);
		request.setAttribute("replyVos", replyVos);
	}

}
