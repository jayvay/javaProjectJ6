package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberUpdateOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String gender = request.getParameter("gender")==null ? "" : request.getParameter("gender");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		String tel = request.getParameter("tel")==null ? "" : request.getParameter("tel");
		String address = request.getParameter("address")==null ? "" : request.getParameter("address");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");

		HttpSession session = request.getSession();
		String sNickName = (String) session.getAttribute("sNickName");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberNickCheck(nickName);
		
		if(!nickName.equals(sNickName)) {
			if(vo.getNickName() != null) {
				request.setAttribute("msg", "이미 사용 중인 닉네임입니다.");
				request.setAttribute("url", "memberJoin.mem");
				return;
			}
		}
		
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		
		int res = dao.setMemberUpdateOk(vo);
		
		if(res == 1) {
			session.setAttribute("sNickName", nickName);
			request.setAttribute("msg", "회원 정보 수정 완료!");
			request.setAttribute("url", "memberMain.mem");
		}
		else {
			request.setAttribute("msg", "회원 정보 수정 실패!");
			request.setAttribute("url", "memberInfoUpdate.mem");
		}
	}

}
