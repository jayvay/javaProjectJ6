package member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberMidSearchCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		
		MemberDAO dao = new MemberDAO();
		
		ArrayList<String> vos = dao.getMidSearch(name, email);
		
		if(vos.size() == 0) {
			response.getWriter().write("0");
		}
		else {
			String res = "";
			for(String str : vos) {
				res += str + "/";
			}
			res = res.substring(0, res.lastIndexOf("/"));
			response.getWriter().write(res);
		}
	}
}
