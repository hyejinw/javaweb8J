package kn_admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kn_store.Kn_StoreVO;

public class AdminStoreListOkCommand implements AdminInterface {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kn_AdminDAO dao = new Kn_AdminDAO();

		ArrayList<Kn_StoreVO> vos = dao.getStoreList();
		
		JSONObject storeObj = new JSONObject();
		JSONArray storeArray = new JSONArray();

	  for(int i=0; i<vos.size(); i++) { 
	  	
	  	JSONObject store = new JSONObject();
	  	store.put("idx", vos.get(i).getIdx() + "");
	  	store.put("memIdx", vos.get(i).getMemIdx() + "");
	  	store.put("storeName", vos.get(i).getStoreName());
	  	store.put("storeTel", vos.get(i).getStoreTel());
	  	store.put("storeAddress", vos.get(i).getStoreAddress());
	  	store.put("storePhoto", vos.get(i).getStorePhoto());
	  	store.put("location", vos.get(i).getLocation());
	  	store.put("opHour", vos.get(i).getOpHour());
	  	store.put("storeMenu", vos.get(i).getStoreMenu());
	  	store.put("storeRate", vos.get(i).getStoreRate() + "");
	  	store.put("storeModify", vos.get(i).getStoreModify());
	  	store.put("storeOpen", vos.get(i).getStoreOpen());
	  	store.put("storeDel", vos.get(i).getStoreDel());
	  	
	  	storeArray.add(store);
	  }
	  storeObj.put("data", storeArray);
	  response.getWriter().write(storeObj.toString());
	}

}
