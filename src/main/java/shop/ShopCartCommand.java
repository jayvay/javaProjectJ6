package shop;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ShopCartCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		int albumIdx = request.getParameter("albumIdx")==null ? 1 : Integer.parseInt(request.getParameter("albumIdx"));
		int num = request.getParameter("num")==null ? 1 : Integer.parseInt(request.getParameter("num"));
		double salePriceD = request.getParameter("salePrice")==null ? 0 : Double.parseDouble(request.getParameter("salePrice"));

		int salePrice = (int)salePriceD;
		int totPrice = num * salePrice;
		
		ShopDAO dao = new ShopDAO();
		CartVO vo = new CartVO();
		
		vo.setMid(mid);
		vo.setAlbumIdx(albumIdx);
		vo.setAlbumCnt(num);
		vo.setSalePrice(salePrice);
		
		int res = dao.setCartInput(vo);
		
		response.getWriter().write(res+"");
	}

}
