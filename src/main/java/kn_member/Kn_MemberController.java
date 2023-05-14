package kn_member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("*.kn_mem")
public class Kn_MemberController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemInterface command = null;
		String viewPage = "/WEB-INF/kn_member";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		// 로그인,로그아웃&회원가입 
		if(com.equals("/Login")) {      // 함 
			viewPage += "/login.jsp";
		}
		else if(com.equals("/LoginOk")) {
			command = new LoginOkCommand();   // 함 
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/Logout")) {    // 안 함 
			viewPage += "/logout.jsp";
		}
		else if(com.equals("/Join")) {     // 함 
			viewPage += "/join.jsp";
		}
		else if(com.equals("/JoinOk")) {    // 함 
			command = new JoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 아이디 중복 검사용
		else if(com.equals("/IdCheck")) {   // 함 
			command = new IdCheckCommand();    
			command.execute(request, response);
			viewPage += "/idCheck.jsp";
		}

		
		
		else if(com.equals("/MyPage")) {
			viewPage += "/myPage.jsp";
		}
	
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
