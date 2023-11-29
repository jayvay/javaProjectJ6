package shop;

public class AlbumVO {

	private int idx;
	private String alName;
	private String singer;
	private int price;
	private String part;
	private String relDate;
	private String disc;
	private String content;
	private int saleCnt;
	private String photo;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getAlName() {
		return alName;
	}
	public void setAlName(String alName) {
		this.alName = alName;
	}
	public String getSinger() {
		return singer;
	}
	public void setSinger(String singer) {
		this.singer = singer;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	public String getRelDate() {
		return relDate;
	}
	public void setRelDate(String relDate) {
		this.relDate = relDate;
	}
	public String getDisc() {
		return disc;
	}
	public void setDisc(String disc) {
		this.disc = disc;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getSaleCnt() {
		return saleCnt;
	}
	public void setSaleCnt(int saleCnt) {
		this.saleCnt = saleCnt;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	@Override
	public String toString() {
		return "AlbumVO [idx=" + idx + ", alName=" + alName + ", singer=" + singer + ", price=" + price + ", part=" + part
				+ ", relDate=" + relDate + ", disc=" + disc + ", content=" + content + ", saleCnt=" + saleCnt + ", photo="
				+ photo + "]";
	}
}