package kn_store;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kn_menu.Kn_MenuDAO;
import kn_menu.Kn_MenuReplyVO;

public class StoreReplyInputCommand implements StoreInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/kn_storeReply");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";
		
		
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		String s_ReplyPhoto = multi.getFilesystemName("s_ReplyPhoto")== null ? "" : multi.getFilesystemName("s_ReplyPhoto");
	
		int storeIdx = multi.getParameter("storeIdx")== null ? 0 : Integer.parseInt(multi.getParameter("storeIdx"));
		String memMid = multi.getParameter("memMid")== null ? "" :multi.getParameter("memMid");
		String s_ReplyContent = multi.getParameter("s_ReplyContent")== null ? "" :multi.getParameter("s_ReplyContent");
		int s_ReplyRate = multi.getParameter("s_ReplyRate")== null ? 0 : Integer.parseInt(multi.getParameter("s_ReplyRate"));
		String s_ReplyHostIp = multi.getParameter("s_ReplyHostIp")== null ? "" :multi.getParameter("s_ReplyHostIp");

		Kn_StoreReplyVO vo = new Kn_StoreReplyVO();
		vo.setStoreIdx(storeIdx);
		vo.setMemMid(memMid);
		vo.setS_ReplyContent(s_ReplyContent);
		vo.setS_ReplyRate(s_ReplyRate);
		vo.setS_ReplyPhoto(s_ReplyPhoto);
		vo.setS_ReplyHostIp(s_ReplyHostIp);

		Kn_StoreDAO dao = new Kn_StoreDAO();
		String res = dao.setStoreReply(vo);
		
		response.getWriter().write(res);
		
		// 댓글 총 평점 구하기 (1.해당 메뉴에 매겨진 평점 총합, 2. 평점 개수)
		vo = dao.getTotStoreRate(storeIdx);
		
		int storeRate = Math.round(vo.getStoreRateTot() / vo.getStoreRateCnt());
		
		dao.setStoreRate(storeRate, storeIdx);

	}

}
