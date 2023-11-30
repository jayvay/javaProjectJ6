package shop;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.shop")
public class ShopController extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ShopInterface command = null;
		String viewPage = "/WEB-INF/shop";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
//		HttpSession session = request.getSession();
//		int level = session.getAttribute("sLevel")==null ? 99 : (int)session.getAttribute("sLevel");
		
//		if(level > 4) {
//			request.getRequestDispatcher("/").forward(request, response);
//		}
		if(com.equals("/shopMain")) {
			command = new ShopMainCommand();
			command.execute(request, response);
			viewPage += "/shopMain.jsp";
		}
		else if(com.equals("/shopAlbumDetail")) {
			command = new ShopAlbumDetailCommand();
			command.execute(request, response);
			viewPage += "/shopAlbumDetail.jsp";
		}
		else if(com.equals("/shopAlbumDetail")) {
			command = new ShopAlbumDetailCommand();
			command.execute(request, response);
			viewPage += "/shopAlbumDetail.jsp";
		}
		else if(com.equals("/shopPay")) {
			command = new ShopPayCommand();
			command.execute(request, response);
			viewPage += "/shopPay.jsp";
		}
		
		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
