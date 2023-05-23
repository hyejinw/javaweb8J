package kn_store;

public class Kn_StoreReplyVO {
	private int idx;
	private int storeIdx;
	private String memMid;
	private String s_ReplyContent;
	private int s_ReplyRate;
	private int s_ReplyGood;
	private String s_ReplyPhoto;
	private String s_ReplyDate;
	private String s_ReplyHostIp;
	
	// 해당 매장의 총 평점 개수
	private int storeRateCnt;
	
	// 해당 매장의 평점 합
	private int storeRateTot;

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getStoreIdx() {
		return storeIdx;
	}

	public void setStoreIdx(int storeIdx) {
		this.storeIdx = storeIdx;
	}

	public String getMemMid() {
		return memMid;
	}

	public void setMemMid(String memMid) {
		this.memMid = memMid;
	}

	public String getS_ReplyContent() {
		return s_ReplyContent;
	}

	public void setS_ReplyContent(String s_ReplyContent) {
		this.s_ReplyContent = s_ReplyContent;
	}

	public int getS_ReplyRate() {
		return s_ReplyRate;
	}

	public void setS_ReplyRate(int s_ReplyRate) {
		this.s_ReplyRate = s_ReplyRate;
	}

	public int getS_ReplyGood() {
		return s_ReplyGood;
	}

	public void setS_ReplyGood(int s_ReplyGood) {
		this.s_ReplyGood = s_ReplyGood;
	}

	public String getS_ReplyPhoto() {
		return s_ReplyPhoto;
	}

	public void setS_ReplyPhoto(String s_ReplyPhoto) {
		this.s_ReplyPhoto = s_ReplyPhoto;
	}

	public String getS_ReplyDate() {
		return s_ReplyDate;
	}

	public void setS_ReplyDate(String s_ReplyDate) {
		this.s_ReplyDate = s_ReplyDate;
	}

	public String getS_ReplyHostIp() {
		return s_ReplyHostIp;
	}

	public void setS_ReplyHostIp(String s_ReplyHostIp) {
		this.s_ReplyHostIp = s_ReplyHostIp;
	}

	public int getStoreRateCnt() {
		return storeRateCnt;
	}

	public void setStoreRateCnt(int storeRateCnt) {
		this.storeRateCnt = storeRateCnt;
	}

	public int getStoreRateTot() {
		return storeRateTot;
	}

	public void setStoreRateTot(int storeRateTot) {
		this.storeRateTot = storeRateTot;
	}

	@Override
	public String toString() {
		return "Kn_StoreReplyVO [idx=" + idx + ", storeIdx=" + storeIdx + ", memMid=" + memMid + ", s_ReplyContent="
				+ s_ReplyContent + ", s_ReplyRate=" + s_ReplyRate + ", s_ReplyGood=" + s_ReplyGood + ", s_ReplyPhoto="
				+ s_ReplyPhoto + ", s_ReplyDate=" + s_ReplyDate + ", s_ReplyHostIp=" + s_ReplyHostIp + ", storeRateCnt="
				+ storeRateCnt + ", storeRateTot=" + storeRateTot + "]";
	}
}
