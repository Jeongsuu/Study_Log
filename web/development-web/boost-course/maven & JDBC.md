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

