package kn_menu;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MenuGoodCommand implements MenuInterface {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0: Integer.parseInt(request.getParameter("idx"));
		int menuIdx = request.getParameter("menuIdx")==null ? 0: Integer.parseInt(request.getParameter("menuIdx"));
		
		Kn_MenuDAO dao = new Kn_MenuDAO();
		
		// 글 좋아요 1회 증가시키기("'MenuReplyGood'+고유번호" 값을 객체배열(ArrayList)에 담았다.)
		HttpSession session = request.getSession();
		ArrayList<String> goodIdx = (ArrayList<String>) session.getAttribute("sGoodIdx");
		
		
		// 처음엔 없을 거니까! 만들어주자!
		if(goodIdx == null) {
			goodIdx = new ArrayList<>();
		}
		
		String imsiGoodIdx = "MenuReplyGood" + idx;
		if(!goodIdx.contains(imsiGoodIdx)) {
			dao.setGoodUpdate(idx);      // 게시글 좋아요 올리고
			goodIdx.add(imsiGoodIdx);    // arrayList에 값 추가!!!!
		}
		session.setAttribute("sGoodIdx", goodIdx);
		
		
		// 현재 선택된 메뉴(menuIdx)의 내용을 가져오기
		Kn_MenuVO vo = dao.getMenuContent(menuIdx);
		request.setAttribute("vo", vo);
		
		// 메뉴에 달린 댓글들
		ArrayList<Kn_MenuReplyVO> replyVos = dao.getMenuReply(menuIdx);
		request.setAttribute("replyVos", replyVos);
		
	}

}
