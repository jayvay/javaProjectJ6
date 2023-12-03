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
		else if(com.equals("/shopCart")) {
			command = new ShopCartCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/shopCartList")) {
			command = new ShopCartListCommand();
			command.execute(request, response);
			viewPage += "/shopCart.jsp";
		}
		else if(com.equals("/shopPay")) {
			command = new ShopPayCommand();
			command.execute(request, response);
			viewPage += "/shopPay.jsp";
		}
		else if(com.equals("/shopReserv")) {
			command = new ShopReservCommand();
			command.execute(request, response);
			viewPage += "/shopReservation.jsp";
		}
		else if(com.equals("/shopPayOk")) {
			command = new ShopPayOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/shopOrderComplete")) {
			viewPage += "/shopOrderComplete.jsp";
		}
		else if(com.equals("/albumReviewInput")) {
			command = new AlbumReviewInputCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/albumReviewDelete")) {
			command = new AlbumReviewDeleteCommand();
			command.execute(request, response);
			return;
		}
		
		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
