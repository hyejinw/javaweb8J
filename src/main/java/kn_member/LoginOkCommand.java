package kn_member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class LoginOkCommand implements MemInterface {

	@SuppressWarnings("static-access")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		
		Kn_MemberDAO dao = new Kn_MemberDAO();
		Kn_MemberVO vo = dao.getMidCheck(mid);
		
		// salt 가져오기
		pwd = vo.getSalt() + pwd;
		
		// 다시 암호화 처리!!!!!!
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		System.out.println("로그인 pwd : " + pwd);
		
		
		// 진짜 아이디가 없거나, 1개월 전에 탈퇴한 회원일 때
		if (vo.getMid() == null || vo.getMemberDel().equals("OK")) {
			request.setAttribute("msg", "입력한 아이디는 없는 회원입니다.");
			request.setAttribute("url", request.getContextPath() + "/Login.kn_mem");
			return;
		} 
		if (!pwd.equals(vo.getPwd())) {
			request.setAttribute("msg", "비밀번호가 다릅니다.");
			request.setAttribute("url", request.getContextPath() + "/Login.kn_mem");
			return;
		}
		
		// 로그인 성공
		// 1. 세션 처리
		HttpSession session = request.getSession();
		int fail = session.getAttribute("sFail") == null ? 0 : (int) session.getAttribute("sFail"); // 로그인 실패했을 때 쓸 거여!
		session.setAttribute("sFail", fail);

		session.setAttribute("sIdx", vo.getIdx());
		session.setAttribute("sMid", mid);
		session.setAttribute("sName", vo.getName());
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("sLastVisit", vo.getLastVisit());
		
		

		Calendar couponExpired = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		// 쿠폰 만료 날짜 계산 (3개월 후)
		couponExpired.add(couponExpired.MONTH, +3);
		String date = sdf.format(couponExpired.getTime());

		// 1-1. 일반 회원 첫 로그인이면 가입 쿠폰을 준다.(회원 관리는 전부 고유 번호로 진행)
		if(vo.getTotCnt() == 0 && vo.getLevel() == 2) {
			
			dao.setCoupon(vo.getMid(), 1, date);
		}
		
		// 1-2. 회원 멤버십 업데이트 
		// 총 예약 금액 구하기
		int totResvPrice = dao.getTotResvPrice(mid);
		int res = 0;
		
		if(totResvPrice > 100000 && vo.getLevel() == 2) {
			// 현재 쿠폰 유무 확인  --> 멤버십 유지 기간 동안, 관리자가 쿠폰 삭제하지 못함.
			res = dao.getCouponCheck(mid, 3);
			if(res == 0) { // 없다면 발급하고, 멤버십 업데이트
				dao.setCoupon(vo.getMid(), 3, date);
				dao.setLevelUpdate(mid, 3);
			}
		}
		if(totResvPrice > 150000 && vo.getLevel() == 3) {
			res = dao.getCouponCheck(mid, 4);	
			if(res == 0) {
				dao.setCoupon(vo.getMid(), 3, date);
				dao.setCoupon(vo.getMid(), 4, date);
				dao.setLevelUpdate(mid, 4);
			}
		}
		
		

		// 2 각종 업데이트
		// 날짜 비교를 위한 초기 설정
		Date today = new Date();
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strToday = sdf.format(today);

		// 오늘 처음 방문 시는 오늘 방문 카운트(todayCnt)를 0으로 세팅한다.
		if (!vo.getLastVisit().substring(0, 10).equals(strToday)) {
			dao.setTodayCntUpdate(vo.getIdx());
			vo.setTodayCnt(0);
		}
		// 필요한 내용 업데이트 
		dao.setMemberTotalUpdate(vo.getIdx());

		// 3 로그인시 아이디저장시킨다고 체크하면 쿠키에 아이디 저장하고, 그렇지 않으면 쿠키에서 아이디를 제거한다.
		String idSave = request.getParameter("idSave") == null ? "off" : "on";
		
		Cookie cookieMid = new Cookie("cMid", mid);
		cookieMid.setPath("/");
		if (idSave.equals("on")) {
			cookieMid.setMaxAge(60 * 60 * 24 * 7);
		} else {
			cookieMid.setMaxAge(0);
		}
		response.addCookie(cookieMid);
		request.setAttribute("msg", vo.getName() + "님 로그인 되었습니다.");
		request.setAttribute("url", request.getContextPath() + "/");
		
		
	}

}
