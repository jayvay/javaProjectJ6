package shop;

public class CartVO {

	private int idx;
	private String mid;
	private int albumIdx;
	private int albumCnt;
	private int salePrice;
	
	private String alName;
	private String singer;
	private int price;
	private int discount;
	private int stock;
	private int saleCnt;
	private String photo;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getAlbumIdx() {
		return albumIdx;
	}
	public void setAlbumIdx(int albumIdx) {
		this.albumIdx = albumIdx;
	}
	public int getAlbumCnt() {
		return albumCnt;
	}
	public void setAlbumCnt(int albumCnt) {
		this.albumCnt = albumCnt;
	}
	public int getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(int salePrice) {
		this.salePrice = salePrice;
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
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
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
		return "CartVO [idx=" + idx + ", mid=" + mid + ", albumIdx=" + albumIdx + ", albumCnt=" + albumCnt + ", salePrice="
				+ salePrice + ", alName=" + alName + ", singer=" + singer + ", price=" + price + ", discount=" + discount
				+ ", stock=" + stock + ", saleCnt=" + saleCnt + ", photo=" + photo + "]";
	}
	
}