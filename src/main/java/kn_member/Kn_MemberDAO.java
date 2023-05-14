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
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setEmail(rs.getString("email"));
				vo.setLevel(rs.getInt("level"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	
	// 회원가입 
	public int setMemberJoin(Kn_MemberVO vo) {
		int res = 0;
		try {
			sql = "insert into kn_member values (default,?,?,?,?,?,?,?,?,?,default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getName());
			pstmt.setString(5, vo.getTel());
			pstmt.setString(6, vo.getEmail());
			pstmt.setString(7, vo.getAddress());
			pstmt.setString(8, vo.getGender());
			pstmt.setString(9, vo.getBirthday());
			
			pstmt.executeUpdate();
			res = 1;
		
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	//(로그인 확인용 메소드 들어갈 자리!!)
	
	// 로그인 시, point증가, todayCnt 증가, visitCnt 증가, lastDate 변경
	// point용 table 따로 만들 예정이라 이건 사용 안 할 듯
	public void setPointPlus(String mid, int point, int todayCount) {
		try {
      sql = "update kn_member set point=?, lastDate=now(), todayCount=?, lastDate=now() where mid=?";
      pstmt = conn.prepareStatement(sql);
	  	pstmt.setInt(1, point);
	  	pstmt.setInt(2, todayCount);
  		pstmt.setString(3, mid);
 	  	pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}
}