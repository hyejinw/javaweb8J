package kn_menu;

public class Kn_MenuVO {
	private int idx;
	private String category;
	private String menuName;
	private String menuEngName;
	private int price;
	private String explanation;
	private String allergy;
	private String origin;
	private String menuPhoto;
	private int menuRate;
	private String menuStartDate;
	private String menuOpen;
	private String menuDel;
	
	// 메뉴 시작일 시간 차이 계산용
	private int hour_diff;
	
	// 메뉴 시작일 날짜 차이 계산용
	private int day_diff;
	
	// 댓글 개수
	private int replyCount;

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuEngName() {
		return menuEngName;
	}

	public void setMenuEngName(String menuEngName) {
		this.menuEngName = menuEngName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getExplanation() {
		return explanation;
	}

	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}

	public String getAllergy() {
		return allergy;
	}

	public void setAllergy(String allergy) {
		this.allergy = allergy;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getMenuPhoto() {
		return menuPhoto;
	}

	public void setMenuPhoto(String menuPhoto) {
		this.menuPhoto = menuPhoto;
	}

	public int getMenuRate() {
		return menuRate;
	}

	public void setMenuRate(int menuRate) {
		this.menuRate = menuRate;
	}

	public String getMenuStartDate() {
		return menuStartDate;
	}

	public void setMenuStartDate(String menuStartDate) {
		this.menuStartDate = menuStartDate;
	}

	public String getMenuOpen() {
		return menuOpen;
	}

	public void setMenuOpen(String menuOpen) {
		this.menuOpen = menuOpen;
	}

	public String getMenuDel() {
		return menuDel;
	}

	public void setMenuDel(String menuDel) {
		this.menuDel = menuDel;
	}

	public int getHour_diff() {
		return hour_diff;
	}

	public void setHour_diff(int hour_diff) {
		this.hour_diff = hour_diff;
	}

	public int getDay_diff() {
		return day_diff;
	}

	public void setDay_diff(int day_diff) {
		this.day_diff = day_diff;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	@Override
	public String toString() {
		return "Kn_MenuVO [idx=" + idx + ", category=" + category + ", menuName=" + menuName + ", menuEngName="
				+ menuEngName + ", price=" + price + ", explanation=" + explanation + ", allergy=" + allergy + ", origin="
				+ origin + ", menuPhoto=" + menuPhoto + ", menuRate=" + menuRate + ", menuStartDate=" + menuStartDate
				+ ", menuOpen=" + menuOpen + ", menuDel=" + menuDel + ", hour_diff=" + hour_diff + ", day_diff=" + day_diff
				+ ", replyCount=" + replyCount + "]";
	}
}