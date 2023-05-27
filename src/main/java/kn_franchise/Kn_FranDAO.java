package kn_franchise;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import kn_menu.Kn_MenuVO;
import kn_reservation.Kn_ResvVO;
import kn_store.Kn_StoreReplyVO;
import kn_store.Kn_StoreVO;

public class Kn_FranDAO {

	// 싱글톤으로 선언된 DB연결 객체(GetConn)을 연결
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	
	Kn_StoreVO vo = null;


	// 매장 정보 가져오기 (FranInfoModify)
	public Kn_StoreVO getFranInfo(int memIdx) {
		Kn_StoreVO vo = new Kn_StoreVO();
		try {
			sql = "select *, (select count(*) from kn_storeReply where storeIdx = s.idx) as replyCount "
					+ "from kn_store s where memIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memIdx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
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
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러(getFranInfo) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 전체 메뉴 가져오기 (FranInfoModify)
	public ArrayList<Kn_MenuVO> getMenuList() {
		ArrayList<Kn_MenuVO> vos = new ArrayList<>();
		
		try {
			sql = "select category, menuName from kn_menu";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Kn_MenuVO vo = new Kn_MenuVO();
				vo.setCategory(rs.getString("category"));
				vo.setMenuName(rs.getString("menuName"));
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(getMenuList) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	
	// 매장 정보 수정 (매장 회원이 직접) (FranStoreInfoModifyOkCommand)
	public int setStoreModify(Kn_StoreVO vo) {
		int res = 0;
		
		try {
			sql = "update kn_store set storeTel=?, storeAddress=?, opHour=?, storeMenu=?, storeModify='OFF', storePhoto=?  where storeName = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getStoreTel());
			pstmt.setString(2, vo.getStoreAddress());
			pstmt.setString(3, vo.getOpHour());
			pstmt.setString(4, vo.getStoreMenu());
			pstmt.setString(5, vo.getStorePhoto());
			pstmt.setString(6, vo.getStoreName());
			pstmt.executeUpdate();
			res= 1;
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(setStoreModify) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 매장 삭제처리(실제 삭제는 1달 후) (FranStoreDelCommand)
	public int franStoreDel(int memIdx) {
		int res = 0;
		
		try {
			sql = "update kn_store set storeDel='OK' where memIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memIdx);
			pstmt.executeUpdate();
			res= 1;
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(franStoreDel) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 매장 회원 삭제처리(실제 삭제는 1달 후) (FranStoreDelCommand)
	public int franMemDel(int memIdx) {
		int res = 0;
		
		try {
			sql = "update kn_member set memberDel='OK' where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memIdx);
			pstmt.executeUpdate();
			res= 1;
			
		} catch (SQLException e) {
			System.out.println("SQL 에러(franMemDel) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	
	// 매장 알아내기 (FranStoreReplyOKCommand)	
	public int getStoreIdx(int memIdx) {
		int storeIdx = 0;
		
		try {
			sql = "select idx from kn_store where memIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memIdx);
			rs = pstmt.executeQuery();		
			
			if(rs.next()) {
				storeIdx = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(getStoreIdx) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return storeIdx;
	}
	

	// 매장 댓글 리스트 (FranStoreReplyOKCommand)	
	public ArrayList<Kn_StoreReplyVO> getStoreReplyList(int storeIdx) {
		ArrayList<Kn_StoreReplyVO> replyVos = new ArrayList<>();
		
		try {
			sql = "select * from kn_storeReply where storeIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, storeIdx);
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

	// 매장 예약 리스트 (FranResvListOkCommand)
	public ArrayList<Kn_ResvVO> getResvList(int storeIdx) {
		ArrayList<Kn_ResvVO> vos = new ArrayList<>();
		
		try {
			sql = "select *, "
		      + " (select storeName from kn_store s where s.idx = r.storeIdx) as storeName, "
				  + " (select menuName from kn_menu m where m.idx = r.menuIdx) as menuName " 
		      + " from kn_reservation r where storeIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, storeIdx);
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

	// 매장 픽업 승인
	public String setResvOk(int idx) {
		String res = "0";
		
		try {
			sql = "update kn_reservation set pickupOk='OK', pickupDate=now() where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setResvOk) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
		return res;
	}
	
	


}