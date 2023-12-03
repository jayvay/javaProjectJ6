package member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import shop.OrderVO;
import shop.ShopDAO;

public class MemberMainCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid") ==null ? "" : (String)session.getAttribute("sMid");
		
		ShopDAO dao = new ShopDAO();
		
		ArrayList<OrderVO> vos = dao.getMyOrderList(mid);
		
		request.setAttribute("vos", vos);
	}

}
