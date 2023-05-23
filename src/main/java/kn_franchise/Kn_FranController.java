package kn_franchise;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.kn_fr")
public class Kn_FranController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FranInterface command = null;
		String viewPage = "/WEB-INF/kn_franchise";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		// 세션이 끊겼다면 작업의 진행을 중단, 그리고 홈으로 전송!
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int)session.getAttribute("sLevel");

		// 세션 끊기면 자동 홈으로 아웃(매장회원만 사용가능)
		if(level != 1) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
		}	
		
		else if(com.equals("/FranMain")) {
			viewPage += "/franMain.jsp";
		}
		else if(com.equals("/FranLeft")) {
			viewPage += "/franLeft.jsp";
		}
		else if(com.equals("/FranContent")) {
			viewPage += "/franContent.jsp";
		}
		// 매장 정보 수정창
		else if(com.equals("/FranInfoModify")) {
			command = new FranInfoModifyCommand();
			command.execute(request, response);
			viewPage += "/store/franInfoModify.jsp";
		}
		// 매장 정보 수정
		else if(com.equals("/FranStoreInfoModifyOk")) {
			command = new FranStoreInfoModifyOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 매장 관리창
		else if(com.equals("/FranStore")) {
			viewPage += "/store/franStore.jsp";
		}
		// 매장 관리 정보 가져오기
		else if(com.equals("/FranStoreOk")) {
			command = new FranStoreOkCommand();
			command.execute(request, response);
			return;
		}
		// 매장 삭제 + 매장회원 삭제
		else if(com.equals("/FranStoreDel")) {
			command = new FranStoreDelCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}
