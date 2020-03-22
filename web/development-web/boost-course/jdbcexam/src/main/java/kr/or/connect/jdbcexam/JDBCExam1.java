package kr.or.connect.jdbcexam;
import kr.or.connect.jdbcexam.dto.Role;
import kr.or.connect.jdbcexam.dao.RoleDao;

public class JDBCExam1 {
	
	public static void main(String[] args) {
		
		RoleDao dao = new RoleDao();		// RoleDao 객체 생성
		Role role = dao.getRole(100);		// RoleDao 클래스가 가지고 있는 메소드 getRole 호출. RoleID는 100
		
		System.out.println(role);
	}
}
