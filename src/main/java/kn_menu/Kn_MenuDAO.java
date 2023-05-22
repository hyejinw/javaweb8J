package kn_menu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class Kn_MenuDAO {

	// 싱글톤으로 선언된 DB연결 객체(GetConn)을 연결
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	
	Kn_MenuVO vo = null;


	// 총 메뉴 개수 구하기 (MenuListCommand)
	public int getTotMenuCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as cnt from kn_menu where menuOpen='OK'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(getTotMenuCnt) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}


	// 한 페이지 분량의 메뉴 리스트 가져오기 (MenuListCommand)
	public ArrayList<Kn_MenuVO> getMenuList(int startIndexNo, int pageSize, String part) {
		ArrayList<Kn_MenuVO> vos = new ArrayList<>();
		
		try {
			if(part.equals("전체")) {
				sql = "select *, timestampdiff(hour, menuStartDate, now()) as hour_diff, datediff(now(), menuStartDate) as day_diff, "
						+ "(select count(*) from kn_menuReply where menuIdx = m.idx) as replyCount "
						+ "from kn_menu m where menuOpen='OK' order by idx asc limit ?,?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			
			else {
				sql = "select *, timestampdiff(hour, menuStartDate, now()) as hour_diff, datediff(now(), menuStartDate) as day_diff, "
						+ "(select count(*) from kn_menuReply where menuIdx = m.idx) as replyCount "
						+ "from kn_menu m where menuOpen='OK' and category=? order by idx asc limit ?,?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, part);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Kn_MenuVO();
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
				
				// 게시글 시간 차이 계산용
				vo.setHour_diff(rs.getInt("hour_diff"));
				// 게시글 날짜 차이 계산용
				vo.setDay_diff(rs.getInt("day_diff"));
				// 댓글 개수
				vo.setReplyCount(rs.getInt("replyCount"));
				
				vos.add(vo);
			}			
		} catch (SQLException e) {
			System.out.println("SQL 오류(getMenuList) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}


	// 검색한 내용 전체 개수 구하기 (MenuSearchCommand)
	public int getTotMenuSearchCnt(String searchString) {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as cnt from kn_menu where menuOpen='OK' and menuName like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchString+"%");
			rs = pstmt.executeQuery();
			
			rs.next();
			totRecCnt = rs.getInt("cnt");
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(getTotMenuSearchCnt) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	// 찐 검색 (MenuSearchCommand)
	public ArrayList<Kn_MenuVO> getMenuSearch(int startIndexNo, int pageSize, String searchString) {
		ArrayList<Kn_MenuVO> vos = new ArrayList<>();
		try {
			sql = "select *,timestampdiff(hour, menuStartDate, now()) as hour_diff, datediff(now(), menuStartDate) as day_diff, "
					+ "(select count(*) from kn_menuReply where menuIdx = m.idx) as replyCount "
					+ " from kn_menu m where menuOpen='OK' and menuName like ? order by idx asc limit ?,?";
			pstmt = conn.prepareStatement(sql);      
			pstmt.setString(1, "%"+searchString+"%");   // ?는 변수가 아닌 '값'에만!!! 넣는 것이다!!!!!
			pstmt.setInt(2, startIndexNo);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Kn_MenuVO();
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
				
				// 게시글 시간 차이 계산용
				vo.setHour_diff(rs.getInt("hour_diff"));
				// 게시글 날짜 차이 계산용
				vo.setDay_diff(rs.getInt("day_diff"));
				// 댓글 개수
				vo.setReplyCount(rs.getInt("replyCount"));				
				
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(getMenuSearch) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 메뉴 상세 페이지 (MenuContentCommand)
	public Kn_MenuVO getMenuContent(int idx) {
		Kn_MenuVO vo = new Kn_MenuVO();
		try {
			sql = "select *, (select count(*) from kn_menuReply where menuIdx = m.idx) as replyCount"
					+ " from kn_menu m where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			
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
			// 댓글 개수
			vo.setReplyCount(rs.getInt("replyCount"));	
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(getMenuContent) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}


	// 메뉴에 달린 댓글 (MenuContentCommand)
	public ArrayList<Kn_MenuReplyVO> getMenuReply(int idx) {
		ArrayList<Kn_MenuReplyVO> replyVos = new ArrayList<>();
		 
		try {
			sql = "select * from kn_menuReply where menuIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
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
			System.out.println("SQL 오류(getMenuReply) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return replyVos;
	}


	// 댓글 삭제
	public String setReplyDelete(int replyIdx) {
		String res = "0";
		try {
			sql = "delete from kn_menuReply where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyIdx);
			pstmt.executeUpdate();
			res = "1"; 
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setReplyDelete) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}


	// 댓글 등록 (MenuReplyInputCommand)
	public String setMenuReply(Kn_MenuReplyVO vo) {
		String res = "0";
		try {
			sql = "insert into kn_menuReply values (default,?,?,?,?,default,?,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getMenuIdx());
			pstmt.setString(2, vo.getMemMid());
			pstmt.setString(3, vo.getM_ReplyContent());
			pstmt.setInt(4, vo.getM_ReplyRate());
			pstmt.setString(5, vo.getM_ReplyPhoto());
			pstmt.setString(6, vo.getM_ReplyHostIp());

			pstmt.executeUpdate();
			res = "1";
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setMenuReply) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 해당 메뉴의 총 평점 개수와 합 구하기 (MenuReplyInputCommand)
	public Kn_MenuReplyVO getTotMenuRate(int menuIdx) {
		Kn_MenuReplyVO vo = new Kn_MenuReplyVO();
		
		try {
			sql = "select count(*) as rateCnt, sum(m_ReplyRate) as rateTot from kn_menuReply where menuIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, menuIdx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setMenuRateCnt(rs.getInt("rateCnt"));
				vo.setMenuRateTot(rs.getInt("rateTot"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류(getTotMenuRate) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 메뉴 총 평점 수정 (MenuReplyInputCommand)
	public void setMenuRate(int menuRate, int menuIdx) {
		try {
			sql = "update kn_menu set menuRate=? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, menuRate);
			pstmt.setInt(2, menuIdx);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setMenuRate) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
	}

	// 메뉴 댓글 좋아요 증가
	public void setGoodUpdate(int idx) {
		try {
			sql = "update kn_menuReply set m_ReplyGood = m_ReplyGood+1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setGoodUpdate) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}
	
	
}