package shop;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShopAlbumDetailCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String alName = request.getParameter("alName")==null ? "" : request.getParameter("alName");
		String singer = request.getParameter("singer")==null ? "" : request.getParameter("singer");
		
		AlbumDAO dao = new AlbumDAO();
		
		AlbumVO vo = dao.getAlbumSearch(alName, singer);
		
		request.setAttribute("vo", vo);
		

	}

}
