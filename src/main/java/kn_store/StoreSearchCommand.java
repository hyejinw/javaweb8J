package kn_store;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StoreSearchCommand implements StoreInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchString = request.getParameter("searchString") == null ? "" : request.getParameter("searchString").trim();  // 이렇게 해주면 좌우 공백까지 깔끔하게 정리해서 검색할 수 있다.
		
		Kn_StoreDAO dao = new Kn_StoreDAO();
		
		ArrayList<Kn_StoreVO> vos = dao.getStoreSearch(searchString);
		request.setAttribute("vos", vos);
	}
}
