package kn_menu;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.kn_menu")
public class Kn_MenuController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MenuInterface command = null;
		String viewPage = "/WEB-INF/kn_menu";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		// 세션이 끊겼다면 작업의 진행을 중단, 그리고 홈으로 전송!
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int)session.getAttribute("sLevel");

		
		// 메뉴창
		if(com.equals("/Menu")) {
			command = new MenuListCommand();
			command.execute(request, response);
			viewPage += "/menu.jsp";
		}
		// 메뉴 검색
		else if(com.equals("/MenuSearch")) {
			command = new MenuSearchCommand();
			command.execute(request, response);
			viewPage += "/menuSearch.jsp";
		}
		// 메뉴 상세 페이지
		if(com.equals("/MenuContent")) {
			command = new MenuContentCommand();
			command.execute(request, response);
			viewPage += "/menuContent.jsp";
		}
		
		else if(level > 4) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
		}	
		
		
		// 댓글 입력
		if(com.equals("/MenuReplyInput")) {
			command = new MenuReplyInputCommand();
			command.execute(request, response);
			return;
		}
		// 댓글 삭제
		if(com.equals("/MenuReplyDelete")) {
			command = new MenuReplyDeleteCommand();
			command.execute(request, response);
			return;
		}
		// 댓글 좋아요 증가
		if(com.equals("/MenuGood")) {
			command = new MenuGoodCommand();
			command.execute(request, response);
			viewPage += "/menuContent.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}
