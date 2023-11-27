package javaProjectJ6.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SecurityUtil;

public class MemberJoinOkCommand implements memberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		String tel = request.getParameter("tel")==null ? "" : request.getParameter("tel");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String address = request.getParameter("address")==null ? "" : request.getParameter("address");
		String gender = request.getParameter("gender")==null ? "" : request.getParameter("gender");

		
		//백엔드 체크 (DB에 저장된 자료들 중에 null값 체크와 길이에 대한 체크... 중복체크(아이디/닉네임))
		//아이디/닉네임 중복체크
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getMemberMidCheck(mid);
		
		if(vo.getMid() != null) {
			request.setAttribute("msg", "이미 사용 중인 아이디입니다.");
			request.setAttribute("url", "memberJoin.mem");
			return;
		}
		
		vo = dao.getMemberNickCheck(nickName);
		
		if(vo.getNickName() != null) {
			request.setAttribute("msg", "이미 사용 중인 닉네임입니다.");
			request.setAttribute("url", "memberJoin.mem");
			return;
		}
		
		//비밀번호 암호화 처리(sha256)
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		//체크가 모두 끝난 자료들을 VO에 담아서 DB에 저장
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		
		int res = dao.setMemberJoinOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "회원 가입 완료!\\n다시 로그인해주세요.");
			request.setAttribute("url", "memberLogin.mem");
		}
		else {
			request.setAttribute("msg", "회원 가입 실패!");
			request.setAttribute("url", "memberJoin.mem");
		}
	}

}
