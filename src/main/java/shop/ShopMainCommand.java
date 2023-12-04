package shop;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShopMainCommand implements ShopInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String part = request.getParameter("part")==null ? "all" : request.getParameter("part");
		
		ShopDAO dao = new ShopDAO();
		
	// 페이징처리
			//1. 현재 페이지 번호를 구한다.
			int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
			
			//2. 한 페이지의 분량을 정한다.
			int pageSize = request.getParameter("pageSize")==null ? 9 : Integer.parseInt(request.getParameter("pageSize"));

			//3. 총 레코드 건 수를 구한다.(sql 명령어 중 count함수 사용)
			int totRecCnt = dao.getTotRecCnt(part);
			
			//4. 총 페이지 건 수를 구한다.
			int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
			
			//5. 현재 페이지에 출력할 '시작 인덱스 번호'를 구한다.
			int startIndexNo = (pag - 1) * pageSize;
			
			//6. 현재 화면에 표시될 시작 번호를 구한다.
			int curScrStartNo = totRecCnt - startIndexNo;
			
			
			//블록페이징 처리 (시작블록의 번호를 0번으로 처리했다)
			//1. 블록의 크기 결정 (여기선 3으로 해보자)
			int blockSize = 2;
			
			//2. 현재 페이지가 속한 블록 번호를 구한다. (예:총 레코드 개수가 38개일 때 1,2,3페이지는 0블록/ 4,5,6페이지는 1블록
			int curBlock = (pag - 1) / blockSize;
			
			//3. 마지막 블록을 구한다.
			int lastBlock = (totPage - 1) / blockSize;
			
			//지정된 페이지의 자료를 요청한 한 페이지의 분량만큼 가져온다.
		
		ArrayList<AlbumVO> vos = dao.getAlbumList(startIndexNo, pageSize, part);
		
		request.setAttribute("vos", vos);
		request.setAttribute("part", part);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
	}
}
