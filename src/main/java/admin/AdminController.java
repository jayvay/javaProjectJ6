package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.ad")
public class AdminController extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPage = "/WEB-INF/admin";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		if(com.equals("/adminMain")) {
			command = new AdminMainCommand();
			command.execute(request, response);
			viewPage += "/adminMain.jsp";
		}
		if(com.equals("/adminLeft")) {
			viewPage += "/adminLeft.jsp";
		}
		if(com.equals("/adminContent")) {
			viewPage += "/adminContent.jsp";
		} 
		else if(com.equals("/adminAlbumInput")) {	
			viewPage += "/adminAlbumInput.jsp";
		}
		else if(com.equals("/adminAlbumInputOk")) {
			command = new AdminAlbumInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/adminAlbumDeleteOk")) {
			command = new AdminAlbumDeleteOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/adminMemberList")) {	
			viewPage += "/adminMemberList.jsp";
		}
		else if(com.equals("/adminMemberLevelChange")) {
			command = new AdminMemberLevelChangeCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/adminMemberDeleteOk")) {
			command = new AdminMemberDeleteOkCommand();
			command.execute(request, response);
			return;
		}
		
		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
