package shop;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShopCartListCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ShopDAO dao = new ShopDAO();
		
		ArrayList<CartVO> vos = dao.getCartAlbumList();
		
		request.setAttribute("vos", vos);

	}

}
