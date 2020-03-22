## Maven & JDBC
---

### 학습 목표

1. `maven`의 역할에 대해 이해한다.
---

### 핵심 개념
-   Maven
-   CoC
-   pom.xml
---

<br>

### 학습하기

#### maven이란?
> `Maven`이란 지금까지 애플리케이션을 개발하기 위해 반복적으로 진ㅎ애해왔던 작업들을 지원하기 위하여 등장한 도구다.
> Maven을 이해하기 위해서는 CoC(Convention over Configuration)라는 단어를 먼저 이해해야 한다.
><br>CoC란 일종의 관습을 말하는데 예를 들자면 프로그램의 소스파일은 어떠한 위치에 존재해야 하고, 소스가 컴파일된 파일들을 어떤 위치에 있어야 하고 등의 대한 약속을 미리 정해놨다는 의미이다.
<br>
<br>

## Maven을 이용한 웹 어플리케이션 실습
---

이클립스를 통해 메이븐 프로젝트를 생성한다.

생성시, 아키타입 선택을 해줘야한다.

아키타입이란, 일종의 프로젝트 템플릿으로 어떤 아키타입을 선택했느냐에 따라 자동으로, 여러가지 파일들을 생성하거나 라이브러리를 셋팅해주거나 등의 일을 해준다.
`maven`을 이용하여 웹 어플리케이션을 개발하기 위해서 `maven-archtype-webapp`을 선택한다.

![image](https://user-images.githubusercontent.com/33051018/77226341-ef3c0a80-6bba-11ea-9db0-268b5fabe0a2.png)

Groud ID는 보통 프로젝트를 진행하는 회사나 팀의 도메인을 거꾸로 기재한다.
Artifact ID는 해당 프로젝트의 이름을 적는다.

<br>

## JDBC란?
---

`JAVA` 언어를 이용해 `DBMS`로 부터 정보를 조회하는 방법인 JDBC에 대해 알아본다.
JDBC : Java Database Connectivity

-   자바를 이용한 데이터베이스 접속과 SQL 문장의 실행, 그리고 실행 결과로 얻어진 데이터의 핸들링을 제공하는 방법과 절차에 관한 규약

**JDBC 사용 - 단계별 설명**

1. IMPORT
-   import java.sql.*;

2. 드라이버 로드
-   Class.forname("com.mysql.jdbc.Driver");

3.  Connection 객체 얻기
-   String dburl = "jdbc:mysql://localhost/dbName;
-   Connection con = DriverManager.getConnection(dburl, ID, PWD);

Connection 객체는 `DriverManager` 객체를 통해 얻어온다.

`connection 객체 획득 소스코드 예시`

```java
public static Connection getConnection() throws Exceiption{
    String url = "jdbc:oracle:thin:@117.16.46.111:1521:xe";
    String user = "smu";
    String password = "smu";
    Conneciton conn = null;
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = Drivermanager.getConnection(url, user, pasword);
    return conn;
}
```

<br>
**JDBC사용 - 단게별 설명 2**

DB connection 객체를 얻어왔다 -> DB와의 연결을 했다.

연결을 완료했다면 `query`를 전송하여 데이터를 받아와야한다.

쿼리를 사용하기 위해서는 반드시 `Statement` 객체를 얻어내서 사용해야 한다.


Statement 생성
-   `Statement stmt = con.createStatement();`

쿼리 수행
-   `ResultSet rs = stmt.executeQuery("select no from user");`

어떠한 쿼리를 이용할꺼냐에 따라서 실행 메소드가 달라진다.

> stmt.execute("query);     -> any SQL

> stmt.executeQuery("query");   -> SELECT

> stmt.executeUpdate("query");  -> INSERT, UPDATE, DELETE


<br>
**JDBC 사용 - 단계별 설명 3**

DB 커넥션 객체를 얻고 `statement`객체를 얻어 쿼리를 전송했다면 `ResultSet` 값을 받아와야 한다.

ResultSet으로 결과받기
-   ```java
    ResultSet rs = stmt.executeQuery("select no from user");
    while(rs.next())
        system.out.println(rs.getint("no"));
    '''

모든 데이터값을 다 참조하여 가져온 뒤에는 객체를 생성했던 역순서로 꼭 꼭 닫아줘야한다.

`rs.close();`
`stmt.close();`
`con.close();`

<br>

### JDBC 단계별 사용방법
1. Driver Loading
2. connection 연결
3. 명령할 수 있는 statement 객체 생성
4. 결과값을 얻어낼 수 있는 ResultSet 객체 생성
5. 객체 close

 try~catch 구문을 이용해서 예외를 처리해준다.

 본격적으로 연결하고 명령을 수행하고 한 다음에는 반드시 객체를 닫아줘야한다.

따라서, 코드를 작성할 때 객체를 닫아주는 부분을 먼저 작성해준다. -> 어떤 일이 있어도 반드시 수행되는 `finally` 블록 이용해서 진행.

그러나 `.close()` 메소드도 예외를 처리해줘야 하는 메소드임을 인식하고 작성한다.

항상 코드를 작성할때, 어떻게 하면 조금이라도 더 안전하게 만들수 있을까? 이런것들을 생각하면서 코드를 작성하는것을 생활화한다.

1. Driver Loading -> `Class.forName("드라이버 패키지명")`
2. connection 객체 생성 -> `conn = DriverManager.getConnection(url, user, pw)`
3. conn 객체로 부터 statement 객체 생성 -> `PreparedStatement ps = conn.prepareStatement(sql);`
4. ResultSet 객체 생성 -> ResultSet rs = ps.executeQuery();
5. 모든 객체 `close()`

```java

//RoleDao.java

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

```

```java

//Role.java
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
```

```java

// RoleDao.java - Insert
package kr.or.connect.jdbcexam.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.or.connect.jdbcexam.dto.Role;

public class RoleDao {
	private static String dburl = "jdbc:mysql://localhost:3306/connectdb";
	private static String dbUser = "connectuser";
	private static String dbpasswd = "connect123!@#";

	public int addRole(Role role) {
		int insertCount = 0;

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String sql = "INSERT INTO role (role_id, description) VALUES ( ?, ? )";

		try (Connection conn = DriverManager.getConnection(dburl, dbUser, dbpasswd);
				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, role.getRoleId());
			ps.setString(2, role.getDescription());

			insertCount = ps.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return insertCount;
	}
}
```

```java
//JDBCExam2.java - Insert

package kr.or.connect.jdbcexam;

import kr.or.connect.jdbcexam.dao.RoleDao;
import kr.or.connect.jdbcexam.dto.Role;

public class JDBCExam2 {
	public static void main(String[] args) {
		int roleId = 501;
		String description = "CTO";
		
		Role role = new Role(roleId, description);
		
		RoleDao dao = new RoleDao();
		int insertCount = dao.addRole(role);

		System.out.println(insertCount);
	}
}
```

```java
//RoleDao.java - SELECT

package kr.or.connect.jdbcexam.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.or.connect.jdbcexam.dto.Role;

public class RoleDao {
	private static String dburl = "jdbc:mysql://localhost:3306/connectdb";
	private static String dbUser = "connectuser";
	private static String dbpasswd = "connect123!@#";

	public List<Role> getRoles() {
		List<Role> list = new ArrayList<>();

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		String sql = "SELECT description, role_id FROM role order by role_id desc";
		try (Connection conn = DriverManager.getConnection(dburl, dbUser, dbpasswd);
				PreparedStatement ps = conn.prepareStatement(sql)) {

			try (ResultSet rs = ps.executeQuery()) {

				while (rs.next()) {
					String description = rs.getString(1);
					int id = rs.getInt("role_id");
					Role role = new Role(id, description);
					list.add(role); // list에 반복할때마다 Role인스턴스를 생성하여 list에 추가한다.
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return list;
	}
}
```

```java
//JDBCExam3.java - SELECT
package kr.or.connect.jdbcexam;

import java.util.List;

import kr.or.connect.jdbcexam.dao.RoleDao;
import kr.or.connect.jdbcexam.dto.Role;

public class JDBCExam3 {
	public static void main(String[] args) {

		RoleDao dao = new RoleDao();
		
		List<Role> list = dao.getRoles();

		for(Role role : list) {
			System.out.println(role);
		}
	} 
}
```

