package kn_member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kn_reservation.Kn_CouponVO;
import kn_reservation.Kn_ResvDAO;
import kn_reservation.Kn_ResvVO;

public class MyPageCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("sMid");

		Kn_MemberDAO dao = new Kn_MemberDAO();
		Kn_MemberVO vo = dao.getMidCheck(mid);
		request.setAttribute("vo", vo);
		
		
		Kn_ResvDAO dao2 = new Kn_ResvDAO();
		ArrayList<Kn_CouponVO> vos = dao2.getCouponList(mid);
		ArrayList<Kn_ResvVO> vos2 = dao2.getResvList(mid);
		
		request.setAttribute("vos", vos);
		request.setAttribute("vos2", vos2);
	}

}
