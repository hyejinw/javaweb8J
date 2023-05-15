package kn_store;

public class Kn_StoreVO {
	private int idx;
	private int memIdx;
	private String storeName;
	private String storeTel;
	private String storeAddress;
	private String location;
	private String opHour;
	private String storeMenu;
	private String storeOpen;
	private String storeDel;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getMemIdx() {
		return memIdx;
	}
	public void setMemIdx(int memIdx) {
		this.memIdx = memIdx;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getStoreTel() {
		return storeTel;
	}
	public void setStoreTel(String storeTel) {
		this.storeTel = storeTel;
	}
	public String getStoreAddress() {
		return storeAddress;
	}
	public void setStoreAddress(String storeAddress) {
		this.storeAddress = storeAddress;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getOpHour() {
		return opHour;
	}
	public void setOpHour(String opHour) {
		this.opHour = opHour;
	}
	public String getStoreMenu() {
		return storeMenu;
	}
	public void setStoreMenu(String storeMenu) {
		this.storeMenu = storeMenu;
	}
	public String getStoreOpen() {
		return storeOpen;
	}
	public void setStoreOpen(String storeOpen) {
		this.storeOpen = storeOpen;
	}
	public String getStoreDel() {
		return storeDel;
	}
	public void setStoreDel(String storeDel) {
		this.storeDel = storeDel;
	}
	@Override
	public String toString() {
		return "Kn_StoreVO [idx=" + idx + ", memIdx=" + memIdx + ", storeName=" + storeName + ", storeTel=" + storeTel
				+ ", storeAddress=" + storeAddress + ", location=" + location + ", opHour=" + opHour + ", storeMenu="
				+ storeMenu + ", storeOpen=" + storeOpen + ", storeDel=" + storeDel + "]";
	}
}
