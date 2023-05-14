package kn_member;

public class Kn_MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String salt;
	private String name;
	private String email;
	private String tel;
	private String birthday;
	private String address;
	private String gender;
	private int level;
	private String levelStartDate;
	private String levelExpireDate;
	private int totCnt;
	private int todayCnt;
	private String firstVisit;
	private String lastVisit;
	private String memberDel;
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
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getLevelStartDate() {
		return levelStartDate;
	}
	public void setLevelStartDate(String levelStartDate) {
		this.levelStartDate = levelStartDate;
	}
	public String getLevelExpireDate() {
		return levelExpireDate;
	}
	public void setLevelExpireDate(String levelExpireDate) {
		this.levelExpireDate = levelExpireDate;
	}
	public int getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}
	public int getTodayCnt() {
		return todayCnt;
	}
	public void setTodayCnt(int todayCnt) {
		this.todayCnt = todayCnt;
	}
	public String getFirstVisit() {
		return firstVisit;
	}
	public void setFirstVisit(String firstVisit) {
		this.firstVisit = firstVisit;
	}
	public String getLastVisit() {
		return lastVisit;
	}
	public void setLastVisit(String lastVisit) {
		this.lastVisit = lastVisit;
	}
	public String getMemberDel() {
		return memberDel;
	}
	public void setMemberDel(String memberDel) {
		this.memberDel = memberDel;
	}
	@Override
	public String toString() {
		return "Kn_MemberVO [idx=" + idx + ", mid=" + mid + ", pwd=" + pwd + ", salt=" + salt + ", name=" + name
				+ ", email=" + email + ", tel=" + tel + ", birthday=" + birthday + ", address=" + address + ", gender=" + gender
				+ ", level=" + level + ", levelStartDate=" + levelStartDate + ", levelExpireDate=" + levelExpireDate
				+ ", totCnt=" + totCnt + ", todayCnt=" + todayCnt + ", firstVisit=" + firstVisit + ", lastVisit=" + lastVisit
				+ ", memberDel=" + memberDel + "]";
	}
}