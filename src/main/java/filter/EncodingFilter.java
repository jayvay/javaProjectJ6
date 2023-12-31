package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/*")
public class EncodingFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//System.out.println("1. 이곳은 Filter 통과하기 전입니다.");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		chain.doFilter(request, response); /* 얘를 기점으로 필터의 전과 후가 나뉘어진다. */
		
		//System.out.println("2. 이곳은 Filter 통과한 후입니다.");
	}
}
