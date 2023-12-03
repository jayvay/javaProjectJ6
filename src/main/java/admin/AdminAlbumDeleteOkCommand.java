package admin;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;
import member.MemberDAO;
import shop.ShopDAO;

public class AdminAlbumDeleteOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");

		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("sMid");
		
		MemberDAO mDao = new MemberDAO();
		String adminPwd = mDao.getMemberPwdCheck(mid);
		
		if(adminPwd.equals(pwd)) {
			
			ShopDAO sDao = new ShopDAO();
			String photo = sDao.getAlbumDeleteCheck(idx);
			
			//1. 서버에 존재하는 파일 삭제
			String realPath = request.getServletContext().getRealPath("/images/album/");
					
			new File(realPath + photo).delete();
			
			//2. DB에서 제거
			String res = sDao.setAlbumDeleteOk(idx);
			response.getWriter().write(res);
		}
		else {
			response.getWriter().write("0");
		}
	}

}
