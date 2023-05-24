package kn_reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CartDelCommand implements ReservInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String memMid = (String) session.getAttribute("sMid");

		Kn_ResvDAO dao = new Kn_ResvDAO();
		String res = dao.setCartDel(memMid);
	}

}
