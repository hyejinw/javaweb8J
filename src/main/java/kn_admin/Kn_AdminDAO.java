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


	// 전체 회원 리스트 가져오기
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



}