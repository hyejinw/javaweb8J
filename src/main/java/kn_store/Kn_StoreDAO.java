package kn_store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conn.GetConn;

public class Kn_StoreDAO {

	// 싱글톤으로 선언된 DB연결 객체(GetConn)을 연결
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	Kn_StoreVO vo = null;
	

	// 매장명 중복 검사
	public Kn_StoreVO getStoreCheck(String storeName) {
		vo = new Kn_StoreVO();

		try {
			sql = "select * from kn_store where storeName = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, storeName);
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
				vo.setStoreMenu(rs.getString("storeModify"));
				vo.setStoreOpen(rs.getString("storeOpen"));
				vo.setStoreDel(rs.getString("storeDel"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러(getStoreCheck) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}	

	
	// store 생성 (FranJoinOkCommand)
	public void setStore(Kn_StoreVO vo) {
		try {
			sql = "insert into kn_store values (default,?,?,?,?,default,default,default,default,default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
	  	pstmt.setInt(1, vo.getMemIdx());
	  	pstmt.setString(2, vo.getStoreName());
	  	pstmt.setString(3, vo.getStoreTel());
	  	pstmt.setString(4, vo.getStoreAddress());
	  	
 	  	pstmt.executeUpdate();
						
		} catch (SQLException e) {
			System.out.println("SQL 에러(setStore) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
	}




}