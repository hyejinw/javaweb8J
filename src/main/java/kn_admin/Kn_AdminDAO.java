package kn_admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import kn_member.Kn_MemberVO;
import kn_menu.Kn_MenuReplyVO;
import kn_menu.Kn_MenuVO;
import kn_reservation.Kn_CouponVO;
import kn_reservation.Kn_ResvVO;
import kn_store.Kn_StoreReplyVO;
import kn_store.Kn_StoreVO;

public class Kn_AdminDAO {

	// 싱글톤으로 선언된 DB연결 객체(GetConn)을 연결
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	
	Kn_MemberVO vo = null;


	// 전체 회원 리스트 가져오기 (AdminMemListOKCommand)
	public ArrayList<Kn_MemberVO> getMemberList() {
		ArrayList<Kn_MemberVO> vos = new ArrayList<>();
		
		try {
			sql = "select * from kn_member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Kn_MemberVO();
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
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러(getMemberList) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 특정 회원 정보 수정 (AdminMemModifyOkCommand)
	public String setMemModify(Kn_MemberVO vo) {
		String res = "0";
		
		try {
			sql = "update kn_member set mid=?, name=?, email=?, tel=?, birthday=?, address=?,"
					+ "gender=?, memType=?, level=?, levelStartDate=?, levelExpireDate=?, totCnt=?, todayCnt=?,"
					+ "firstVisit=?, lastVisit=?, memberDel=? where idx = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getTel());
			pstmt.setString(5, vo.getBirthday());
			pstmt.setString(6, vo.getAddress());
			pstmt.setString(7, vo.getGender());
			pstmt.setString(8, vo.getMemType());
			pstmt.setInt(9, vo.getLevel());
			pstmt.setString(10, vo.getLevelStartDate());
			pstmt.setString(11, vo.getLevelExpireDate());
			pstmt.setInt(12, vo.getTotCnt());
			pstmt.setInt(13, vo.getTodayCnt());
			pstmt.setString(14, vo.getFirstVisit());
			pstmt.setString(15, vo.getLastVisit());
			pstmt.setString(16, vo.getMemberDel());
			pstmt.setInt(17, vo.getIdx());
			pstmt.executeUpdate();
			
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(setMemModify) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 회원 탈퇴 승인 (AdminMemberDelOkCommand)
	public String setMemberDelOk(int idx) {
		String res = "0";
		
		try {
			sql = "delete from kn_member where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setMemberDelOk) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
		return res;
	}

	// 메뉴 등록 (AdminMenuInsertOkCommand)
	public int setMenuInsert(Kn_MenuVO vo) {
		int res = 0;
		
		try {
			sql = "insert into kn_menu values(default,?,?,?,?,?,?,?,?,default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, vo.getCategory());
			pstmt.setString(2, vo.getMenuName());
			pstmt.setString(3, vo.getMenuEngName());
			pstmt.setInt(4, vo.getPrice());
			pstmt.setString(5, vo.getExplanation());
			pstmt.setString(6, vo.getAllergy());
			pstmt.setString(7, vo.getOrigin());
			pstmt.setString(8, vo.getMenuPhoto());
			pstmt.executeUpdate();
			res= 1;
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setMenuInsert) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	
	return res;
}
	
	// 메뉴 리스트 가져오기 (AdminMenuListOKCommand)
	public ArrayList<Kn_MenuVO> getMenuList() {
		ArrayList<Kn_MenuVO> vos = new ArrayList<>();
		
		try {
			sql = "select *, "
					+ "(select count(*) from kn_menuReply where menuIdx = m.idx) as replyCount"
					+ " from kn_menu m";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Kn_MenuVO vo = new Kn_MenuVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setCategory(rs.getString("category"));
				vo.setMenuName(rs.getString("menuName"));
				vo.setMenuEngName(rs.getString("menuEngName"));
				vo.setPrice(rs.getInt("price"));
				vo.setExplanation(rs.getString("explanation"));
				vo.setAllergy(rs.getString("allergy"));
				vo.setOrigin(rs.getString("origin"));
				vo.setMenuPhoto(rs.getString("menuPhoto"));
				vo.setMenuRate(rs.getInt("menuRate"));
				vo.setMenuStartDate(rs.getString("menuStartDate"));
				vo.setMenuOpen(rs.getString("menuOpen"));
				vo.setMenuDel(rs.getString("menuDel"));
				
				// 댓글 개수 확인용
				vo.setReplyCount(rs.getInt("replyCount"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러(getMenuList) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 메뉴 삭제 (AdminMenuDelOkCommand)
	public String setMenuDelOk(int idx) {
		String res = "0";
		
		try {
			sql = "delete from kn_menu where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setMenuDelOk) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	
		return res;
	}
	
	// 메뉴 공개/ 비공개 (AdminMenuOpenCloseOKCommand)
	public String setMenuOpenClose(int idx, String sw) {
		String res = "0";
		
		try {
			sql = "update kn_menu set menuOpen=?, menuStartDate=now() where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sw);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setMenuOpenClose) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 메뉴 수정 (AdminMenuModifyCommand)
	public String setMenuModify(Kn_MenuVO vo) {
		String res = "0";
		
		// 총 평점은 수정이 불가능합니다. 
		try {
			sql = "update kn_menu set category=?, menuName=?, menuEngName=?, price=?, explanation=?,"
					+ "allergy=?, origin=?, menuPhoto=?, menuStartDate=? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getCategory());
			pstmt.setString(2, vo.getMenuName());
			pstmt.setString(3, vo.getMenuEngName());
			pstmt.setInt(4, vo.getPrice());
			pstmt.setString(5, vo.getExplanation());
			pstmt.setString(6, vo.getAllergy());
			pstmt.setString(7, vo.getOrigin());
			pstmt.setString(8, vo.getMenuPhoto());
			pstmt.setString(9, vo.getMenuStartDate());
			pstmt.setInt(10, vo.getIdx());
			pstmt.executeUpdate();
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setMenuModify) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 매장 리스트 가져오기 (AdminStoreListOkCommand)
	public ArrayList<Kn_StoreVO> getStoreList() {
		ArrayList<Kn_StoreVO> vos = new ArrayList<>();
		
		try {
			sql = "select *, "
					+ "(select count(*) from kn_storeReply where storeIdx = s.idx) as replyCount"
					+ " from kn_store s";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Kn_StoreVO vo = new Kn_StoreVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMemIdx(rs.getInt("memIdx"));
				vo.setStoreName(rs.getString("storeName"));
				vo.setStoreTel(rs.getString("storeTel"));
				vo.setStoreAddress(rs.getString("storeAddress"));
				vo.setStorePhoto(rs.getString("storePhoto"));
				vo.setLocation(rs.getString("location"));
				vo.setOpHour(rs.getString("opHour"));
				vo.setStoreMenu(rs.getString("storeMenu"));
				vo.setStoreRate(rs.getString("storeRate"));
				vo.setStoreModify(rs.getString("storeModify"));
				vo.setStoreOpen(rs.getString("storeOpen"));
				vo.setStoreDel(rs.getString("storeDel"));
				
				// 댓글 개수 확인용
				vo.setReplyCount(rs.getInt("replyCount"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러(getStoreList) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 매장 삭제 승인 (AdminStoreDelOKCommand)
	public String setStoreDelOk(int idx) {
		String res = "0";
		
		try {
			sql = "delete from kn_store where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setStoreDelOk) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
		return res;
	}

	// 매장 공개/비공개 (AdminStoreOpenCloseOKCommand)
	public String setStoreOpenClose(int idx, String sw, String location) {
		String res = "0";
		
		try {
			sql = "update kn_store set storeOpen=?, location=? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sw);
			pstmt.setString(2, location);
			pstmt.setInt(3, idx);
			pstmt.executeUpdate();
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setStoreOpenClose) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 쿠폰 전체 리스트 가져오기 (AdminCouponList)
	public ArrayList<Kn_CouponVO> getCouponList() {
ArrayList<Kn_CouponVO> vos = new ArrayList<>();
		
		try {
			sql = "select *, "
					+ "(select level from kn_member where mid = c.memMid) as level, "
					+ "(select levelExpireDate from kn_member where mid = c.memMid) as levelExpireDate "
					+ " from kn_coupon c";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Kn_CouponVO vo = new Kn_CouponVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMemMid(rs.getString("memMid"));
				vo.setCoupon(rs.getInt("coupon"));
				vo.setCouponStartDate(rs.getString("couponStartDate"));
				vo.setCouponExpireDate(rs.getString("couponExpireDate"));
				vo.setCouponDel(rs.getString("couponDel"));
				vo.setCouponUsed(rs.getString("couponUsed"));
				vo.setCouponUsedDate(rs.getString("couponUsedDate"));
				
				// 관리자창 확인용
				vo.setLevel(rs.getInt("level"));
				vo.setLevelExpireDate(rs.getString("levelExpireDate"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러(getCouponList) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 쿠폰 삭제 처리
	public String setCouponDelOk(int idx) {
		String res = "0";
		
		try {
			sql = "delete from kn_coupon where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setCouponDelOk) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
		return res;
	}

	// 총 회원 수 구하기 (AdminContentCommand)
	public int getMemNum() {
		int getMemNum = 0;
		
		try {
			sql = "select count(*) from kn_member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				getMemNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류(getMemNum) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return getMemNum;
	}

	// 총 예약 수 구하기 (AdminContentCommand)
	public int getResvNum() {
		int resvNum = 0;
		
		try {
			sql = "select count(*) from kn_reservation";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				resvNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류(getResvNum) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return resvNum;
	}

	// 총 매장 수 구하기 (AdminContentCommand)
	public int getStoreNum() {
		int storeNum = 0;
		
		try {
			sql = "select count(*) from kn_store";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				storeNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류(getStoreNum) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return storeNum;
	}

	// 총 메뉴 수 구하기 (AdminContentCommand)
	public int getMenuNum() {
		int menuNum = 0;
		
		try {
			sql = "select count(*) from kn_menu";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				menuNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류(getMenuNum) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return menuNum;
	}

	// 총 메뉴 댓글 수 구하기 (AdminContentCommand)
	public int getMenuReplyNum() {
		int menuReplyNum = 0;
		
		try {
			sql = "select count(*) from kn_menuReply";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				menuReplyNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류(getMenuReplyNum) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return menuReplyNum;
	}

	// 총 매장 댓글 수 구하기 (AdminContentCommand)
	public int getStoreReplyNum() {
		int storeReplyNum = 0;
		
		try {
			sql = "select count(*) from kn_storeReply";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				storeReplyNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류(getStoreReplyNum) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return storeReplyNum;
	}

	// 신규 회원
	public ArrayList<Kn_MemberVO> getStatMemberList() {
		ArrayList<Kn_MemberVO> vos = new ArrayList<>();
		
		try {
			sql = "select * from kn_member order by idx desc limit 5";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Kn_MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setMemType(rs.getString("memType"));
				vo.setFirstVisit(rs.getString("firstVisit"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러(getStatMemberList) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 신규 예약
	public ArrayList<Kn_ResvVO> getStatResvList() {
		ArrayList<Kn_ResvVO> vos = new ArrayList<>();
		
		try {
			sql = "select *, "
		      + " (select storeName from kn_store s where s.idx = r.storeIdx) as storeName, "
				  + " (select menuName from kn_menu m where m.idx = r.menuIdx) as menuName " 
		      + " from kn_reservation r order by idx desc limit 5";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Kn_ResvVO vo = new Kn_ResvVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMemMid(rs.getString("memMid"));
				vo.setPickupDate(rs.getString("pickupDate"));
				vo.setPickupOk(rs.getString("pickupOk"));
				
				vo.setStoreName(rs.getString("storeName"));
				vo.setMenuName(rs.getString("menuName"));
				
				vos.add(vo);
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류(getStatResvList) :" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		
		return vos;
	}

	// 신규 매장
	public ArrayList<Kn_StoreVO> getStatStoreList() {
		ArrayList<Kn_StoreVO> vos = new ArrayList<>();
		
		try {
			sql = "select * from kn_store order by idx desc limit 5";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Kn_StoreVO vo = new Kn_StoreVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setStoreName(rs.getString("storeName"));
				vo.setStoreTel(rs.getString("storeTel"));
				vo.setStoreRate(rs.getString("storeRate"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러(getStatStoreList) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 예약 리스트 (AdminResvListOKCommand)
	public ArrayList<Kn_ResvVO> getResvList() {
		ArrayList<Kn_ResvVO> vos = new ArrayList<>();
		
		try {
			sql = "select *, "
		      + " (select storeName from kn_store s where s.idx = r.storeIdx) as storeName, "
				  + " (select menuName from kn_menu m where m.idx = r.menuIdx) as menuName " 
		      + " from kn_reservation r";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Kn_ResvVO vo = new Kn_ResvVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMemMid(rs.getString("memMid"));
				vo.setStoreIdx(rs.getInt("storeIdx"));
				vo.setMenuIdx(rs.getInt("menuIdx"));
				vo.setCouponIdx(rs.getInt("couponIdx"));
				vo.setMenuCnt(rs.getInt("menuCnt"));
				vo.setMenuPrice(rs.getInt("menuPrice"));
				vo.setPickupDate(rs.getString("pickupDate"));
				vo.setPickupOk(rs.getString("pickupOk"));
				
				vo.setStoreName(rs.getString("storeName"));
				vo.setMenuName(rs.getString("menuName"));
				
				vos.add(vo);
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류(getResvList) :" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		
		return vos;
	}

	// 예약 삭제 (AdminResvDelOk)
	public String setResvDelOk(int idx) {
		String res = "0";
		
		try {
			sql = "delete from kn_reservation where idx = ?";
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

	// 메뉴 댓글 리스트 (AdminMenuReplyOKCommand)
	public ArrayList<Kn_MenuReplyVO> getMenuReplyList() {
		ArrayList<Kn_MenuReplyVO> replyVos = new ArrayList<>();
		 
		try {
			sql = "select * from kn_menuReply";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Kn_MenuReplyVO replyVo = new Kn_MenuReplyVO();
				replyVo.setIdx(rs.getInt("idx"));
				replyVo.setMenuIdx(rs.getInt("menuIdx"));
				replyVo.setMemMid(rs.getString("memMid"));
				replyVo.setM_ReplyContent(rs.getString("m_ReplyContent"));
				replyVo.setM_ReplyRate(rs.getInt("m_ReplyRate"));
				replyVo.setM_ReplyGood(rs.getInt("m_ReplyGood"));
				replyVo.setM_ReplyPhoto(rs.getString("m_ReplyPhoto"));
				replyVo.setM_ReplyDate(rs.getString("m_ReplyDate"));
				replyVo.setM_ReplyHostIp(rs.getString("m_ReplyHostIp"));
				
				replyVos.add(replyVo);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(getMenuReplyList) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return replyVos;
	}

	// 매장 댓글 리스트 (AdminStoreReplyOKCommand)	
	public ArrayList<Kn_StoreReplyVO> getStoreReplyList() {
		ArrayList<Kn_StoreReplyVO> replyVos = new ArrayList<>();
		
		try {
			sql = "select * from kn_storeReply";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Kn_StoreReplyVO replyVo = new Kn_StoreReplyVO();
				replyVo.setIdx(rs.getInt("idx"));
				replyVo.setStoreIdx(rs.getInt("storeIdx"));
				replyVo.setMemMid(rs.getString("memMid"));
				replyVo.setS_ReplyContent(rs.getString("s_ReplyContent"));
				replyVo.setS_ReplyRate(rs.getInt("s_ReplyRate"));
				replyVo.setS_ReplyGood(rs.getInt("s_ReplyGood"));
				replyVo.setS_ReplyPhoto(rs.getString("s_ReplyPhoto"));
				replyVo.setS_ReplyDate(rs.getString("s_ReplyDate"));
				replyVo.setS_ReplyHostIp(rs.getString("s_ReplyHostIp"));
				
				replyVos.add(replyVo);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(getStoreReplyList) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return replyVos;
	}
	
	
}


