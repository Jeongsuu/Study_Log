package kr.or.connect.jdbcexam.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.PreparedStatement;

import kr.or.connect.jdbcexam.dto.Role;

public class RoleDao {
	
	private static String url = "jdbc:mysql://localhost:3306/connectdb?useSSL=false";
	private static String dbuser = "connectuser";
	private static String dbpasswd = "connect123!@#";
	
	//데이터를 가져왔을때 Role 이라는 개체를 가져올것이니 반환형은 Role ,인자는 primary-key roleid 
	public Role getRole(Integer roleId) {
		Role role = null;
		Connection conn = null;				// 커넥션 연결용 객
		java.sql.PreparedStatement ps = null;		// 명령을 수행하기 위한 statement 객
		ResultSet rs = null;				// 결과값을 담아낼 객체 ResultSet 
		
		// 예외처리 
		try {
			// Driver load
			Class.forName("com.mysql.jdbc.Driver"); 		// 1. 드라이버 로딩 
			// get the Connection object 
			conn = DriverManager.getConnection(url, dbuser, dbpasswd);	// 2. connection 연결을 통해 객체 생성. 
			// 접속할 수 있는 connection객체를 얻어왔다.
			String sql = "SELECT description,role_id FROM role WHERE role_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, roleId);
			rs = ps.executeQuery();		// query 실행하여 결과값을 rs 객체에 담아온다.
			
			if(rs.next()) {
				String description = rs.getString(1);		// 전송한 쿼리중 첫번째 값 description 가져오기.
				int id = rs.getInt("role_id");				// 전송한 쿼리중 두번째 값 role_id 값 가져오기. 칼럼명으로도 가져올 수 있음.
				
				role = new Role(id,description);			// role 객체를 생성하면서 값 초기화.
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {		// ResultSet 객체 close
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {				// PreparedStatement 객체 close  
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {		// Connection 객체 close 
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}


		}
		
		
		return role;
	}
}
