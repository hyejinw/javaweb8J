package kn_admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kn_member.Kn_MemberDAO;
import kn_member.Kn_MemberVO;

public class AdminMemModifyOKCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String tel = request.getParameter("tel")==null ? "" : request.getParameter("tel");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		String address = request.getParameter("address")==null ? "" : request.getParameter("address");
		String gender = request.getParameter("gender")==null ? "" : request.getParameter("gender");
		String memType = request.getParameter("memType")==null ? "" : request.getParameter("memType");
		int level = request.getParameter("level")==null ? 2 : Integer.parseInt(request.getParameter("level"));
		String levelStartDate = request.getParameter("levelStartDate")==null ? "" : request.getParameter("levelStartDate");
		String levelExpireDate = request.getParameter("levelExpireDate")==null ? "" : request.getParameter("levelExpireDate");
		int totCnt = request.getParameter("totCnt")==null ? 0 : Integer.parseInt(request.getParameter("totCnt"));
		int todayCnt = request.getParameter("todayCnt")==null ? 0 : Integer.parseInt(request.getParameter("todayCnt"));
		String firstVisit = request.getParameter("firstVisit")==null ? "" : request.getParameter("firstVisit");
		String lastVisit = request.getParameter("lastVisit")==null ? "" : request.getParameter("lastVisit");
		String memberDel = request.getParameter("memberDel")==null ? "" : request.getParameter("memberDel");
		

		Kn_AdminDAO dao = new Kn_AdminDAO();
		Kn_MemberVO vo = new Kn_MemberVO();
		
		vo.setIdx(idx);
		vo.setMid(mid);
		vo.setName(name);
		vo.setEmail(email);
		vo.setTel(tel);
		vo.setBirthday(birthday);
		vo.setAddress(address);
		vo.setGender(gender);
		vo.setMemType(memType);
		vo.setLevel(level);
		vo.setLevelStartDate(levelStartDate);
		vo.setLevelExpireDate(levelExpireDate);
		vo.setTotCnt(totCnt);
		vo.setTodayCnt(todayCnt);
		vo.setFirstVisit(firstVisit);
		vo.setLastVisit(lastVisit);
		vo.setMemberDel(memberDel);
		
		String res = dao.setMemModify(vo);
		
		response.getWriter().write(res);
		
	}

}
