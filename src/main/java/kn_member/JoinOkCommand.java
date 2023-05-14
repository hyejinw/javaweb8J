package kn_member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JoinOkCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "":request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "":request.getParameter("pwd");
		String name = request.getParameter("name")==null ? "":request.getParameter("name");
		String tel = request.getParameter("tel")==null ? "":request.getParameter("tel");
		String email = request.getParameter("email")==null ? "":request.getParameter("email");
		String gender = request.getParameter("gender")==null ? "":request.getParameter("gender");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		String address = request.getParameter("address")==null ? "":request.getParameter("address");
		
    // 암호화 처리!!!!!!

		
		Kn_MemberVO vo = new Kn_MemberVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setName(name);
		vo.setTel(tel);
		vo.setEmail(email);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setAddress(address);
		
		Kn_MemberDAO dao = new Kn_MemberDAO();
		int res = dao.setMemberJoin(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "회원가입을 성공했습니다. 만나서 반갑습니다!");
			request.setAttribute("url", request.getContextPath() + "/Login.kn");
		}
		else {
			request.setAttribute("msg", "회원가입에 실패했습니다. 다시 시도해주세요.");
			request.setAttribute("url", request.getContextPath() + "/Join.kn");
		}
	}
}

	

