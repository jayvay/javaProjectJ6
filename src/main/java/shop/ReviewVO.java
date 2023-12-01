package shop;

public class ReviewVO {

	private int idx;
	private int albumIdx;
	private String mid;
	private String nickName;
	private String wDate;
	private String content;
	private int star;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getAlbumIdx() {
		return albumIdx;
	}
	public void setAlbumIdx(int albumIdx) {
		this.albumIdx = albumIdx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	
	@Override
	public String toString() {
		return "ReviewVO [idx=" + idx + ", albumIdx=" + albumIdx + ", mid=" + mid + ", nickName=" + nickName + ", wDate="
				+ wDate + ", content=" + content + ", star=" + star + "]";
	}
	
	
}