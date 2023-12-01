package shop;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ShopReservCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//오늘 날짜
		Calendar today = Calendar.getInstance(); //calendar객체는 싱글톤객체

		int year = today.get(Calendar.YEAR);
		int month = today.get(Calendar.MONTH);
		int day = today.get(Calendar.DATE);

		//화면에 보여줄 해당 '년/월'
		int yy = request.getParameter("yy")==null ? year : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null ? month : Integer.parseInt(request.getParameter("mm"));
		
		//1월(0)은 이전 월 클릭시 음수가 넘어오므로 년도 -1, 월을 12월(11)로 세팅
		//12월(11)은 다음 월 클릭시 13월(12)이 넘어오므로 년도 +1, 월을 1월(0)로 세팅
		if(mm < 0) {
			yy--;
			mm = 11;
		}
		if(mm > 11) {
			yy++;
			mm = 0;
		}
		
		//선택한 해당 '년/월'의 1일을 기준으로 날짜 세팅(처음은 오늘 날짜, 즉 '년/월/1')
		today.set(yy, mm, 1);
		
		//앞에서 세팅한 해당 '년/월/1일' 의 요일 값을 숫자로 가져온다 (일:1, 월:2, 화:3, 수:4, ~~ 토:7) : 테이블 안에 1일이 들어갈 첫 열을 찾아주기 위해
		int startWeek = today.get(Calendar.DAY_OF_WEEK);
		
		//해당 월의 마지막 일자
		int lastDay = today.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		//출력된 달력의 공백을 이전 월과 다음 월 날짜로 채우기
		int prevYear = yy;
		int prevMonth = mm - 1;
		int nextYear = yy;
		int nextMonth = mm + 1;
		
		if(prevMonth < 0) {
			prevYear--;
			prevMonth = 11;
		}
		if(nextMonth > 11) {
			nextYear++;
			nextMonth = 0;
		}
		
		//현재 월의 이전 월의 마지막 날짜를 구한다(ex. 11월 달력을 보고 있으면 10월 31일)
		today.set(prevYear, prevMonth, 1);
		int prevLastDay = today.getActualMaximum(Calendar.DAY_OF_MONTH); 
		
		//다음 월의 1일에 해당하는 요일을 숫자로 구한다
		today.set(nextYear, nextMonth, 1);
		int nextStartWeek = today.get(Calendar.DAY_OF_WEEK);
		

		//오늘 날짜를 저장소에 담아서 보낸다
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		request.setAttribute("day", day);
		
		//선택한 달의 해당 '년/월/일/요일(숫자)' 를 저장소에 담아서 보낸다
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		//현재 월의 이전,다음 월
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("prevLastDay", prevLastDay);
		request.setAttribute("nextStartWeek", nextStartWeek);
		
	}
}