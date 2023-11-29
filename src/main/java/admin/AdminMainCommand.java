package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminMainCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int aSw = request.getParameter("aSw")==null ? 1 : Integer.parseInt(request.getParameter("aSw"));
		request.setAttribute("aSw", aSw);
	}
}
