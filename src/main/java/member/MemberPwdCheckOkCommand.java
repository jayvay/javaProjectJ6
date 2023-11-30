package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;

public class MemberPwdCheckOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwd = request.getParameter("pwdCheck")==null ? "" : request.getParameter("pwdCheck");
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		MemberDAO dao = new MemberDAO();
		
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = dao.getMemberMidCheck(mid);
		
		if(vo.getMid() != null && pwd.equals(vo.getPwd())) {
			request.setAttribute("msg", "NO");
			request.setAttribute("url", "memberInfoUpdate.mem?mid="+mid);
		}
		else { 
			request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
			request.setAttribute("url", "memberMain.mem");
		}
	}

}
