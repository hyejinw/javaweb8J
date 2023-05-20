package kn_admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminMenuInsertOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String realPath = request.getServletContext().getRealPath("/images/kn_menu");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";
		
		// 파일 업로드처리 (객체가 생성되면서 파일이 업로드 처리된다.) : 제한 사항에 걸리지 않으면 그 양이 어떻든 생성하면서 바로 업로드된다.
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		String menuPhoto = multi.getFilesystemName("menuPhoto")== null ? "" : multi.getFilesystemName("menuPhoto");
			
		String category = multi.getParameter("category")== null ? "" :multi.getParameter("category");
		String menuName = multi.getParameter("menuName")== null ? "" : multi.getParameter("menuName");
		String menuEngName = multi.getParameter("menuEngName")== null ? "" : multi.getParameter("menuEngName");
		int price = multi.getParameter("price")== null ? 0 : Integer.parseInt(multi.getParameter("price"));
		String explanation = multi.getParameter("explanation")== null ? "" : multi.getParameter("explanation");
		String allergy = multi.getParameter("allergy")== null ? "" : multi.getParameter("allergy");
		String origin = multi.getParameter("origin")== null ? "" : multi.getParameter("origin");

		Kn_MenuVO vo = new Kn_MenuVO();
		vo.setCategory(category);
		vo.setMenuName(menuName);
		vo.setMenuEngName(menuEngName);
		vo.setPrice(price);
		vo.setExplanation(explanation);
		vo.setAllergy(allergy);
		vo.setOrigin(origin);
		vo.setMenuPhoto(menuPhoto);
		
		Kn_AdminDAO dao = new Kn_AdminDAO();
		
		int res = dao.setMenuInsert(vo);
		String msg = "";
		
		if(res == 1) {
			msg = "메뉴 등록 완료";
		}
		else {
			msg = "메뉴 등록 실패";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", "${ctp}/AdminMenuInsert.kn_ad");

	}

}
