package kn_member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conn.GetConn;

public class Kn_MemberDAO {

	// 싱글톤으로 선언된 DB연결 객체(GetConn)을 연결
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	Kn_MemberVO vo = null;

	// 아이디 체크 후 자료가 있으면 vo에 개인 정보를 모두 담는다. (나중에 재사용할 거라 다 담았다)
	public Kn_MemberVO getMidCheck(String mid) {
		vo = new Kn_MemberVO();
		try {
			sql = "select * from kn_member where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setSalt(rs.getString("salt"));
				vo.setName(rs.getString("name"));
				vo.setEmail(rs.getString("email"));
				vo.setTel(rs.getString("tel"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setAddress(rs.getString("address"));
				vo.setGender(rs.getString("gender"));
				vo.setMemType(rs.getString("memType"));
				vo.setLevel(rs.getInt("level"));
				vo.setLevelStartDate(rs.getString("levelStartDate"));
				vo.setLevelExpireDate(rs.getString("levelExpireDate"));
				vo.setTotCnt(rs.getInt("totCnt"));
				vo.setTodayCnt(rs.getInt("todayCnt"));
				vo.setFirstVisit(rs.getString("firstVisit"));
				vo.setLastVisit(rs.getString("lastVisit"));
				vo.setMemberDel(rs.getString("memberDel"));
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(getMidCheck) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	
	// 회원가입 (JoinOkCommand)
	public int setJoin(Kn_MemberVO vo) {
		int res = 0;
		try {
			sql = "insert into kn_member values (default,?,?,?,?,?,?,?,?,?,?,?,default,?,default,default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getSalt());
			pstmt.setString(4, vo.getName());
			pstmt.setString(5, vo.getEmail());
			pstmt.setString(6, vo.getTel());
			pstmt.setString(7, vo.getBirthday());
			pstmt.setString(8, vo.getAddress());
			pstmt.setString(9, vo.getGender());
			pstmt.setString(10, vo.getMemType());
			
			if(vo.getMemType().equals("개인")) {
				pstmt.setInt(11, 2);
				pstmt.setString(12, vo.getLevelExpireDate());
			}
			else {
				pstmt.setInt(11, 1);
				pstmt.setString(12, "2500-12-31");
			}
			
			pstmt.executeUpdate();
			res = 1;
		
		} catch (SQLException e) {
			System.out.println("SQL 에러(setJoin) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	// 쿠폰 증정 (1.LoginOkCommand)
	public void setCoupon(String memMid, int coupon, String date) {
		try {
			sql = "insert into kn_coupon values (default,?,?,default,?,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memMid);
			pstmt.setInt(2, coupon);
			pstmt.setString(3, date);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(setCoupon) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	//(로그인 확인용 메소드 들어갈 자리!!)
	//오늘 처음 방문시에 방문카운트를 0으로 초기화.
	public void setTodayCntUpdate(int idx) {
		try {
			sql = "update kn_member set todayCnt=0 where idx =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(setTodayCntUpdate) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}
	
	// 로그인 시, totCnt 증가, todayCnt 증가, lastVisit 변경
	public void setMemberTotalUpdate(int idx) {
		try {
      sql = "update kn_member set totCnt=totCnt+1, todayCnt=todayCnt+1, lastVisit=now() where idx=?";
      pstmt = conn.prepareStatement(sql);
	  	pstmt.setInt(1, idx);
 	  	pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(setMemberTotalUpdate) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}


	// 총 예약 금액 구하기
	public int getTotResvPrice(String mid) {
		int totResvPrice = 0;
		
		try {
			sql = "select sum(menuPrice) from kn_reservation where memMid = ?";
      pstmt = conn.prepareStatement(sql);
	  	pstmt.setString(1, mid);
 	  	rs = pstmt.executeQuery();
 	  	
 	  	if(rs.next()) {
 	  		totResvPrice = rs.getInt(1);
 	  	}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(getTotResvPrice) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totResvPrice;
	}


	// 현재 쿠폰 유무 확인
	public int getCouponCheck(String mid, int i) {
		int res = 0;
		
		try {
			sql = "select idx from kn_coupon where memMid = ? and coupon = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, i);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				res = 1;
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(getCouponCheck) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}


	// 멤버십 업데이트
	public void setLevelUpdate(String mid, int i) {
		
		try {
			sql = "update kn_member set level=? where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, i);
			pstmt.setString(2, mid);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(setLevelUpdate) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
	}


	public int setMemModify(Kn_MemberVO vo) {
		int res = 0;
		
		try {
			sql = "update kn_member set name=?, email=?, tel=?, birthday=?, address=?, gender=? where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getTel());
			pstmt.setString(4, vo.getBirthday());
			pstmt.setString(5, vo.getAddress());
			pstmt.setString(6, vo.getGender());
			pstmt.setString(7, vo.getMid());
			pstmt.executeUpdate();
			res = 1;
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(setMemModify) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 마이페이지에서 예약 취소 (ResvCancelCommand)
	public String setResvCancelOk(int idx) {
		String res = "0";
		
		try {
			sql = "update kn_reservation set pickupOk='CANCEL' where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setResvDelOk) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
		return res;
	}

	// 회원 탈퇴 (MemDelCheckCommand)
	public int memDel(int idx) {
		int res = 0;
		
		try {
			sql = "update kn_member set memberDel='OK' where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res= 1;
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(memDel) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 1개월 전에 탈퇴한 회원 삭제 (LoginOkCommand)
	public void setDeletedMem() {
		
		try {
			sql = "delete from kn_member where lastVisit <= date_add(now(), interval -1 month) and memberDel = 'OK'";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(setDeletedMem) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 생일 쿠폰 발급
	public void setBirthdayCoupon() {
		// TODO Auto-generated method stub
		
	}



}