package kn_admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kn_reservation.Kn_CouponVO;

public class AdminCouponListOKCommand implements AdminInterface {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kn_AdminDAO dao = new Kn_AdminDAO();

		ArrayList<Kn_CouponVO> vos = dao.getCouponList();

		
		JSONObject couponObj = new JSONObject();
		JSONArray couponArray = new JSONArray();
		
	  for(int i=0; i<vos.size(); i++) { 
	  	JSONObject coupon = new JSONObject();
	  	coupon.put("idx", vos.get(i).getIdx() + "");
	  	coupon.put("memMid", vos.get(i).getMemMid());
	  	coupon.put("level", vos.get(i).getLevel() + "");
	  	coupon.put("levelExpireDate", vos.get(i).getLevelExpireDate());
	  	coupon.put("coupon", vos.get(i).getCoupon() + "");
	  	coupon.put("couponStartDate", vos.get(i).getCouponStartDate());
	  	coupon.put("couponExpireDate", vos.get(i).getCouponExpireDate());
	  	coupon.put("couponDel", vos.get(i).getCouponDel());
	  	coupon.put("couponUsed", vos.get(i).getCouponUsed());
	  	coupon.put("couponUsedDate", vos.get(i).getCouponUsedDate());
	  	
	  	couponArray.add(coupon);
	  }
	  couponObj.put("data", couponArray);
	  
	  response.getWriter().write(couponObj.toString());
	}

}
