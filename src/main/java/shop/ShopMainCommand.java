package shop;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShopMainCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		AlbumDAO dao = new AlbumDAO();
		
		ArrayList<AlbumVO> vos = dao.getAlbumList();
		
		request.setAttribute("vos", vos);
	}
}
