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
		if(com.equals("/Login")) {      // 함 
			command = new LoginCommand();     // 로그인하러 갈 때 쿠키에 저장된 값이 있으면 아이디 칸에 저장된 아이디를 넣기 위해서!!!!
			command.execute(request, response);
			viewPage += "/login.jsp";
		}
		else if(com.equals("/LoginOk")) {
			command = new LoginOkCommand();   // 함 
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/Logout")) {    // 보완 필요
			command = new LogoutCommand();   
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/Join")) {     // 함 
			viewPage += "/join.jsp";
		}
		else if(com.equals("/JoinOk")) {    // 함 
			command = new JoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/FranJoin")) {     // 매장 회원가입 함 
			viewPage += "/franJoin.jsp";
		}
		else if(com.equals("/FranJoinOk")) {    // 함 
			command = new FranJoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 아이디 중복 검사용
		else if(com.equals("/IdCheck")) {   // 함 
			command = new IdCheckCommand();    
			command.execute(request, response);
			viewPage += "/idCheck.jsp";
		}
		// 매장명 중복 검사용
		else if(com.equals("/FranStoreCheck")) {   // 함 
			command = new FranStoreCheckCommand();    
			command.execute(request, response);
			viewPage += "/franStoreCheck.jsp";
		}

		// 세션 끊기면 자동 홈으로 아웃
		else if(level > 4) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
		}		
		// 이 부분 선생님이랑 같이 한 내용이랑 비교하면서 추가해야 한다. 
		
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
	
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
