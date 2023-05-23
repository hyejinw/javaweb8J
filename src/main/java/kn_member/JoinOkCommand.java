package kn_member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class JoinOkCommand implements MemInterface {

	@SuppressWarnings("static-access")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "":request.getParameter("mid");
		String pwd = request.getParameter("pwd1")==null ? "":request.getParameter("pwd1");
		String name = request.getParameter("name")==null ? "":request.getParameter("name");
		String email = request.getParameter("email")==null ? "":request.getParameter("email");
		String tel = request.getParameter("tel")==null ? "":request.getParameter("tel");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		String gender = request.getParameter("gender")==null ? "":request.getParameter("gender");
		String address = request.getParameter("address")==null ? "":request.getParameter("address");
		String memType = request.getParameter("memType")==null ? "개인":request.getParameter("memType");
		
		
		// 1. BackEnd 체크(null값, 길이, 중복여부 확인)
		
		// 아이디와 닉네임 중복체크
		Kn_MemberDAO dao = new Kn_MemberDAO();
		Kn_MemberVO vo =dao.getMidCheck(mid);
		
		if(vo.getMid() != null) {
			request.setAttribute("msg", "이미 사용 중인 아이디입니다.");
			request.setAttribute("url", request.getContextPath() + "/Join.kn_mem");
			return;
		}		
		
		
		// 2. 비밀번호 암호화 처리!!!!!!
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		pwd = salt + pwd;
		
    SecurityUtil security = new SecurityUtil();
    pwd = security.encryptSHA256(pwd);

    
    // 멤버십 만료 날짜 계산 (1년 후)
    Calendar cal = Calendar.getInstance();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    cal.add(cal.YEAR, +1);
    String date = sdf.format(cal.getTime());
    
    
    // 3. 모든 체크 완료 후, vo에 값을 담는다.
    vo = new Kn_MemberVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setSalt(salt);
		vo.setName(name);
		vo.setEmail(email);
		vo.setTel(tel);
		vo.setBirthday(birthday);
		vo.setAddress(address);
		vo.setGender(gender);
		vo.setMemType(memType);
		vo.setLevelExpireDate(date);
		
		int res = dao.setJoin(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "회원가입을 성공했습니다. 만나서 반갑습니다!");
			request.setAttribute("url", request.getContextPath() + "/Login.kn_mem");
		}
		else {
			request.setAttribute("msg", "회원가입에 실패했습니다. 다시 시도해주세요.");
			request.setAttribute("url", request.getContextPath() + "/Join.kn_mem");
		}
	}
}

	

