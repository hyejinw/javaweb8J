package kn_admin;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kn_menu.Kn_MenuVO;

public class AdminMenuModifyOKCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 기존 사진은 삭제하고 새로 업로드(수정)한다.
		String menuPhoto = request.getParameter("menuPhoto")==null ? "" : request.getParameter("menuPhoto");
		
		String realPath = request.getServletContext().getRealPath("/images/kn_menu/");
		File file = new File(realPath + menuPhoto);
		String res = "0";
		
		// 파일 삭제!
		if(file.exists()) {
			file.delete();
		}

		realPath = request.getServletContext().getRealPath("/images/kn_menu");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";
		
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		String menuPhotoModified = multi.getFilesystemName("menuPhotoModified")== null ? "" : multi.getFilesystemName("menuPhotoModified");
	
		int idx = multi.getParameter("idx")== null ? 0 : Integer.parseInt(multi.getParameter("idx"));
		String category = multi.getParameter("category")== null ? "" :multi.getParameter("category");
		String menuName = multi.getParameter("menuName")== null ? "" : multi.getParameter("menuName");
		String menuEngName = multi.getParameter("menuEngName")== null ? "" : multi.getParameter("menuEngName");
		int price = multi.getParameter("price")== null ? 0 : Integer.parseInt(multi.getParameter("price"));
		String explanation = multi.getParameter("explanation")== null ? "" : multi.getParameter("explanation");
		String allergy = multi.getParameter("allergy")== null ? "" : multi.getParameter("allergy");
		String origin = multi.getParameter("origin")== null ? "" : multi.getParameter("origin");
		String menuStartDate = multi.getParameter("menuStartDate")== null ? "" : multi.getParameter("menuStartDate");

		Kn_MenuVO vo = new Kn_MenuVO();
		vo.setIdx(idx);
		vo.setCategory(category);
		vo.setMenuName(menuName);
		vo.setMenuEngName(menuEngName);
		vo.setPrice(price);
		vo.setExplanation(explanation);
		vo.setAllergy(allergy);
		vo.setOrigin(origin);
		vo.setMenuPhoto(menuPhotoModified);
		vo.setMenuStartDate(menuStartDate);
		
		Kn_AdminDAO dao = new Kn_AdminDAO();
		res = dao.setMenuModify(vo);
			
		
		response.getWriter().write(res);

	}

}
