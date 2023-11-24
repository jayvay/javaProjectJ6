package javaProjectJ6.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.mem")
public class MemberController extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		memberInterface command = null;
		String viewPage = "/WEB-INF/member";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		if(com.equals("/memberJoin")) {
			viewPage += "/memberJoin.jsp";
		}
		else if(com.equals("/memberLogin")) {
			viewPage += "/memberLogin.jsp";
		}
		 
		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
