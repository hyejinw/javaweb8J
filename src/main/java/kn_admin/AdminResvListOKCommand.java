package kn_admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kn_reservation.Kn_ResvVO;

public class AdminResvListOKCommand implements AdminInterface {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kn_AdminDAO dao = new Kn_AdminDAO();

		ArrayList<Kn_ResvVO> vos = dao.getResvList();

		JSONObject resvObj = new JSONObject();
		JSONArray resvArray = new JSONArray();
		
	  for(int i=0; i<vos.size(); i++) { 
	  	JSONObject resv = new JSONObject();
	  	resv.put("idx", vos.get(i).getIdx() + "");
	  	resv.put("memMid", vos.get(i).getMemMid());
	  	resv.put("storeIdx", vos.get(i).getStoreIdx() + "");
	  	resv.put("storeName", vos.get(i).getStoreName());
	  	resv.put("menuIdx", vos.get(i).getMenuIdx() + "");
	  	resv.put("menuName", vos.get(i).getMenuName());
	  	resv.put("couponIdx", vos.get(i).getCouponIdx() + "");
	  	resv.put("menuCnt", vos.get(i).getMenuCnt() + "");
	  	resv.put("menuPrice", vos.get(i).getMenuPrice() + "");
	  	resv.put("pickupDate", vos.get(i).getPickupDate());
	  	resv.put("pickupOk", vos.get(i).getPickupOk());
	  	
	  	resvArray.add(resv);
	  }
	  resvObj.put("data", resvArray);
	  
	  response.getWriter().write(resvObj.toString());
	}
}
