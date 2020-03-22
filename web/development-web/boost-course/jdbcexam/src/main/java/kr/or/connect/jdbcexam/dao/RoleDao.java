package kr.or.connect.jdbcexam.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//import com.mysql.jdbc.PreparedStatement;

import kr.or.connect.jdbcexam.dto.Role;

public class RoleDao {
	private static String driver = "com.mysql.jdbc.Driver";
	private static String url = "jdbc:mysql://localhost:3306/connectdb?useSSL=false";
	private static String dbuser = "connectuser";
	private static String dbpasswd = "connect123!@#";
	
	// role 의 모든 정보를 조회해서 반환받을수 있도록 하는 메소드
	public List<Role> getRoles() {
		List<Role> list = new ArrayList<>();
		
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		String sql = "SELECT description, role_id FROM role order by role_id desc";
		
		// try with resource	 . try문 진입시 객체 생성 이후 종료되면서 삭제된다.
		try (Connection conn = DriverManager.getConnection(url, dbuser, dbpasswd);
				PreparedStatement ps = conn.prepareStatement(sql)) {
				
			try (ResultSet rs = ps.executeQuery()) {
				while(rs.next()) {
					String description = rs.getString(1);
					int id = rs.getInt("role_id");
					
					Role role = new Role(id, description);
					list.add(role);		// list에 반복될 마다 Role 인스턴스를 생성하여 추가한다.
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
		
	} // getRoles
	
	
	public int addRole(Role role) {
		int insertCount = 0;
		
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbuser, dbpasswd);
			String sql = "INSERT INTO role (role_id, description) VALUES (?, ?)";		// 가변적으로 변하는 부분은 ?를통해 유기적으로 변경
			
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, role.getRoleId());					// 쿼리의 물음표 부분을 초기화해주는 부분 
			ps.setString(2, role.getDescription());			// 쿼리의 물음표 부분을 초기화해주는 부분 
			//addRole 메소드의 인자로 넘어온 role 객체의 Id 와 Description을 넣어주는 것.
			
			insertCount = ps.executeUpdate();
			// select 는 .executeQuery() 메서드를 사용했는데 Insert, Update, Delete는 executeUpdate() 라는 메서드를 사용한다.
		
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (Exception ex) {}
			}	//if
			
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception ex) {}
			}	//if
		}	//finally
	
		return insertCount;
	}
	
	
	
	//데이터를 가져왔을때 Role 이라는 개체를 가져올것이니 반환형은 Role ,인자는 primary-key roleid 
	public Role getRole(Integer roleId) {
		Role role = null;
		Connection conn = null;				// 커넥션 연결용 객
		java.sql.PreparedStatement ps = null;		// 명령을 수행하기 위한 statement 객
		ResultSet rs = null;				// 결과값을 담아낼 객체 ResultSet 
		
		// 예외처리 
		try {
			// Driver load
			Class.forName(driver); 		// 1. 드라이버 로딩 
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
