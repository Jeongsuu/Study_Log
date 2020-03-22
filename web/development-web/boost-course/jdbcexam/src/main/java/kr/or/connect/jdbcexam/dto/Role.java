package kr.or.connect.jdbcexam.dto;

public class Role {
	private Integer roleId;					// 칼럼 두개를 담을 변수를 선언.
	private String description;
	
	public Role() {
		
	}
	
	// 객체 생성자.
	public Role(Integer roleId, String description) {
		super();
		this.roleId = roleId;
		this.description = description;
		
	}
	
	// getter & setter
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public String toString() {
		return "Role [roleId=" + roleId + ", description=" + description + "]";
	}

}
