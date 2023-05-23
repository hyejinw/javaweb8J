package kn_franchise;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kn_admin.Kn_AdminDAO;
import kn_menu.Kn_MenuVO;
import kn_store.Kn_StoreVO;

public class FranStoreInfoModifyOkCommand implements FranInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/kn_store");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";
		
		// 파일 업로드처리 (객체가 생성되면서 파일이 업로드 처리된다.) : 제한 사항에 걸리지 않으면 그 양이 어떻든 생성하면서 바로 업로드된다.
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		String storePhoto = multi.getFilesystemName("storePhoto")== null ? "" : multi.getFilesystemName("storePhoto");
			
		String storeName = multi.getParameter("storeName")== null ? "" :multi.getParameter("storeName");
		String storeTel = multi.getParameter("storeTel")== null ? "" : multi.getParameter("storeTel");
		String storeAddress = multi.getParameter("storeAddress")== null ? "" : multi.getParameter("storeAddress");
		String opHour = multi.getParameter("opHour")== null ? "" : multi.getParameter("opHour");

		// donut, cake, bakery는 배열로 오기 때문에 따로 추가 처리가 필요
		String[] donuts = multi.getParameterValues("donut");
		String donut = "";
		if(donuts.length != 0) {
			for(String strDonut : donuts) {
				donut += strDonut + "/";
			}
		}
		String[] bakeries = multi.getParameterValues("bakery");
		String bakery = "";
		if(bakeries.length != 0) {
			for(String strBakery : bakeries) {
				bakery += strBakery + "/";
			}
		}
		String[] cakes = multi.getParameterValues("cake");
		String cake = "";
		if(cakes.length != 0) {
			for(String strCake : cakes) {
				cake += strCake + "/";
			}
		}
		cake = cake.substring(0, cake.lastIndexOf("/"));
		String menu = donut + bakery + cake;
		
		System.out.println("donut : " + donut);
		System.out.println("bakery : " + bakery);
		System.out.println("cake : " + cake);
		System.out.println("menu : " + menu);
		
		Kn_StoreVO vo = new Kn_StoreVO();
		vo.setStoreName(storeName);
		vo.setStoreTel(storeTel);
		vo.setStoreAddress(storeAddress);
		vo.setOpHour(opHour);
		vo.setStoreMenu(menu);
		vo.setStorePhoto(storePhoto);
		
		Kn_FranDAO dao = new Kn_FranDAO();
		
		int res = dao.setStoreModify(vo);
		String msg = "";
		
		if(res == 1) {
			msg = "매장 정보 수정 완료";
		}
		else {
			msg = "매장 정보 수정 실패";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", request.getContextPath()+"/FranInfoModify.kn_fr");

	}

}
