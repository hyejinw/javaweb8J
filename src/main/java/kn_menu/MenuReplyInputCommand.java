package kn_menu;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MenuReplyInputCommand implements MenuInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/kn_menuReply");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";
		
		
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		String m_ReplyPhoto = multi.getFilesystemName("m_ReplyPhoto")== null ? "" : multi.getFilesystemName("m_ReplyPhoto");
	
		int menuIdx = multi.getParameter("menuIdx")== null ? 0 : Integer.parseInt(multi.getParameter("menuIdx"));
		String memMid = multi.getParameter("memMid")== null ? "" :multi.getParameter("memMid");
		String m_ReplyContent = multi.getParameter("m_ReplyContent")== null ? "" :multi.getParameter("m_ReplyContent");
		int m_ReplyRate = multi.getParameter("m_ReplyRate")== null ? 0 : Integer.parseInt(multi.getParameter("m_ReplyRate"));
		String m_ReplyHostIp = multi.getParameter("m_ReplyHostIp")== null ? "" :multi.getParameter("m_ReplyHostIp");

		Kn_MenuReplyVO vo = new Kn_MenuReplyVO();
		vo.setMenuIdx(menuIdx);
		vo.setMemMid(memMid);
		vo.setM_ReplyContent(m_ReplyContent);
		vo.setM_ReplyRate(m_ReplyRate);
		vo.setM_ReplyPhoto(m_ReplyPhoto);
		vo.setM_ReplyHostIp(m_ReplyHostIp);

		Kn_MenuDAO dao = new Kn_MenuDAO();
		String res = dao.setMenuReply(vo);
		
		response.getWriter().write(res);
		
		// 댓글 총 평점 구하기 (1.해당 메뉴에 매겨진 평점 총합, 2. 평점 개수)
		vo = dao.getTotMenuRate(menuIdx);
		
		int menuRate = Math.round(vo.getMenuRateTot() / vo.getMenuRateCnt());
		
		dao.setMenuRate(menuRate, menuIdx);
	}

}
