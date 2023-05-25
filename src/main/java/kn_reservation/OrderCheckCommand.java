package kn_reservation;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class OrderCheckCommand implements ReservInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  	HttpSession session = request.getSession();
  	String memMid = (String)session.getAttribute("sMid");

		int coupon = request.getParameter("coupon")==null ? 0 : Integer.parseInt(request.getParameter("coupon"));
		int storeIdx = request.getParameter("storeIdx")==null ? 0 : Integer.parseInt(request.getParameter("storeIdx"));
		String pickupDate = request.getParameter("pickupDate")==null ? "" : request.getParameter("pickupDate");
		int menuIdx = request.getParameter("menuIdx")==null ? 0 : Integer.parseInt(request.getParameter("menuIdx"));
		
		Kn_ResvDAO dao = new Kn_ResvDAO();
		String res = "";

		ArrayList<Kn_CartVO> vos = dao.getCartList(memMid);
		res = dao.setResvList(vos);
		
		// 쿠폰 고유번호 가져오기 + 값 집어넣기
		if(coupon != 0) {
			int couponIdx = dao.getCouponIdx(memMid, coupon);
			dao.setResvCoupon(couponIdx, storeIdx, pickupDate, menuIdx);
		}
		
		// 장바구니 비우기
		dao.setCartDel(memMid);
		
		response.getWriter().write(res);
	}

}
