package kn_admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kn_menu.Kn_MenuReplyVO;

public class AdminMenuReplyOKCommand implements AdminInterface {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kn_AdminDAO dao = new Kn_AdminDAO();

		ArrayList<Kn_MenuReplyVO> vos = dao.getMenuReplyList();

		
		JSONObject menuReplyObj = new JSONObject();
		JSONArray menuReplyArray = new JSONArray();
		
	  for(int i=0; i<vos.size(); i++) { 
	  	
	  	JSONObject menuReply = new JSONObject();
	  	menuReply.put("idx", vos.get(i).getIdx() + "");
	  	menuReply.put("menuIdx", vos.get(i).getMenuIdx() + "");
	  	menuReply.put("memMid", vos.get(i).getMemMid());
	  	menuReply.put("m_ReplyContent", vos.get(i).getM_ReplyContent());
	  	menuReply.put("m_ReplyRate", vos.get(i).getM_ReplyRate() + "");
	  	menuReply.put("m_ReplyGood", vos.get(i).getM_ReplyGood() + "");
	  	menuReply.put("m_ReplyPhoto", vos.get(i).getM_ReplyPhoto());
	  	menuReply.put("m_ReplyDate", vos.get(i).getM_ReplyDate());
	  	menuReply.put("m_ReplyHostIp", vos.get(i).getM_ReplyHostIp());
	  	
	  	menuReplyArray.add(menuReply);
	  }
	  menuReplyObj.put("data", menuReplyArray);
	  
	  response.getWriter().write(menuReplyObj.toString());
	}

}
