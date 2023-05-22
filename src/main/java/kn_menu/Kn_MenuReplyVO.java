package kn_menu;

public class Kn_MenuReplyVO {
	private int idx;
	private int menuIdx;
	private String memMid;
	private String m_ReplyContent;
	private int m_ReplyRate;
	private int m_ReplyGood;
	private String m_ReplyPhoto;
	private String m_ReplyDate;
	private String m_ReplyHostIp;
	
	// 해당 메뉴의 총 평점 개수
	private int menuRateCnt;
	
	// 해당 메뉴의 평점 합
	private int menuRateTot;

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getMenuIdx() {
		return menuIdx;
	}

	public void setMenuIdx(int menuIdx) {
		this.menuIdx = menuIdx;
	}

	public String getMemMid() {
		return memMid;
	}

	public void setMemMid(String memMid) {
		this.memMid = memMid;
	}

	public String getM_ReplyContent() {
		return m_ReplyContent;
	}

	public void setM_ReplyContent(String m_ReplyContent) {
		this.m_ReplyContent = m_ReplyContent;
	}

	public int getM_ReplyRate() {
		return m_ReplyRate;
	}

	public void setM_ReplyRate(int m_ReplyRate) {
		this.m_ReplyRate = m_ReplyRate;
	}

	public int getM_ReplyGood() {
		return m_ReplyGood;
	}

	public void setM_ReplyGood(int m_ReplyGood) {
		this.m_ReplyGood = m_ReplyGood;
	}

	public String getM_ReplyPhoto() {
		return m_ReplyPhoto;
	}

	public void setM_ReplyPhoto(String m_ReplyPhoto) {
		this.m_ReplyPhoto = m_ReplyPhoto;
	}

	public String getM_ReplyDate() {
		return m_ReplyDate;
	}

	public void setM_ReplyDate(String m_ReplyDate) {
		this.m_ReplyDate = m_ReplyDate;
	}

	public String getM_ReplyHostIp() {
		return m_ReplyHostIp;
	}

	public void setM_ReplyHostIp(String m_ReplyHostIp) {
		this.m_ReplyHostIp = m_ReplyHostIp;
	}


	public int getMenuRateCnt() {
		return menuRateCnt;
	}

	public void setMenuRateCnt(int menuRateCnt) {
		this.menuRateCnt = menuRateCnt;
	}

	public int getMenuRateTot() {
		return menuRateTot;
	}

	public void setMenuRateTot(int menuRateTot) {
		this.menuRateTot = menuRateTot;
	}

	@Override
	public String toString() {
		return "Kn_MenuReplyVO [idx=" + idx + ", menuIdx=" + menuIdx + ", memMid=" + memMid + ", m_ReplyContent="
				+ m_ReplyContent + ", m_ReplyRate=" + m_ReplyRate + ", m_ReplyGood=" + m_ReplyGood + ", m_ReplyPhoto="
				+ m_ReplyPhoto + ", m_ReplyDate=" + m_ReplyDate + ", m_ReplyHostIp=" + m_ReplyHostIp + ", menuRateCnt="
				+ menuRateCnt + ", menuRateTot=" + menuRateTot + "]";
	}
}
