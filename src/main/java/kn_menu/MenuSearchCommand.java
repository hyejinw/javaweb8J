package kn_menu;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MenuSearchCommand implements MenuInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchString = request.getParameter("searchString") == null ? "" : request.getParameter("searchString").trim();  // 이렇게 해주면 좌우 공백까지 깔끔하게 정리해서 검색할 수 있다.
		String part = request.getParameter("part") == null ? "전체" : request.getParameter("part").trim(); 
		
		
		Kn_MenuDAO dao = new Kn_MenuDAO();
		
		
		// 페이징 처리 여기서!!!
		// 1. 현재 페이지번호를 구한다.
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		
		// 2. 한 페이지의 분량을 결정한다.
		int pageSize = request.getParameter("pageSize")==null ? 24 : Integer.parseInt(request.getParameter("pageSize"));
		
		// 3. 총 메뉴 개수를 구한다.
		int totRecCnt = dao.getTotMenuSearchCnt(searchString);
		
		// 4. 총 페이지 건수를 구한다.
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1 ;
		
		// 5. 현재페이지의 '시작 인덱스번호'를 구한다.
		int startIndexNo = (pag - 1) * pageSize;
		
		// 6. 현재 화면에 표시할 시작번호를 구한다.
		int curScrStartNo = totRecCnt - startIndexNo;
		
		
		// 블록페이징처리.... 블록의 시작번호를 0부터 처리했다.
		// 1. 블록의 크기를 결정한다.(여기선 3으로 결정 후 처리)
		int blockSize = 3;
		
		// 2. 현재페이지가 속한 블록 번호를 구한다.(예:1페이지는 0블록, 2페이지도 0블록, 4~6페이지는 1블록)
		int curBlock = (pag - 1) / blockSize;
		
		// 3. 마지막 블록을 구한다.
		int lastBlock = (totPage - 1) / blockSize;
		
		
		ArrayList<Kn_MenuVO> vos = dao.getMenuSearch(startIndexNo, pageSize, searchString);

		
		request.setAttribute("vos", vos);
		request.setAttribute("part", part);
		request.setAttribute("pag", pag);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
	}

}
