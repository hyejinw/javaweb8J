package kn_reservation;

public class Kn_ResvVO {
	private int idx;
	private String memMid;
	private int storeIdx;
	private int menuIdx;
	private int couponIdx;
	private int menuCnt;
	private int menuPrice;
	private String pickupDate;
	private String pickupOk;
	
	// 매장명
	private String storeName;   // 이건 안 필요할 것 같다!
	// 메뉴명
	private String menuName;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMemMid() {
		return memMid;
	}
	public void setMemMid(String memMid) {
		this.memMid = memMid;
	}
	public int getStoreIdx() {
		return storeIdx;
	}
	public void setStoreIdx(int storeIdx) {
		this.storeIdx = storeIdx;
	}
	public int getMenuIdx() {
		return menuIdx;
	}
	public void setMenuIdx(int menuIdx) {
		this.menuIdx = menuIdx;
	}
	public int getCouponIdx() {
		return couponIdx;
	}
	public void setCouponIdx(int couponIdx) {
		this.couponIdx = couponIdx;
	}
	public int getMenuCnt() {
		return menuCnt;
	}
	public void setMenuCnt(int menuCnt) {
		this.menuCnt = menuCnt;
	}
	public int getMenuPrice() {
		return menuPrice;
	}
	public void setMenuPrice(int menuPrice) {
		this.menuPrice = menuPrice;
	}
	public String getPickupDate() {
		return pickupDate;
	}
	public void setPickupDate(String pickupDate) {
		this.pickupDate = pickupDate;
	}
	public String getPickupOk() {
		return pickupOk;
	}
	public void setPickupOk(String pickupOk) {
		this.pickupOk = pickupOk;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	@Override
	public String toString() {
		return "Kn_ResvVO [idx=" + idx + ", memMid=" + memMid + ", storeIdx=" + storeIdx + ", menuIdx=" + menuIdx
				+ ", couponIdx=" + couponIdx + ", menuCnt=" + menuCnt + ", menuPrice=" + menuPrice + ", pickupDate="
				+ pickupDate + ", pickupOk=" + pickupOk + ", storeName=" + storeName + ", menuName=" + menuName + "]";
	}
}