package shop;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShopAlbumDetailCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String alName = request.getParameter("alName")==null ? "" : request.getParameter("alName");
		String singer = request.getParameter("singer")==null ? "" : request.getParameter("singer");
		
		ShopDAO dao = new ShopDAO();
		
		AlbumVO vo = dao.getAlbumSearch(alName, singer);
		
		// 댓글 처리
		ArrayList<ReviewVO> reviewVos = dao.getAlbumReviewList(idx);

		int reviewTot = 0;
		for(ReviewVO r : reviewVos) {
			reviewTot += r.getStar();
		}
		double reviewAvg = 0.0;
		if(reviewVos.size() != 0) reviewAvg = (double) reviewTot / reviewVos.size();
		else reviewAvg = 0;
		
		request.setAttribute("vo", vo);
		request.setAttribute("reviewVos", reviewVos);
		request.setAttribute("reviewAvg", reviewAvg);
	}

}
