package kn_admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kn_member.Kn_MemberVO;
import kn_reservation.Kn_ResvVO;
import kn_store.Kn_StoreVO;

public class AdminContentCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kn_AdminDAO dao = new Kn_AdminDAO();
		
		int memNum = dao.getMemNum();
		int resvNum = dao.getResvNum();
		int storeNum = dao.getStoreNum();
		int menuNum = dao.getMenuNum();
		int menuReplyNum = dao.getMenuReplyNum();
		int storeReplyNum = dao.getStoreReplyNum();

		request.setAttribute("memNum", memNum);
		request.setAttribute("resvNum", resvNum);
		request.setAttribute("storeNum", storeNum);
		request.setAttribute("menuNum", menuNum);
		request.setAttribute("menuReplyNum", menuReplyNum);
		request.setAttribute("storeReplyNum", storeReplyNum);
		
		// 신규 회원 (5명)
		ArrayList<Kn_MemberVO> vos = dao.getStatMemberList();
		request.setAttribute("vos", vos);
		
		// 신규 매장 (5곳)
		ArrayList<Kn_StoreVO> vos2 = dao.getStatStoreList();
		request.setAttribute("vos2", vos2);
		
		// 신규 예약 (5건)
		ArrayList<Kn_ResvVO> vos3 = dao.getStatResvList();
		request.setAttribute("vos3", vos3);
		
	}
}
