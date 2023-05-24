package kn_store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import kn_menu.Kn_MenuReplyVO;
import kn_menu.Kn_MenuVO;

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

	// 매장 리스트 가져오기 (StoreListCommand, ResvContentCommand) 
	public ArrayList<Kn_StoreVO> getStoreList() {
		ArrayList<Kn_StoreVO> vos = new ArrayList<>();
		
		try {
			sql = "select *, "
					+ "(select count(*) from kn_storeReply where storeIdx = s.idx) as replyCount"
					+ " from kn_store s where storeOpen='OK'";
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

	// 매장 검색 (StoreSearchCommand)
	public ArrayList<Kn_StoreVO> getStoreSearch(String searchString) {
		ArrayList<Kn_StoreVO> vos = new ArrayList<>();
		
		try {
			sql = "select *, "
					+ "(select count(*) from kn_storeReply where storeIdx = s.idx) as replyCount"
					+ " from kn_store s where storeOpen='OK' and storeName like ? order by idx";
			
			pstmt = conn.prepareStatement(sql);      
			pstmt.setString(1, "%"+searchString+"%");
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
			System.out.println("SQL 오류(getStoreSearch) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 매장 상세 페이지 (StoreContentCommand)
	public Kn_StoreVO getStoreContent(int idx) {
		Kn_StoreVO vo = new Kn_StoreVO();
		try {
			sql = "select *, (select count(*) from kn_storeReply where storeIdx = s.idx) as replyCount"
					+ " from kn_store s where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			
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
			
			// 댓글 개수
			vo.setReplyCount(rs.getInt("replyCount"));	
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(getStoreContent) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 매장에 달린 댓글 (StoreContentCommand)
	public ArrayList<Kn_StoreReplyVO> getStoreReply(int idx) {
		ArrayList<Kn_StoreReplyVO> replyVos = new ArrayList<>();
		
		try {
			sql = "select * from kn_storeReply where storeIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
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
			System.out.println("SQL 오류(getStoreReply) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return replyVos;
	}

	// 댓글 등록 (StoreReplyInputCommand)
	public String setStoreReply(Kn_StoreReplyVO vo) {
		String res = "0";
		try {
			sql = "insert into kn_storeReply values (default,?,?,?,?,default,?,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getStoreIdx());
			pstmt.setString(2, vo.getMemMid());
			pstmt.setString(3, vo.getS_ReplyContent());
			pstmt.setInt(4, vo.getS_ReplyRate());
			pstmt.setString(5, vo.getS_ReplyPhoto());
			pstmt.setString(6, vo.getS_ReplyHostIp());

			pstmt.executeUpdate();
			res = "1";
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setStoreReply) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	//해당 매장의 총 평점 개수와 합 구하기 (StoreReplyInputCommand)
	public Kn_StoreReplyVO getTotStoreRate(int storeIdx) {
		Kn_StoreReplyVO vo = new Kn_StoreReplyVO();
		
		try {
			sql = "select count(*) as rateCnt, sum(s_ReplyRate) as rateTot from kn_storeReply where storeIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, storeIdx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setStoreRateCnt(rs.getInt("rateCnt"));
				vo.setStoreRateTot(rs.getInt("rateTot"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류(getTotStoreRate) : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 매장 총 평점 수정 (StoreReplyInputCommand)
	public void setStoreRate(int storeRate, int storeIdx) {
		try {
			sql = "update kn_store set storeRate=? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, storeRate);
			pstmt.setInt(2, storeIdx);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setStoreRate) : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 댓글 삭제	
	public String setReplyDelete(int replyIdx) {
		String res = "0";
		try {
			sql = "delete from kn_storeReply where idx=?";
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

	// 매장 댓글 좋아요 증가
	public void setGoodUpdate(int idx) {
		try {
			sql = "update kn_storeReply set s_ReplyGood = s_ReplyGood+1 where idx = ?";
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