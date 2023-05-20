package kn_admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import kn_member.Kn_MemberVO;

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
			sql = "insert into kn_menu values(default,?,?,?,?,?,?,?,?,default,default,default)";
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
			sql = "select * from kn_menu";
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
				vo.setMenuStartDate(rs.getString("menuStartDate"));
				vo.setMenuOpen(rs.getString("menuOpen"));
				vo.setMenuDel(rs.getString("menuDel"));
				
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
			sql = "update kn_menu set menuOpen=? where idx = ?";
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
		System.out.println("왔니");
		
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
			System.out.println("왔다");
			res= "1";
			
		} catch (SQLException e) {
			System.out.println("SQL오류(setMenuModify) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}


}