package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import shop.ShopDAO;
import shop.AlbumVO;

public class AdminAlbumInputOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/album");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());

		String photo = multipartRequest.getFilesystemName("photo");
		if(photo == null) photo = "noImage.jpg";
		
		String alName = multipartRequest.getParameter("alName")==null ? "" : multipartRequest.getParameter("alName");
		String singer = multipartRequest.getParameter("singer")==null ? "" : multipartRequest.getParameter("singer");
		int price = multipartRequest.getParameter("price")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("price"));
		String relDate = multipartRequest.getParameter("relDate")==null ? "" : multipartRequest.getParameter("relDate");
		String content = multipartRequest.getParameter("content")==null ? "" : multipartRequest.getParameter("content");

		String[] parts = multipartRequest.getParameterValues("part");
		String part = "";
		if(parts.length != 0) {
			for(String p : parts) {
				part += p + "/";
			}
		}
		part = part.substring(0, part.lastIndexOf("/"));
		
		String[] discs = multipartRequest.getParameterValues("disc");
		String disc = "";
		if(discs.length != 0) {
			for(String d : discs) {
				disc += d + "/";
			}
		}
		disc = disc.substring(0, disc.lastIndexOf("/"));
		
		ShopDAO dao = new ShopDAO();
		AlbumVO vo = dao.getAlbumSearch(alName, singer);
		
		if(vo.getAlName() != null) {
			request.setAttribute("msg", "이미 등록된 앨범입니다.");
			request.setAttribute("url", "adminAlbumInput.ad");
			return;
		}
		else {
			vo = new AlbumVO();
			vo.setAlName(alName);
			vo.setSinger(singer);
			vo.setPrice(price);
			vo.setPart(part);
			vo.setRelDate(relDate);
			vo.setContent(content);
			vo.setDisc(disc);
			vo.setPhoto(photo);
			
			int res = dao.setAlbumInput(vo);
			if(res != 0) {
				request.setAttribute("msg", "새로운 앨범이 등록되었습니다.");
				request.setAttribute("url", "adminAlbumList.ad");
			}
			else {
				request.setAttribute("msg", "앨범 등록이 실패했습니다. 다시 시도하세요.");
				request.setAttribute("url", "adminAlbumInput.ad");
			}
		}
	}

}
