package kn_reservation;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResvDateCommand implements ReservInterface {

	@SuppressWarnings("static-access")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 매장 고유 idx
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		// 오늘 날짜 처리(저장)
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		
		// 화면에 보여줄 해당 '년/월'을 세팅
		Calendar calView = Calendar.getInstance();
		int yy = request.getParameter("yy")==null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
		
		if(mm < 0) {
			yy--;
			mm = 11;
		}
		if(mm > 11) {
			yy++;
			mm = 0;
		}
		
		// 해당 '년/월'의 1일을 기준으로 날짜 세팅
		calView.set(yy, mm, 1);
		
		// 세팅한 해당 '년/월'의 1일에 해당 요일값을 숫자로 가져온다
		int startWeek = calView.get(Calendar.DAY_OF_WEEK);
		//System.out.println("해당 '년/월'의 1일에 해당 요일값을 숫자로 : "+ startWeek);
		
		// 해당 '년/월'의 마지막 일자
		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);
		//System.out.println("해당 '년/월'의 마지막 일자 : "+ lastDay);
		
		// 화면에 보여줄 달력의 해당내역(년/월/요일 숫자) 저장소에 저장
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		// 오늘 날짜
		request.setAttribute("toYear", toYear);
		request.setAttribute("toMonth", toMonth);
		request.setAttribute("toDay", toDay);

		// 매장 고유번호
		request.setAttribute("idx", idx);
		
		
		Calendar cal = Calendar.getInstance();
		String format = "yyyyMMdd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.DATE, +2); // 시작 날짜
		String from = sdf.format(cal.getTime());
		
		cal.add(cal.DATE, +5); // 끝 날짜
		String to = sdf.format(cal.getTime());
		
		String startYear = from.substring(0, 4);
		String startMonth = from.substring(4, 6);
		String startDay = from.substring(6, 8);
				
		String lastYear = to.substring(0, 4);
		String lastMonth = to.substring(4, 6);
		String lastDayC = to.substring(6, 8);
		
		
				
		request.setAttribute("startYear", startYear);
		request.setAttribute("startMonth", startMonth);
		request.setAttribute("startDay", startDay);
		request.setAttribute("lastYear", lastYear);
		request.setAttribute("lastMonth", lastMonth);
		request.setAttribute("lastDayC", lastDayC);
	}

}
