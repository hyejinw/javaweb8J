package kn_reservation;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CartCommand implements ReservInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String memMid = (String)session.getAttribute("sMid");
		

		Kn_ResvDAO dao = new Kn_ResvDAO();
		ArrayList<Kn_CartVO> vos = dao.getCartList(memMid);
		
		// 총 합계 구하기
		int totMenuPrice = dao.getCartTotPrice(memMid);
		request.setAttribute("vos", vos);
		request.setAttribute("totMenuPrice", totMenuPrice);
		
	}

}
