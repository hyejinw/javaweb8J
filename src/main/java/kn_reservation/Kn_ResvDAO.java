package kn_reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class Kn_ResvDAO {

	// 싱글톤으로 선언된 DB연결 객체(GetConn)을 연결
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	Kn_CartVO vo = null;

	// 장바구니에 집어넣기
	public String setCart(Kn_CartVO vo) {
		String res = "0";
		
		try {
			sql = "insert into kn_cart values (default,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMemMid());
			pstmt.setInt(2, vo.getStoreIdx());
			pstmt.setInt(3, vo.getMenuIdx());
			pstmt.setInt(4, vo.getMenuCnt());
			pstmt.setInt(5, vo.getMenuPrice());
			pstmt.setString(6, vo.getPickupDate());
			pstmt.executeUpdate();
			res = "1";
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setCart) :" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 같은 아이디를 가진 장바구니 내역 가져오기 (CartCommand)
	public ArrayList<Kn_CartVO> getCartList(String memMid) {
		ArrayList<Kn_CartVO> vos = new ArrayList<>();
		
		try {
			/*
			 * sql = "select *, " +
			 * "(select storeName from kn_store s where s.idx = c.storeIdx) as storeName and "
			 * + "(select menuName form kn_menu m where m.idx = c.menuIdx) as menuName " +
			 * "from kn_cart c where memMid = ?";
			 */	
			/*
			 * sql = "select *, " +
			 * "(select storeName from kn_store s where s.idx = c.storeIdx) as storeName " +
			 * "from kn_cart c where memMid = ?";
			 */
			sql = "select *, "
			      + " (select storeName from kn_store s where s.idx = c.storeIdx) as storeName, "
					  + " (select menuName from kn_menu m where m.idx = c.menuIdx) as menuName " 
			      + " from kn_cart c where memMid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memMid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Kn_CartVO vo = new Kn_CartVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMemMid(rs.getString("memMid"));
				vo.setStoreIdx(rs.getInt("storeIdx"));
				vo.setMenuIdx(rs.getInt("menuIdx"));
				vo.setMenuCnt(rs.getInt("menuCnt"));
				vo.setMenuPrice(rs.getInt("menuPrice"));
				vo.setPickupDate(rs.getString("pickupDate"));
				
				vo.setStoreName(rs.getString("storeName"));
				vo.setMenuName(rs.getString("menuName"));
				
				vos.add(vo);
			}
					
		} catch (SQLException e) {
			System.out.println("SQL 오류(getCartList) :" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 총 합계액 구하기 (CartCommand)
	public int getCartTotPrice(String memMid) {
		int totMenuPrice = 0;
		
		try {
			sql = "select sum(menuPrice) as totMenuPrice from kn_cart where memMid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memMid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totMenuPrice = rs.getInt(1);   // 오호~!
			}
					
		} catch (SQLException e) {
			System.out.println("SQL 오류(getCartTotPrice) :" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totMenuPrice;
	}

	// 이미 장바구니에 담긴 같은 상품(같은 아이디, 같은 매장, 같은 예약 시간)이 있는지 조회
	public Kn_CartVO getCartCheck(int menuIdx, String memMid, int storeIdx, String pickupDate) {
		Kn_CartVO vo = new Kn_CartVO();
		
		try {
			sql = "select * from kn_cart where menuIdx=? and memMid=? and storeIdx=? and pickupDate=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, menuIdx);
			pstmt.setString(2, memMid);
			pstmt.setInt(3, storeIdx);
			pstmt.setString(4, pickupDate);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMemMid(rs.getString("memMid"));
				vo.setStoreIdx(rs.getInt("storeIdx"));
				vo.setMenuIdx(rs.getInt("menuIdx"));
				vo.setMenuCnt(rs.getInt("menuCnt"));
				vo.setMenuPrice(rs.getInt("menuPrice"));
				vo.setPickupDate(rs.getString("pickupDate"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류(getCartCheck) :" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 이미 장바구니에 담겼다면 같은 상품을 다시 담을 땐, 개수만 증가
	public String setDoubleCart(Kn_CartVO vo, int idx) {
		String res = "0";
		
		try {
			sql = "update kn_cart set menuCnt = menuCnt+? where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getMenuCnt());
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
			res = "1";
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setDoubleCart) :" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 장바구니 삭제
	public String setCartDel(String memMid) {
		String res = "0";
		
		try {
			sql = "delete from kn_cart where memMid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memMid);
			pstmt.executeUpdate();
			res = "1";
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setCartDel) :" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	

	
	
	
}