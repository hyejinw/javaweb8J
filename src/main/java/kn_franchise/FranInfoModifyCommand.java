package kn_franchise;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kn_menu.Kn_MenuDAO;
import kn_menu.Kn_MenuVO;
import kn_store.Kn_StoreVO;

public class FranInfoModifyCommand implements FranInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		int memIdx = (int) session.getAttribute("sIdx");
		
		Kn_FranDAO dao = new Kn_FranDAO();
		Kn_StoreVO vo = dao.getFranInfo(memIdx);
		
		request.setAttribute("vo", vo);

		ArrayList<Kn_MenuVO> vos = dao.getMenuList();
		request.setAttribute("vos", vos);
	}

}
