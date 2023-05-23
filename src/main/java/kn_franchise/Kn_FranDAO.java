package kn_franchise;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import kn_member.Kn_MemberVO;
import kn_menu.Kn_MenuVO;
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

	


}