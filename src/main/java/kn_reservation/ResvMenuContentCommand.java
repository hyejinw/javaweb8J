package kn_reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kn_menu.Kn_MenuDAO;
import kn_menu.Kn_MenuVO;

public class ResvMenuContentCommand implements ReservInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pickupDate = request.getParameter("pickupDate")==null ? "" : request.getParameter("pickupDate");
		int storeIdx = request.getParameter("storeIdx")==null ? 0 : Integer.parseInt(request.getParameter("storeIdx"));
		int menuIdx = request.getParameter("menuIdx")==null ? 0 : Integer.parseInt(request.getParameter("menuIdx"));
		
		request.setAttribute("pickupDate", pickupDate);
		request.setAttribute("storeIdx", storeIdx);
		request.setAttribute("menuIdx", menuIdx);
		
		Kn_MenuDAO dao = new Kn_MenuDAO();
		
		Kn_MenuVO vo = dao.getMenuContent(menuIdx);
		
		request.setAttribute("vo", vo);
	}
}
