package kn_reservation;

public class Kn_CartMenuVO {
	private String menuName;
	private String category;
	private int price;
	
	
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "Kn_CartMenuVO [menuName=" + menuName + ", category=" + category + ", price=" + price + "]";
	}
}
