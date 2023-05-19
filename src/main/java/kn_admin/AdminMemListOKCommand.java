package kn_admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kn_member.Kn_MemberVO;

public class AdminMemListOKCommand implements AdminInterface {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kn_AdminDAO dao = new Kn_AdminDAO();

		ArrayList<Kn_MemberVO> vos = dao.getMemberList();

//		request.setAttribute("vos", vos);
		
		//HashMap<String, String> memData;
		JSONObject memberObj = new JSONObject();
		JSONArray memberArray = new JSONArray();
		
	  for(int i=0; i<vos.size(); i++) { 
	  	//memData = new HashMap<>(); 
	  	
	  	JSONObject mem = new JSONObject();
	  	mem.put("idx", vos.get(i).getIdx() + "");
	  	mem.put("mid", vos.get(i).getMid());
	  	mem.put("pwd", vos.get(i).getPwd());
	  	mem.put("salt", vos.get(i).getSalt());
	  	mem.put("name", vos.get(i).getName());
	  	mem.put("email", vos.get(i).getEmail());
	  	mem.put("tel", vos.get(i).getTel());
	  	mem.put("birthday", vos.get(i).getBirthday());
	  	mem.put("address", vos.get(i).getAddress());
	  	mem.put("gender", vos.get(i).getGender());
	  	mem.put("memType", vos.get(i).getMemType());
	  	mem.put("level", vos.get(i).getLevel() + "");
	  	mem.put("levelStartDate", vos.get(i).getLevelStartDate());
	  	mem.put("levelExpireDate", vos.get(i).getLevelExpireDate());
	  	mem.put("totCnt", vos.get(i).getTotCnt() + "");
	  	mem.put("todayCnt", vos.get(i).getTodayCnt() + "");
	  	mem.put("firstVisit", vos.get(i).getFirstVisit());
	  	mem.put("lastVisit", vos.get(i).getLastVisit());
	  	mem.put("memberDel", vos.get(i).getMemberDel());
	  	
			memberArray.add(mem);
	  }
	  memberObj.put("data", memberArray);
	  
	  response.getWriter().write(memberObj.toString());
	}

}
