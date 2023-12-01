package shop;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AlbumReviewInputCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int albumIdx = request.getParameter("albumIdx")==null ? 0 : Integer.parseInt(request.getParameter("albumIdx"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		int star = request.getParameter("star")==null ? 0 : Integer.parseInt(request.getParameter("star"));
		
		ReviewVO reviewVo = new ReviewVO();
		
		reviewVo.setAlbumIdx(albumIdx);
		reviewVo.setMid(mid);
		reviewVo.setNickName(nickName);
		reviewVo.setContent(content);
		reviewVo.setStar(star);
		
		ShopDAO dao = new ShopDAO();
		int res = dao.setReviewInputOk(reviewVo);
		
		response.getWriter().write(res+"");

	}

}
