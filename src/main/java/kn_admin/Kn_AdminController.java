package kn_admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kn_member.LoginOkCommand;

@SuppressWarnings("serial")
@WebServlet("*.kn_ad")
public class Kn_AdminController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPage = "/WEB-INF/kn_admin";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		// 세션이 끊겼다면 작업의 진행을 중단, 그리고 홈으로 전송!
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int)session.getAttribute("sLevel");

		// 세션 끊기면 자동 홈으로 아웃(관리자만 사용가능)
		if(level != 0) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
		}	
		
		// 관리자 창
		else if(com.equals("/AdminMain")) {      // 보완 필요 
			viewPage += "/adminMain.jsp";
		}
		else if(com.equals("/AdminLeft")) {      // 보완 필요 
			viewPage += "/adminLeft.jsp";
		}
		else if(com.equals("/AdminContent")) {      // 보완 필요 
			viewPage += "/adminContent.jsp";
		}
		
		// 회원 조회창
		else if(com.equals("/AdminMemList")) { 
			viewPage += "/member/adminMemList.jsp";
		}
		// 회원 조회
		else if(com.equals("/AdminMemListOK")) {   
			command = new AdminMemListOKCommand();  
			command.execute(request, response);
			return;
		}
		// 회원 수정창
		else if(com.equals("/AdminMemModify")) {
			viewPage += "/member/adminMemModify.jsp";
		}
		// 회원 수정
		else if(com.equals("/AdminMemModifyOK")) {   
			command = new AdminMemModifyOKCommand();  
			command.execute(request, response);
			return;
		}
		
		
		// 메뉴 조회
		else if(com.equals("/AdminMenuList")) {   
			viewPage += "/memu/adminMenuList.jsp";
		}
		
	
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
