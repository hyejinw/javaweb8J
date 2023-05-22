package kn_menu;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MenuContentCommand implements MenuInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pageSize = request.getParameter("pageSize")==null ? 24 : Integer.parseInt(request.getParameter("pageSize"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		String part = request.getParameter("part")==null ? "전체" : request.getParameter("part");
		
		Kn_MenuDAO dao = new Kn_MenuDAO();
		
		Kn_MenuVO vo = dao.getMenuContent(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pag", pag);
		request.setAttribute("part", part);
		
		// 메뉴에 달린 댓글들
		ArrayList<Kn_MenuReplyVO> replyVos = dao.getMenuReply(idx);
		request.setAttribute("replyVos", replyVos);
	}

}
