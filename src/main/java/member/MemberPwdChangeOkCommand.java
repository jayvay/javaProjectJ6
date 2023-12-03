package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;

public class MemberPwdChangeOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String newPwd = request.getParameter("newPwd")==null ? "" : request.getParameter("newPwd");
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		MemberDAO dao = new MemberDAO();
		
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = dao.getMemberMidCheck(mid);
		
		if(vo.getMid() != null && pwd.equals(vo.getPwd())) {
			newPwd = security.encryptSHA256(newPwd);
			dao.setMemberPwdUpdate(vo.getMid(), newPwd);
			request.setAttribute("msg", "비밀번호가 변경되었습니다.");
			request.setAttribute("url", "memberInfoUpdate.mem?mid="+mid);
		}
		else { 
			request.setAttribute("msg", "비밀번호 변경 실패, 다시 시도하세요.");
			request.setAttribute("url", "memberInfoUpdate.mem?mid="+mid);
		}
	}

}
