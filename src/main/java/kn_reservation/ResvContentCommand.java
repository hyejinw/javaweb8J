package kn_reservation;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kn_store.Kn_StoreDAO;
import kn_store.Kn_StoreVO;

public class ResvContentCommand implements ReservInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kn_StoreDAO dao = new Kn_StoreDAO();
		
		ArrayList<Kn_StoreVO> vos = dao.getStoreList();
		request.setAttribute("vos", vos);

	}

}
