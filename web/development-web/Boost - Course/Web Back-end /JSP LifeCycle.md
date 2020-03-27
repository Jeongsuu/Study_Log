## JSP LifeCycle
---

JSP 파일이 최초로 실행될 때 특별한 형태의 서블릿으로 소스가 변환된다.

JSP는 JSP가 실행이 되는게 아니라 서블릿으로 바뀌어서 실행된다.

톰캣이 JSP를 서블릿으로 변형한다.

`JSP` 파일이 실행되면 `.metadata` 폴더 내에 java 파일이 생성된다.

해당 파일 내 `_jspService()` 메소드 내부를 살펴보면 `JSP` 파일의 내용이 변환되어 들어가 있는 것을 확인할 수 있다.

`[jsp파일명].java`는 서블릿 소스로 자동으로 컴파욀 되면서 실행되어 그 결과가 브라우저에 보여진다.

<br>

### JSP 실행순서
---
1. 브라우저가 웹서버에 JSP에 대한 요청 정보를 전달한다.
2. 브라우저가 요청한 JSP가 최초로 요청했을 경우
    -   JSP로 작성된 코드가 서블릿 코드로 변환한다. (java파일 생성)
    -   서블릿 코드를 컴파일해서 실행 가능한 bytecode로 변환 (class파일 생성)
    
    -   서블릿 클래스를 로딩하고 인스턴스를 생성한다.

3. 서블릿이 실행되어 요청을 처리하고 응답 정보를 생성한다.

 JSP 내에 어떠한 코드를 작성하여도 일반적으로는 `Service()` 메소드에 기재된다.

 ```java
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
hello~~

<%
	System.out.println("jspService() call");
%>


<%!
	public void jspInit() {
		System.out.println("jspInit() call");
	}
%>

<%!
	public void jspDestory() {
		System.out.println("jspDestroy() call");
	}
%>
</body>
</html>
```
<br>

![image](https://user-images.githubusercontent.com/33051018/77296560-3cd78500-6d2b-11ea-8d86-ae448085ddca.png)



이와 같이 `<%! %>` 선언식을 이용하면 `service` 메소드 바깥쪽에  다른  사용이 코드 기재가 가능하다.

처음 이 JSP를 실행하기 전에 뭔가 초기화할 게 있다거나 이 JSP가 끝나기전에 저장하고 싶은 값이 있다던가 할 때 위와같이 추가해서 사용할 수 있다.

**service()메소드 외 부분에 기재하고 싶을떄 : `<%! %>`** 를 이용한다.
