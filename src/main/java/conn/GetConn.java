package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetConn {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private String driver = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/javaweb8";
	private String user = "root";
	private String password = "1234";
	
	// DAO 에서 아래처럼 생성한다.
	// GetConn getConn = GetConn.getInstance();	
	// 1. getInstance() 메소드의 리턴값 GetConn instance를 통해 전체 클래스를 불러온다.
	private static GetConn instance = new GetConn();
	
	// 2. 불러옴과 동시에 database 연동이 된다.
	// 이렇게 한 번만 생성하고 계속 가져다 쓰면, 메모리를 아낄 수 있다.
	// GetConn 객체를 싱글톤으로 사용하고자 한다. 따라서 외부에서 생성할 수 없도록 해야 한다.
	private GetConn() {
	//public GetConn() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패");
		} catch (SQLException e) {
			System.out.println("Database 연동 실패");
		}
	}
	// (DAO에서 쓰는 방식) private Connection conn = getConn.getConn();
	// 3. 리턴값 Connection conn을 통해 connection 을 가져간다.
	// 위에서 private으로 생성자를 만들었기 때문에, 이렇게 해줘야 한다.
	// GetConn 객체를 외부에서 연결해서 사용하기 위한 메소드를 만든다.
	public Connection getConn() {
		return conn;
	}
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
		}
	}

	public void rsClose() {
		if(rs != null ) {
			try {
				rs.close();
				pstmtClose();
			} catch (SQLException e) {}
		}
	}
	
	public static GetConn getInstance() {
		return instance;
	}

}
