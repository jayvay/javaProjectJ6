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
	public ArrayList<AlbumVO> getAlbumList() {
		ArrayList<AlbumVO> vos = new ArrayList<>();
		try {
			sql = "select * from album order by idx desc";
			pstmt = conn.prepareStatement(sql);
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
	public AlbumVO getAlbumSearch(String alName, String singer) {
		AlbumVO vo = new AlbumVO();
		try {
			sql = "select * from album where singer = ? and alName like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, singer);
			pstmt.setString(2, "%"+alName+"%");
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

	public int setAlbumInput(AlbumVO vo) {
		int res = 0;
		try {
			sql = "insert into album values (default, ?,?,?,?,?,?,? , default, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getAlName());
			pstmt.setString(2, vo.getSinger());
			pstmt.setInt(3, vo.getPrice());
			pstmt.setString(4, vo.getPart());
			pstmt.setString(5, vo.getRelDate());
			pstmt.setString(6, vo.getDisc());
			pstmt.setString(7, vo.getContent());
			pstmt.setString(8, vo.getPhoto());
			res = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

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

	public int setReplyDeleteOk(int idx) {
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
	
}