package kn_member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;
import kn_store.Kn_StoreDAO;
import kn_store.Kn_StoreVO;

public class FranJoinOkCommand implements MemInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "":request.getParameter("mid");
		String pwd = request.getParameter("pwd1")==null ? "":request.getParameter("pwd1");
		String name = request.getParameter("name")==null ? "":request.getParameter("name");
		String email = request.getParameter("email")==null ? "":request.getParameter("email");
		String tel = request.getParameter("tel")==null ? "":request.getParameter("tel");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		String gender = request.getParameter("gender")==null ? "":request.getParameter("gender");
		String memType = request.getParameter("memType")==null ? "매장":request.getParameter("memType");
		
		String storeName = request.getParameter("storeName")==null ? "":request.getParameter("storeName");
		String storeTel = request.getParameter("storeTel")==null ? "":request.getParameter("storeTel");
		String storeAddress = request.getParameter("address")==null ? "":request.getParameter("address");
		
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

    // 3. 모든 체크 완료 후, vo에 값을 담는다.
    vo = new Kn_MemberVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setSalt(salt);
		vo.setName(name);
		vo.setEmail(email);
		vo.setTel(tel);
		vo.setBirthday(birthday);
		vo.setGender(gender);
		vo.setMemType(memType);
		
		int res = dao.setJoin(vo);
		
		if(res == 1) {

			// 4. 해당 매장 등록
			vo = dao.getMidCheck(mid);
			
			// 매장 vo에 값을 담는다.
			Kn_StoreVO vo2 = new Kn_StoreVO();
			vo2.setMemIdx(vo.getIdx());
			vo2.setStoreName(storeName);
			vo2.setStoreTel(storeTel);
			vo2.setStoreAddress(storeAddress);

			Kn_StoreDAO dao2 = new Kn_StoreDAO();
			dao2.setStore(vo2);
			
			request.setAttribute("msg", "회원가입을 성공했습니다.\\n매장 관리창을 완성해주시면 관리자가 승인을 해드립니다!");
			request.setAttribute("url", request.getContextPath() + "/Login.kn_mem");
		}
		else {
			request.setAttribute("msg", "회원가입에 실패했습니다. 다시 시도해주세요.");
			request.setAttribute("url", request.getContextPath() + "/Join.kn_mem");
		}
	}
}

	

