package kn_admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class AdminMenuListOKCommand implements AdminInterface {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kn_AdminDAO dao = new Kn_AdminDAO();

		ArrayList<Kn_MenuVO> vos = dao.getMenuList();
		
		JSONObject menuObj = new JSONObject();
		JSONArray menuArray = new JSONArray();

	  for(int i=0; i<vos.size(); i++) { 
	  	
	  	JSONObject menu = new JSONObject();
	  	menu.put("idx", vos.get(i).getIdx() + "");
	  	menu.put("category", vos.get(i).getCategory());
	  	menu.put("menuName", vos.get(i).getMenuName());
	  	menu.put("menuEngName", vos.get(i).getMenuEngName());
	  	menu.put("price", vos.get(i).getPrice() + "");
	  	menu.put("explanation", vos.get(i).getExplanation());
	  	menu.put("allergy", vos.get(i).getAllergy());
	  	menu.put("origin", vos.get(i).getOrigin());
	  	menu.put("menuPhoto", vos.get(i).getMenuPhoto());
	  	menu.put("menuStartDate", vos.get(i).getMenuStartDate());
	  	menu.put("menuOpen", vos.get(i).getMenuOpen());
	  	menu.put("menuDel", vos.get(i).getMenuDel());
	  	
	  	menuArray.add(menu);
	  }
	  menuObj.put("data", menuArray);
	  
	  response.getWriter().write(menuObj.toString());
	}

}
