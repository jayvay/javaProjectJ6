package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.GetConn;

public class ShopDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	AlbumVO vo = null;
	
	// pstmt 객체 반납
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
		}
	}
	
	// rs 객체 반납
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {}
			finally {
				pstmtClose();
			}
		}
	}

	//모든 앨범 리스트
	public ArrayList<AlbumVO> getAlbumList(int startIndexNo, int pageSize, String part) {
		ArrayList<AlbumVO> vos = new ArrayList<>();
		try {
			if(part.equals("all")) {
				sql = "select * from album order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else {
				sql = "select * from album where part = ? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, part);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AlbumVO vo = new AlbumVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setAlName(rs.getString("alName"));
				vo.setSinger(rs.getString("singer"));
				vo.setPrice(rs.getInt("price"));
				vo.setDiscount(rs.getInt("discount"));
				vo.setPart(rs.getString("part"));
				vo.setRelDate(rs.getString("relDate"));
				vo.setDisc(rs.getString("disc"));
				vo.setContent(rs.getString("content"));
				vo.setStock(rs.getInt("stock"));
				vo.setSaleCnt(rs.getInt("saleCnt"));
				vo.setPhoto(rs.getString("photo"));
				vos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	//기존에 등록된 앨범인지 확인
	public AlbumVO getAlbumSearch(String alName, String singer, int idx) {
		AlbumVO vo = new AlbumVO();
		try {
			if(idx == 0) {
				sql = "select * from album where singer = ? and alName like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, singer);
				pstmt.setString(2, "%"+alName+"%");
			}
			else {
				sql = "select * from album where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
			}
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setAlName(rs.getString("alName"));
				vo.setSinger(rs.getString("singer"));
				vo.setPrice(rs.getInt("price"));
				vo.setDiscount(rs.getInt("discount"));
				vo.setPart(rs.getString("part"));
				vo.setRelDate(rs.getString("relDate"));
				vo.setDisc(rs.getString("disc"));
				vo.setContent(rs.getString("content"));
				vo.setStock(rs.getInt("stock"));
				vo.setSaleCnt(rs.getInt("saleCnt"));
				vo.setPhoto(rs.getString("photo"));
			}
		} catch (Exception e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	//새 앨범 등록
	public int setAlbumInput(AlbumVO vo) {
		int res = 0;
		try {
			sql = "insert into album values (default, ?,?,?,?,?,?,?,?,? ,default, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getAlName());
			pstmt.setString(2, vo.getSinger());
			pstmt.setInt(3, vo.getPrice());
			pstmt.setInt(4, vo.getDiscount());
			pstmt.setString(5, vo.getPart());
			pstmt.setString(6, vo.getRelDate());
			pstmt.setString(7, vo.getDisc());
			pstmt.setString(8, vo.getContent());
			pstmt.setInt(9, vo.getStock());
			pstmt.setString(10, vo.getPhoto());
			res = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	//앨범 평점/리뷰 리스트
	public ArrayList<ReviewVO> getAlbumReviewList(int idx) {
		ArrayList<ReviewVO> reviewVos = new ArrayList<ReviewVO>();
		try {	
			sql = "select * from review where albumIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewVO reviewVo = new ReviewVO();
				reviewVo.setIdx(rs.getInt("idx"));
				reviewVo.setAlbumIdx(rs.getInt("albumIdx"));
				reviewVo.setMid(rs.getString("mid"));
				reviewVo.setNickName(rs.getString("nickName"));
				reviewVo.setwDate(rs.getString("wDate"));
				reviewVo.setContent(rs.getString("content"));
				reviewVo.setStar(rs.getInt("star"));
				reviewVos.add(reviewVo);
			}
		} catch (SQLException e) {
			System.out.println("SQL구문 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return reviewVos;
		}

	//앨범 리뷰 삭제
	public int setReviewDeleteOk(int idx) {
		int res = 0;
		try {
			sql = "delete from review where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL구문 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}	
		return res;
	}


	//앨범 리뷰 등록
	public int setReviewInputOk(ReviewVO reviewVo) {
		int res = 0;
		try {
			sql = "insert into review values (default,?,?,?,default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewVo.getAlbumIdx());
			pstmt.setString(2, reviewVo.getMid());
			pstmt.setString(3, reviewVo.getNickName());
			pstmt.setString(4, reviewVo.getContent());
			pstmt.setInt(5, reviewVo.getStar());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL구문 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	//앨범 삭제 관리자 확인
	public String getAlbumDeleteCheck(int idx) {
		String res = "";
		try {
			sql = "select * from album where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				res = rs.getString("photo");
			}
		} catch (Exception e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return res;
	}

	//앨범 삭제
	public String setAlbumDeleteOk(int idx) {
		int res = 0;
		try {
			sql = "delete from album where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL구문 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}	
		return res + "";
	}

	//장바구니 저장
	public int setCartInput(CartVO vo) {
		int res = 0;
		try {
			sql = "insert into cart values (default,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setInt(2, vo.getAlbumIdx());
			pstmt.setInt(3, vo.getAlbumCnt());
			pstmt.setInt(4, vo.getPrice());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL구문 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	//장바구니 리스트
	public ArrayList<CartVO> getCartAlbumList() {
		ArrayList<CartVO> vos = new ArrayList<CartVO>();
		try {
			sql = "select * from cart c left outer join album a on c.albumIdx = a.idx;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CartVO vo = new CartVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setAlbumIdx(rs.getInt("albumIdx"));
				vo.setAlbumCnt(rs.getInt("albumCnt"));
				vo.setSalePrice(rs.getInt("salePrice"));
				vo.setAlName(rs.getString("alName"));
				vo.setSinger(rs.getString("singer"));
				vo.setPrice(rs.getInt("price"));
				vo.setDiscount(rs.getInt("discount"));
				vo.setStock(rs.getInt("stock"));
				vo.setSaleCnt(rs.getInt("saleCnt"));
				vo.setPhoto(rs.getString("photo"));
			}
		} catch (Exception e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	//전체 자료의 레코드건수 구해오기
	public int getTotRecCnt(String part) {
		int totRecCnt = 0;
		try {
			if(part.equals("all")) {
				sql = "select count(*) as cnt from album";
				pstmt = conn.prepareStatement(sql);
			}
			else {
				sql = "select count(*) as cnt from album where part = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, part);
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL구문 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}

	//주문 등록
	public int setOrderInput(OrderVO vo) {
		int res = 0;
		try {
			sql = "insert into shopOrder values (default,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getAlbumIdx());
			pstmt.setString(2, vo.getMid());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getTel());
			pstmt.setString(5, vo.getAddress());
			pstmt.setString(6, vo.getContent());
			pstmt.setString(7, vo.getPayment());
			pstmt.setString(8, vo.getOrderDate());
			pstmt.setString(9, vo.getReservDate());
			pstmt.setInt(10, vo.getAlbumCnt());
			pstmt.setInt(11, vo.getFinalPrice());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL구문 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	//주문 후 재고 -1 업데이트
	public int setAlbumStockUpdate(int albumIdx) {
		int res = 0;
		try {
			sql = "update album set stock = (stock-1) where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, albumIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL구문 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	//주문 내역 불러오기
	public ArrayList<OrderVO> getMyOrderList(String mid) {
		ArrayList<OrderVO> vos = new ArrayList<>();
		try {
			sql = "select * from shopOrder where mid = ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrderVO vo = new OrderVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setAlbumIdx(rs.getInt("albumIdx"));
				vo.setMid(rs.getString("mid"));
				vo.setName(rs.getString("name"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setContent(rs.getString("content"));
				vo.setPayment(rs.getString("payment"));
				vo.setOrderDate(rs.getString("orderDate"));
				vo.setReservDate(rs.getString("reservDate"));
				vo.setAlbumCnt(rs.getInt("albumCnt"));
				vo.setFinalPrice(rs.getInt("finalPrice"));
				vos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}
	
}