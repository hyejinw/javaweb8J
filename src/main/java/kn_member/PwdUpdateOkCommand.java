package kn_member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class PwdUpdateOkCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");

		
		// 비밀번호 암호화 처리
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		pwd = salt + pwd;
		
    SecurityUtil security = new SecurityUtil();
    pwd = security.encryptSHA256(pwd);

    Kn_MemberDAO dao = new Kn_MemberDAO();
    int res = dao.getPwdUpdate(mid, email, salt, pwd);
		
		
		if(res == 1) {
			request.setAttribute("msg", "비밀번호가 변경되었습니다.");
			request.setAttribute("url", request.getContextPath() + "/Login.kn_mem");
			
		}
		else {
			request.setAttribute("msg", "다시 시도해주세요.");
			request.setAttribute("url", request.getContextPath() + "/PwdFinderOk.kn_mem");
			
		}


	}

}
