package kn_reservation;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class OrderCommand implements ReservInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String memMid = (String)session.getAttribute("sMid");

		Kn_ResvDAO dao = new Kn_ResvDAO();
		
		ArrayList<Kn_CartVO> vos = dao.getCartList(memMid);
		request.setAttribute("vos", vos);
		
		int getCartTotPrice = dao.getCartTotPrice(memMid);
		request.setAttribute("getCartTotPrice", getCartTotPrice);
		
		ArrayList<Kn_CouponVO> vos2 = dao.getCouponList(memMid);
		request.setAttribute("vos2", vos2);
		
//		// 이거 안 쓸 듯!
//		ArrayList<Kn_CartMenuVO> vos3 = dao.getCartMenu(memMid);
//		request.setAttribute("vos3", vos3);
//		
	}

}
