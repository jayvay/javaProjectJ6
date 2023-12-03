package shop;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ShopPayOkCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		int albumIdx = request.getParameter("albumIdx") == null ? 0 : Integer.parseInt(request.getParameter("albumIdx"));
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String tel = request.getParameter("tel") == null ? "" : request.getParameter("tel");
		String address = request.getParameter("address") == null ? "" : request.getParameter("address");
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		String payment = request.getParameter("payment") == null ? "0" : request.getParameter("payment");
		String orderDate = request.getParameter("orderDate") == null ? "" : request.getParameter("orderDate");
		String reservDate = request.getParameter("rDate") == null ? "" : request.getParameter("rDate");
		int albumCnt = request.getParameter("albumCnt") == null ? 1 : Integer.parseInt(request.getParameter("albumCnt"));
		int finalPrice = request.getParameter("finalPrice") == null ? 0 : Integer.parseInt(request.getParameter("finalPrice"));
		
		OrderVO vo = new OrderVO();
		vo.setMid(mid);
		vo.setAlbumIdx(albumIdx);
		vo.setName(name);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setContent(content);
		vo.setPayment(payment);
		vo.setOrderDate(orderDate);
		vo.setReservDate(reservDate);
		vo.setAlbumCnt(albumCnt);
		vo.setFinalPrice(finalPrice);
		
		ShopDAO dao = new ShopDAO();
		int res = dao.setOrderInput(vo);
		
		if(res != 0) {
			res = dao.setAlbumStockUpdate(vo.getAlbumIdx());
			if(res != 0) {
				request.setAttribute("msg", "NO");
				request.setAttribute("url", "shopOrderComplete.shop");
			}
		}
		else {
			request.setAttribute("msg", "주문이 실패했습니다. 다시 시도해주세요.");
			request.setAttribute("url", "shopAlbumDetail.shop?idx="+albumIdx);
		}
	}

}
