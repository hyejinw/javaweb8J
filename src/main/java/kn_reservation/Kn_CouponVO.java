package kn_reservation;

public class Kn_CouponVO {
	private int idx;
	private String memMid;
	private int coupon;
	private String couponStartDate;
	private String couponExpireDate;
	private String couponDel;
	private String couponUsed;
	private String couponUsedDate;
	
	
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
	public int getCoupon() {
		return coupon;
	}
	public void setCoupon(int coupon) {
		this.coupon = coupon;
	}
	public String getCouponStartDate() {
		return couponStartDate;
	}
	public void setCouponStartDate(String couponStartDate) {
		this.couponStartDate = couponStartDate;
	}
	public String getCouponExpireDate() {
		return couponExpireDate;
	}
	public void setCouponExpireDate(String couponExpireDate) {
		this.couponExpireDate = couponExpireDate;
	}
	public String getCouponDel() {
		return couponDel;
	}
	public void setCouponDel(String couponDel) {
		this.couponDel = couponDel;
	}
	public String getCouponUsed() {
		return couponUsed;
	}
	public void setCouponUsed(String couponUsed) {
		this.couponUsed = couponUsed;
	}
	public String getCouponUsedDate() {
		return couponUsedDate;
	}
	public void setCouponUsedDate(String couponUsedDate) {
		this.couponUsedDate = couponUsedDate;
	}
	@Override
	public String toString() {
		return "Kn_CouponVO [idx=" + idx + ", memMid=" + memMid + ", coupon=" + coupon + ", couponStartDate="
				+ couponStartDate + ", couponExpireDate=" + couponExpireDate + ", couponDel=" + couponDel + ", couponUsed="
				+ couponUsed + ", couponUsedDate=" + couponUsedDate + "]";
	}
}
