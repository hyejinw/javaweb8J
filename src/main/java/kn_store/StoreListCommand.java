package kn_store;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StoreListCommand implements StoreInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kn_StoreDAO dao = new Kn_StoreDAO();
		
		ArrayList<Kn_StoreVO> vos = dao.getStoreList();
		request.setAttribute("vos", vos);
	}

}
