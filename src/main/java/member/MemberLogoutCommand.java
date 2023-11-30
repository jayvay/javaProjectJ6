package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberLogoutCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		String nickName = (String)session.getAttribute("sNickName");
		
		session.invalidate();
		
		//메세지 출력 후 회원 메인창으로 보낸다.
		request.setAttribute("msg", nickName + "님 로그아웃 되었습니다.");
		request.setAttribute("url", "memberLogin.mem");

	}

}
