package kn_member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kn_store.Kn_StoreDAO;
import kn_store.Kn_StoreVO;

public class FranStoreCheckCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String storeName = request.getParameter("storeName")==null ? "" : request.getParameter("storeName");

		Kn_StoreDAO dao = new Kn_StoreDAO();
		Kn_StoreVO vo = dao.getStoreCheck(storeName);
		
		if(vo.getStoreName() == null) {
			request.setAttribute("res", 1);   // 사용 가능한 매장명
		}
		else {
			request.setAttribute("res", 0);   // 이미 사용 중인 매장명
		}
		request.setAttribute("storeName", storeName);
	}
}
