package kn_member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class PwdUpdateOkMypageCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String pwd1 = request.getParameter("pwd1")==null ? "" : request.getParameter("pwd1");
		String pwd2 = request.getParameter("pwd2")==null ? "" : request.getParameter("pwd2");
		
		
		Kn_MemberDAO dao = new Kn_MemberDAO();
		Kn_MemberVO vo = dao.getMidCheck(mid);
		
		// salt 가져오기
		pwd1 = vo.getSalt() + pwd1;
		
		// 다시 암호화 처리!!!!!!
		SecurityUtil security = new SecurityUtil();
		pwd1 = security.encryptSHA256(pwd1);
		
		if (!pwd1.equals(vo.getPwd())) {
			request.setAttribute("msg", "기존 비밀번호가 다릅니다.");
			request.setAttribute("url", request.getContextPath() + "/MyPage.kn_mem");
			return;
		}
		
		
		// 비밀번호 암호화 처리
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		pwd2 = salt + pwd2;
		
    security = new SecurityUtil();
    pwd2 = security.encryptSHA256(pwd2);

		
		
		int res = dao.getPwdUpdate(mid, email, salt, pwd2);
		
		if(res == 1) {
			request.setAttribute("msg", "비밀번호가 변경되었습니다.");
			
		}
		else {
			request.setAttribute("msg", "다시 시도해주세요.");
			
		}
		request.setAttribute("url", request.getContextPath() + "/MyPage.kn_mem");
	}

}