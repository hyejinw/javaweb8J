package kn_member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.kn_mem")
public class Kn_MemberController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemInterface command = null;
		String viewPage = "/WEB-INF/kn_member";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		// 세션이 끊겼다면 작업의 진행을 중단, 그리고 홈으로 전송!
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int)session.getAttribute("sLevel");

		
		// 로그인,로그아웃&회원가입 
		if(com.equals("/Login")) {     
			command = new LoginCommand();     // 로그인하러 갈 때 쿠키에 저장된 값이 있으면 아이디 칸에 저장된 아이디를 넣기 위해서!!!!
			command.execute(request, response);
			viewPage += "/login.jsp";
		}
		else if(com.equals("/LoginOk")) {
			command = new LoginOkCommand(); 
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/Logout")) {    
			command = new LogoutCommand();   
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 아이디 찾기
		else if(com.equals("/IdFinder")) {    
			viewPage += "/idFinder.jsp";
		}
		else if(com.equals("/IdFinderOk")) {    
			command = new IdFinderOkCommand();   
			command.execute(request, response);
			viewPage += "/idFinderRes.jsp";
		}
		// 비밀번호 찾기
		else if(com.equals("/PwdFinder")) {    
			viewPage += "/pwdFinder.jsp";
		}
		else if(com.equals("/PwdFinderOk")) {    
			command = new PwdFinderOkCommand();   
			command.execute(request, response);
			viewPage += "/pwdUpdate.jsp";
		}
		else if(com.equals("/PwdUpdateOk")) {    
			command = new PwdUpdateOkCommand();   
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		
		
		
		else if(com.equals("/Join")) {    
			viewPage += "/join.jsp";
		}
		else if(com.equals("/JoinOk")) {    
			command = new JoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/FranJoin")) { 
			viewPage += "/franJoin.jsp";
		}
		else if(com.equals("/FranJoinOk")) {   
			command = new FranJoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 아이디 중복 검사용
		else if(com.equals("/IdCheck")) {  
			command = new IdCheckCommand();    
			command.execute(request, response);
			viewPage += "/idCheck.jsp";
		}
		// 매장명 중복 검사용
		else if(com.equals("/FranStoreCheck")) {  
			command = new FranStoreCheckCommand();    
			command.execute(request, response);
			viewPage += "/franStoreCheck.jsp";
		}

		// 세션 끊기면 자동 홈으로 아웃
		else if(level > 4) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
		}		
		
		else if(com.equals("/MyPage")) {
			command = new MyPageCommand();    
			command.execute(request, response);
			viewPage += "/myPage.jsp";
		}
		// 회원 정보 수정
		else if(com.equals("/MemModifyOk")) {
			command = new MemModifyOkCommand();    
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 마이페이지에서 비밀번호 변경
		else if(com.equals("/PwdUpdateOkMypage")) {
			command = new PwdUpdateOkMypageCommand();    
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 마이페이지에서 예약 취소
		else if(com.equals("/ResvCancel")) {
			command = new ResvCancelCommand();    
			command.execute(request, response);
			return;
		}
		// 마이페이지에서 회원 탈퇴
		else if(com.equals("/MemDelCheck")) {
			command = new MemDelCheckCommand();    
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
	
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
