## EL(Expression Language)
---

jsp에서 표현식을 이용해 값을 출력할 때 변수의 값이 `null`이면 화면에 `null`이 출력되었다.

이 경우 `null`인지 검증한 뒤, `null`일 경우 아무것도 없는 문자열을 출력해야 하는 등 불편한 과정을 거쳐야한다.

`EL`을 이용하면 좀 더 편리하게 변수를 `JSP`에서 사용할 수 있다.

EL은 값을 표현하는데 사용되는 스크립트 언어로서 JSP 기본 문법을 보완하는데 역할을 한다.

<br>
**표현 언어가 제공하는 기능**
-   JSP의 스코프에 맞는 속성 사용
-   집합 객체에 대한 접근 방법 제공
-   수치 연산, 관계 연산, 논리 연산자 제공
-   자바 클래스 메소드 호출 기능 제공
-   표현언어만의 기본 객체 제공

<br>

### 표현 언어의 표현 방법

`${expr}` -> 표현언어가 정의한 문법에 따라 값을 표현하는 방식

예제
---
```java
<jsp:include page="/module/${skin.id}/header.jsp" flush="true"/>
<b>${seesionScope.member.id}</b>님 환영합니다.
```

표현언어는 JSP의 스크립트 요소 (스크립트릿, 표현식, 선언문)를 제외한 나머지 부분에서 사용될 수 있으며, 표현식보다 편리하게 값을 출력할 수 있다.


```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	pageContext.setAttribute("p1", "page scope value");			// page scope 변수 선언 및 초기화 
	request.setAttribute("r1", "request scope value");			// request scope 변수 선언 및 초기화 
	session.setAttribute("s1", "session scope value");			// session scope 변수 선언 및 초기화 
	application.setAttribute("a1", "application scope value");	// application.scope 변수 선언 및 초기화 
	
%>


<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- JSP를 이용한 스코프변수 접근 방법-->
pageContext.getAttribute("p1") : <%=pageContext.getAttribute("p1") %>	<br>
request.getAttribute("r1") : <%= request.getAttribute("r1") %>	<br>
session.getAttribute("s1") : <%= session.getAttribute("s1") %>	<br>
application.getAttribute("a1") : <%=application.getAttribute("a1")%>	<br>

<!-- EL을 이용한 스코프변수 접근 방법-->
pageContext.getAttribute("p1") :${pageScope.p1} <br>
request.getAttribute("r1") :${requestScope.r1} <br>
session.getAttribute("s1") :${sessionScope.s1} <br>
application.getAttribute("a1") :${applicationScope.a1} <br>

</body>
</html>
```

**output**
```html
pageContext.getAttribute("p1") : page scope value
request.getAttribute("r1") : request scope value
session.getAttribute("s1") : session scope value
application.getAttribute("a1") : applciation scope value
pageContext.getAttribute("p1") :page scope value
request.getAttribute("r1") :request scope value
session.getAttribute("s1") :session scope value
application.getAttribute("a1") :applciation scope value
```

 ```jsp
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% request.setAttribute("k", 10);%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

k : ${requestScope.k}<br>
k : ${k}<br>

k + 5 : ${k+5 } <br>
k - 5 : ${k-5 } <br>
k * 5 : ${k*5 } <br>
k / 5 : ${k div 5 } <br>


</body>
</html>
```

**output**
```html
k : 10
k : 10
k + 5 : 15
k - 5 : 5
k * 5 : 50
k / 5 : 2.0
```

 ```jsp
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
	request.setAttribute("k", 10);
	request.setAttribute("m", true);

%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

k : ${requestScope.k}<br>
k : ${k}<br>

k + 5 : ${k+5 } <br>
k - 5 : ${k-5 } <br>
k * 5 : ${k*5 } <br>
k / 5 : ${k div 5 } <br>

k : ${k } <br>
k : ${m } <br>

m : ${m } <br>
!m : ${!m } <br>

</body>
</html>
```

```html
k : 10
k : 10
k + 5 : 15
k - 5 : 5
k * 5 : 50
k / 5 : 2.0
k : 10
k : true
m : true
!m : false
```



