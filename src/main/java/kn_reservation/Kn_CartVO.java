package kn_reservation;

public class Kn_CartVO {
	private int idx;
	private String memMid;
	private int storeIdx;
	private int menuIdx;
	private int menuCnt;
	private int menuPrice;
	private String pickupDate;
	
	// 매장명
	private String storeName;
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
		return "Kn_CartVO [idx=" + idx + ", memMid=" + memMid + ", storeIdx=" + storeIdx + ", menuIdx=" + menuIdx
				+ ", menuCnt=" + menuCnt + ", menuPrice=" + menuPrice + ", pickupDate=" + pickupDate + ", storeName="
				+ storeName + ", menuName=" + menuName + "]";
	}
}