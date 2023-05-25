package kn_member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class MemModifyOkCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		String pwd = request.getParameter("pwd")==null ? "":request.getParameter("pwd");
		String name = request.getParameter("name")==null ? "":request.getParameter("name");
		String email = request.getParameter("email")==null ? "":request.getParameter("email");
		String tel = request.getParameter("tel")==null ? "":request.getParameter("tel");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		String gender = request.getParameter("gender")==null ? "":request.getParameter("gender");
		String address = request.getParameter("address")==null ? "":request.getParameter("address");
	
		Kn_MemberDAO dao = new Kn_MemberDAO();
		Kn_MemberVO vo =dao.getMidCheck(mid);
		
		// salt 가져오기
		pwd = vo.getSalt() + pwd;
		
		// 다시 암호화 처리!!!!!!
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		
		if(!pwd.equals(vo.getPwd())) {
			request.setAttribute("msg", "잘못된 비밀번호 입니다.");
			request.setAttribute("url", request.getContextPath() + "/MyPage.kn_mem");
			return;
		}		

    
    // 2. 모든 체크 완료 후, vo에 값을 담는다.
    vo = new Kn_MemberVO();
		vo.setMid(mid);
		vo.setName(name);
		vo.setEmail(email);
		vo.setTel(tel);
		vo.setBirthday(birthday);
		vo.setAddress(address);
		vo.setGender(gender);
		
		int res = dao.setMemModify(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "회원 정보를 수정하였습니다.");
			request.setAttribute("url", request.getContextPath() + "/MyPage.kn_mem");
		}
		else {
			request.setAttribute("msg", "회원 정보 수정에 실패하였습니다. 다시 시도해주세요.");
			request.setAttribute("url", request.getContextPath() + "/MyPage.kn_mem");
		}
	}
}
