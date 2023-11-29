package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.mem")
public class MemberController extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberInterface command = null;
		String viewPage = "/WEB-INF/member";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(com.equals("/memberJoin")) {
			viewPage += "/memberJoin.jsp";
		}
		else if(com.equals("/memberIdCheck")) {
			command = new MemberIdCheckCommand();
			command.execute(request, response);
			viewPage += "/memberIdCheck.jsp";
		}
		else if(com.equals("/memberNickCheck")) {
			command = new MemberNickCheckCommand();
			command.execute(request, response);
			viewPage += "/memberNickCheck.jsp";
		}
		else if(com.equals("/memberJoinOk")) {
			command = new MemberJoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/memberLogin")) {
			viewPage += "/memberLogin.jsp";
		}
		else if(com.equals("/memberLoginOk")) {
			command = new MemberLoginOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/shop/shopMain.jsp";
		}
		else if(com.equals("/memberMidSearch")) {
			command = new MemberMidSearchCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/memberPwdSearch")) {
			command = new MemberPwdSearchCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/memberInfoUpdate")) {
			viewPage += "/memberInfoUpdate.jsp";
		}
		 
		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
