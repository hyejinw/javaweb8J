package kn_reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ResvCartInputCommand implements ReservInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pickupDate = request.getParameter("pickupDate")==null ? "" : request.getParameter("pickupDate");
		int storeIdx = request.getParameter("storeIdx")==null ? 0 :  Integer.parseInt(request.getParameter("storeIdx"));
		int menuIdx = request.getParameter("menuIdx")==null ? 0 :  Integer.parseInt(request.getParameter("menuIdx"));
		int price = request.getParameter("price")==null ? 0 :  Integer.parseInt(request.getParameter("price"));
		int menuCnt = request.getParameter("amount")==null ? 0 :  Integer.parseInt(request.getParameter("amount"));
		
		// 총 메뉴 가격
		int menuPrice = price * menuCnt;
		
		
		HttpSession session = request.getSession();
		String memMid = (String)session.getAttribute("sMid");
		
		Kn_ResvDAO dao = new Kn_ResvDAO();
		
		Kn_CartVO vo = new Kn_CartVO();
		vo.setMemMid(memMid);
		vo.setStoreIdx(storeIdx);
		vo.setMenuIdx(menuIdx);
		vo.setMenuCnt(menuCnt);
		vo.setMenuPrice(menuPrice);
		vo.setPickupDate(pickupDate);
		
		String res = "";
		// 이미 장바구니에 담긴 같은 상품(같은 아이디, 같은 매장, 같은 예약 시간)이 있는지 조회
		Kn_CartVO vo2 = dao.getCartCheck(menuIdx, memMid, storeIdx, pickupDate);
		
		if(vo2.getMemMid() != null) {
			res = dao.setDoubleCart(vo, vo2.getIdx());
		}
		else {
			res = dao.setCart(vo);
		}
		
		response.getWriter().write(res);
	}

}
