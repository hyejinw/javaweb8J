package kn_franchise;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kn_store.Kn_StoreVO;

public class FranStoreOkCommand implements FranInterface {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kn_FranDAO dao = new Kn_FranDAO();

		HttpSession session = request.getSession();
		int memIdx = (int)session.getAttribute("sIdx");
		Kn_StoreVO vo = dao.getFranInfo(memIdx);

		
		JSONObject storeObj = new JSONObject();
		JSONArray storeArray = new JSONArray();
		
		if(vo != null) { 
	  	JSONObject store = new JSONObject();
	  	store.put("idx", vo.getIdx() + "");
	  	store.put("memIdx", vo.getMemIdx() + "");
	  	store.put("storeName", vo.getStoreName());
	  	store.put("storeTel", vo.getStoreTel());
	  	store.put("storeAddress", vo.getStoreAddress());
	  	store.put("storePhoto", vo.getStorePhoto());
	  	store.put("opHour", vo.getOpHour());
	  	store.put("storeMenu", vo.getStoreMenu());
	  	store.put("storeRate", vo.getStoreRate() + "");
	  	store.put("storeModify", vo.getStoreModify());
	  	store.put("storeOpen", vo.getStoreOpen());
	  	store.put("storeDel", vo.getStoreDel());
	  	store.put("replyCount", vo.getReplyCount());
	  	
	  	storeArray.add(store);
	  }
	  storeObj.put("data", storeArray);
	  
	  response.getWriter().write(storeObj.toString());
	}

}
