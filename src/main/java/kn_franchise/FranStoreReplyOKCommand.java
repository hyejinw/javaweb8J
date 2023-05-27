package kn_franchise;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kn_store.Kn_StoreReplyVO;

public class FranStoreReplyOKCommand implements FranInterface {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int memIdx = (int)session.getAttribute("sIdx");
		
		Kn_FranDAO dao = new Kn_FranDAO();
		int storeIdx = dao.getStoreIdx(memIdx);

		ArrayList<Kn_StoreReplyVO> vos = dao.getStoreReplyList(storeIdx);

		
		JSONObject storeReplyObj = new JSONObject();
		JSONArray storeReplyArray = new JSONArray();
		
	  for(int i=0; i<vos.size(); i++) { 
	  	
	  	JSONObject storeReply = new JSONObject();
	  	storeReply.put("idx", vos.get(i).getIdx() + "");
	  	storeReply.put("storeIdx", vos.get(i).getStoreIdx() + "");
	  	storeReply.put("memMid", vos.get(i).getMemMid());
	  	storeReply.put("s_ReplyContent", vos.get(i).getS_ReplyContent());
	  	storeReply.put("s_ReplyRate", vos.get(i).getS_ReplyRate() + "");
	  	storeReply.put("s_ReplyGood", vos.get(i).getS_ReplyGood() + "");
	  	storeReply.put("s_ReplyPhoto", vos.get(i).getS_ReplyPhoto());
	  	storeReply.put("s_ReplyDate", vos.get(i).getS_ReplyDate());
	  	storeReply.put("s_ReplyHostIp", vos.get(i).getS_ReplyHostIp());
	  	
	  	storeReplyArray.add(storeReply);
	  }
	  storeReplyObj.put("data", storeReplyArray);
	  
	  response.getWriter().write(storeReplyObj.toString());
	}

}
