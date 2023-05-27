package kn_reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.jasper.tagplugins.jstl.core.ForEach;

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

	// 장바구니 메뉴 일부 삭제
	public String setCartMenuDel(int idx) {
		String res = "0";
		
		try {
			sql = "delete from kn_cart where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = "1";
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setCartMenuDel) :" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 쿠폰 리스트 가져오기 (OrderCommand)
	public ArrayList<Kn_CouponVO> getCouponList(String memMid) {
		ArrayList<Kn_CouponVO> vos = new ArrayList<>();
		
		try {
			sql = "select * from kn_coupon where memMid = ? and couponUsed = '미사용'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memMid);
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
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류(getCouponList) :" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}
	
	

//	// 장바구니 상품 중, 가장 비싼 카테고리 제품만 가져오기  (미사용) (OrderCommand)
//	public ArrayList<Kn_CartMenuVO> getCartMenu(String memMid) {
//		ArrayList<Kn_CartMenuVO> vos = new ArrayList<Kn_CartMenuVO>();
//		
//		try {
//			sql = "select *, (select category from kn_menu m1 where m1.idx = c.menuIdx) as category, " 
//				  + "(select menuName from kn_menu m2 where m2.idx = c.menuIdx) as menuName, " 
//				  + "(select price from kn_menu m3 where m3.idx = c.menuIdx) as price " 
//		      + "from kn_cart c where memMid = ? group by menuIdx";
//			
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, memMid);
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				Kn_CartMenuVO vo = new Kn_CartMenuVO();
//				vo.setCategory(rs.getString("category"));
//				vo.setMenuName(rs.getString("menuName"));
//				vo.setPrice(rs.getInt("price"));
//				vos.add(vo);
//			}
//			
//		} catch (SQLException e) {
//			System.out.println("SQL 오류(getCartMenu) :" + e.getMessage());
//		} finally {
//			getConn.rsClose();
//		}
//		return vos;
//	}
	
	

	// 쿠폰 고유번호 가져오기 (OrderCheckCommand)
	public int getCouponIdx(String memMid, int coupon) {
		int couponIdx = 0;
		
		try {
			sql = "select idx from kn_coupon where memMid =? and coupon = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memMid);
			pstmt.setInt(2, coupon);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				couponIdx = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(getCouponIdx) :" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return couponIdx;
	}

	// 장바구니 내역, 예약으로 옮기기 (OrderCheckCommand)
	public String setResvList(ArrayList<Kn_CartVO> vos) {
		String res = "0";
		
		try {
			for(int i=0; i<vos.size(); i++) {
				sql = "insert into kn_reservation (idx,memMid,storeIdx,menuIdx,menuCnt,menuPrice,pickupDate,pickupOk) "
						+ "values (default,?,?,?,?,?,?,default)";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vos.get(i).getMemMid());
				pstmt.setInt(2, vos.get(i).getStoreIdx());
				pstmt.setInt(3, vos.get(i).getMenuIdx());
				pstmt.setInt(4, vos.get(i).getMenuCnt());
				pstmt.setInt(5, vos.get(i).getMenuPrice());
				pstmt.setString(6, vos.get(i).getPickupDate());
				
				pstmt.executeUpdate();
				res = "1";
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setResvList) :" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 쿠폰 내용 넣기
	public void setResvCoupon(int couponIdx, int storeIdx, String pickupDate, int menuIdx) {
		try {
			sql = "update kn_reservation set couponIdx = ? where storeIdx =? and pickupDate = ? and menuIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, couponIdx);
			pstmt.setInt(2, storeIdx);
			pstmt.setString(3, pickupDate);
			pstmt.setInt(4, menuIdx);
			pstmt.executeUpdate();
					
		} catch (SQLException e) {
			System.out.println("SQL 오류(setResvCoupon) :" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
	}

	// 예약 내역 가져오기 (MyPageCommand)
	public ArrayList<Kn_ResvVO> getResvList(String mid) {
		ArrayList<Kn_ResvVO> vos = new ArrayList<>();
		
		try {
			sql = "select *, "
		      + " (select storeName from kn_store s where s.idx = r.storeIdx) as storeName, "
				  + " (select menuName from kn_menu m where m.idx = r.menuIdx) as menuName " 
		      + " from kn_reservation r where memMid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
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

	// 쿠폰 사용했으면 사용으로 업데이트
	public void setCouponUseUpdate(String memMid, int coupon) {
		try {
			sql = "update kn_coupon set couponUsed = '사용', couponUsedDate=now() where memMid=? and coupon=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memMid);
			pstmt.setInt(2, coupon);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setCouponUseUpdate) :" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	
	
	
}