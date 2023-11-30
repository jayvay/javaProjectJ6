package shop;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemberDAO;
import member.MemberVO;

public class ShopPayCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null ? "" : (String)session.getAttribute("sMid");
		String alName = request.getParameter("alName")==null ? "" : request.getParameter("alName");
		String singer = request.getParameter("singer")==null ? "" : request.getParameter("singer");
		int num = request.getParameter("num")==null ? 1 : Integer.parseInt(request.getParameter("num"));
		double salePriceD = request.getParameter("salePrice")==null ? 0 : Double.parseDouble(request.getParameter("salePrice"));
 
		int salePrice = (int)salePriceD;
		int totPrice = num * salePrice;
		
		MemberDAO mDao = new MemberDAO();
		MemberVO mVo = mDao.getMemberSearch(mid);

		AlbumDAO aDao = new AlbumDAO();
		AlbumVO aVo = aDao.getAlbumSearch(alName, singer);
		
		
	  Date today = new Date(); 
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 
	  String strToday = sdf.format(today);
		 
		
		request.setAttribute("mVo", mVo);
		request.setAttribute("aVo", aVo);
		request.setAttribute("num", num);
		request.setAttribute("salePrice", salePrice);
		request.setAttribute("totPrice", totPrice);
		request.setAttribute("strToday", strToday);
	}
}
