package shop;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ShopCartListCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		
		ShopDAO dao = new ShopDAO();
		
		ArrayList<CartVO> vos = dao.getCartAlbumList(mid);
		
		int cartTotPrice = 0;
		int cartTotDiscount = 0;
		int cartTotSalePrice = 0;
		for(int i=0; i<vos.size(); i++) {
			cartTotPrice += vos.get(i).getPrice() * vos.get(i).getAlbumCnt();
			cartTotDiscount += (vos.get(i).getPrice() - vos.get(i).getSalePrice()) * vos.get(i).getAlbumCnt();
			cartTotSalePrice += vos.get(i).getSalePrice() * vos.get(i).getAlbumCnt();
		}
		System.out.println(cartTotPrice);
		System.out.println(cartTotDiscount);
		System.out.println(cartTotSalePrice);
		request.setAttribute("vos", vos);
		request.setAttribute("cartTotPrice", cartTotPrice);
		request.setAttribute("cartTotDiscount", cartTotDiscount);
		request.setAttribute("cartTotSalePrice", cartTotSalePrice);

	}

}
