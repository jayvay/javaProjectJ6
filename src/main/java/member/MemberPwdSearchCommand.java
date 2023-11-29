package member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SecurityUtil;

public class MemberPwdSearchCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		
		MemberDAO dao = new MemberDAO();

		int res = dao.getPwdSearch(mid, email);
		
		String str = "";
		if(res != 0) {
			UUID uid = UUID.randomUUID();
			String imsiPwdUid = uid.toString().substring(0,6);
			str = "임시 비밀번호 : " + imsiPwdUid;
			
			SecurityUtil security = new SecurityUtil();
			imsiPwdUid = security.encryptSHA256(imsiPwdUid);
			dao.setMemberPwdUpdate(mid, imsiPwdUid);
		}
		else {
			str = "검색하신 회원 정보가 없습니다.";
		}
		response.getWriter().write(str);
	}

}
