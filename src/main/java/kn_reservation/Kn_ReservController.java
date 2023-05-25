package kn_reservation;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.kn_re")
public class Kn_ReservController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReservInterface command = null;
		String viewPage = "/WEB-INF/kn_reservation";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		
		// 세션이 끊겼다면 작업의 진행을 중단, 그리고 홈으로 전송!
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int)session.getAttribute("sLevel");

		
		if(com.equals("/Reservation")) {
			viewPage += "/reservation.jsp";
		}
		
		// 세션 끊기면 자동 홈으로 아웃
		else if(level > 4) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
		}	
		
		// 예약창(매장 선택)
		else if(com.equals("/ResvContent")) {
			command = new ResvContentCommand();
			command.execute(request, response);
			viewPage += "/resvContent.jsp";
		}
		// 예약창(날짜 선택)
		else if(com.equals("/ResvDate")) {
			command = new ResvDateCommand();
			command.execute(request, response);
			viewPage += "/resvDate.jsp";
		}
		// 예약창(메뉴 선택)
		else if(com.equals("/ResvMenu")) {
			command = new ResvMenuCommand();
			command.execute(request, response);
			viewPage += "/resvMenu.jsp";
		}
		// 예약창(메뉴 검색)
		else if(com.equals("/ResvMenuSearch")) {
			command = new ResvMenuSearchCommand();
			command.execute(request, response);
			viewPage += "/resvMenuSearch.jsp";
		}
		// 예약창(메뉴 개수 결정)
		else if(com.equals("/ResvMenuContent")) {
			command = new ResvMenuContentCommand();
			command.execute(request, response);
			viewPage += "/resvMenuContent.jsp";
		}
		// 장바구니에 넣기
		else if(com.equals("/ResvCartInput")) {
			command = new ResvCartInputCommand();
			command.execute(request, response);
			return;
		}
		// 장바구니창
		else if(com.equals("/Cart")) {
			command = new CartCommand();
			command.execute(request, response);
			viewPage += "/cart.jsp";
		}
		// 장바구니 내용 전체 삭제
		else if(com.equals("/CartDel")) {
			command = new CartDelCommand();
			command.execute(request, response);
			return;
		}
		// 장바구니 메뉴 한 개 삭제
		else if(com.equals("/CartMenuDel")) {
			command = new CartMenuDelCommand();
			command.execute(request, response);
			return;
		}
		// 주문
		else if(com.equals("/Order")) {
			command = new OrderCommand();
			command.execute(request, response);
			viewPage += "/order.jsp";
		}
		// 결제
		else if(com.equals("/OrderCheck")) {
			command = new OrderCheckCommand();
			command.execute(request, response);
			return;
		}
		// 매장 변경
		else if(com.equals("/CartChange")) {
			command = new CartChangeCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}
