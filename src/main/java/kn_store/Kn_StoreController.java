package kn_store;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kn_menu.MenuListCommand;

@SuppressWarnings("serial")
@WebServlet("*.kn_st")
public class Kn_StoreController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StoreInterface command = null;
		String viewPage = "/WEB-INF/kn_store";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		
		if(com.equals("/Store")) {
			command = new StoreListCommand();
			command.execute(request, response);			
			viewPage += "/store.jsp";
		}
		if(com.equals("/StoreSearch")) {
			command = new StoreSearchCommand();
			command.execute(request, response);			
			viewPage += "/storeSearch.jsp";
		}
		if(com.equals("/StoreContent")) {
			command = new StoreContentCommand();
			command.execute(request, response);			
			viewPage += "/storeContent.jsp";
		}
		if(com.equals("/StoreReplyInput")) {
			command = new StoreReplyInputCommand();
			command.execute(request, response);			
			return;
		}
		if(com.equals("/StoreReplyDelete")) {
			command = new StoreReplyDeleteCommand();
			command.execute(request, response);			
			return;
		}
		if(com.equals("/StoreGood")) {
			command = new StoreGoodCommand();
			command.execute(request, response);			
			viewPage += "/storeContent.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}
