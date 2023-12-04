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
		int albumIdx = request.getParameter("albumIdx")==null ? 0 : Integer.parseInt(request.getParameter("albumIdx"));
		int num = request.getParameter("num")==null ? 0 : Integer.parseInt(request.getParameter("num"));
		double salePriceD = request.getParameter("salePrice")==null ? 0 : Double.parseDouble(request.getParameter("salePrice"));

		int salePrice = (int)salePriceD;
		int totPrice = num * salePrice;
		
		ShopDAO dao = new ShopDAO();
		CartVO vo = new CartVO();
		
		int resIdx = dao.getCartAlbumSearch(mid, albumIdx);
		
		String res = "";
		if(resIdx != 0) {
			res = dao.getCartSameAlbumCntUpdate(resIdx, num);
		}
		else {
			vo.setMid(mid);
			vo.setAlbumIdx(albumIdx);
			vo.setAlbumCnt(num);
			vo.setSalePrice(salePrice);
			
			res = dao.setCartInput(vo);
		}
		System.out.println("res: "+res);
		response.getWriter().write(res+"");
			
	}
}
