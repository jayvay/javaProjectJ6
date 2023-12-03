package shop;

public class OrderVO {

	private int idx;
	private int albumIdx;
	private String mid;
	private String name;
	private String tel;
	private String address;
	private String content;
	private String payment;
	private String orderDate;
	private String reservDate;
	private int albumCnt;
	private int finalPrice;
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getReservDate() {
		return reservDate;
	}
	public void setReservDate(String reservDate) {
		this.reservDate = reservDate;
	}
	public int getAlbumCnt() {
		return albumCnt;
	}
	public void setAlbumCnt(int albumCnt) {
		this.albumCnt = albumCnt;
	}
	public int getFinalPrice() {
		return finalPrice;
	}
	public void setFinalPrice(int finalPrice) {
		this.finalPrice = finalPrice;
	}
	
	@Override
	public String toString() {
		return "OrderVO [idx=" + idx + ", albumIdx=" + albumIdx + ", mid=" + mid + ", name=" + name + ", tel=" + tel
				+ ", address=" + address + ", content=" + content + ", payment=" + payment + ", orderDate=" + orderDate
				+ ", reservDate=" + reservDate + ", albumCnt=" + albumCnt + ", finalPrice=" + finalPrice + "]";
	}
	
}
