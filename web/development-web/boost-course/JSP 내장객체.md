## JSP 내장객체
---

JSP에서는 개발자가 선언하지 않아도, 사용할 수 있는 앞서 선언된 변수가 존재한다.

이를 내장객체라고 한다. 개발자가 선언하지 않았음에도 어떻게 JSP에서 내장객체를 사용할 수 있는지 알아본다.

**핵심개념**
-   request
-   response
-   out
-   application
-   page
-   session


<br>

JSP는 항상 서블릿 소스로 변환되고 실행된다.

JSP에 입력한 대부분의 코드는 생성되는 서블릿 소스의 `_jspService()` 메소드 안에 삽입되는 코드로 생성된다.

`_jspService()`에 삽입된 코드의 윗 부분에 미리 선언된 객체들이 있는데, 해당 객체들은 `jsp`에서도 사용이 가능하다.

`response, request, application, session, out`과 같은 변수를 내장객체라고 한다.

실습을 통해 내장객체 이용 예제를 살펴본다.

```jsp
<%@page import="com.sun.jdi.Type"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- Script let -->
<%
	StringBuffer url = request.getRequestURL();
	out.print("url : " + url);
	out.print("<br>");
	out.print("url : " + url.toString());
	out.print("<br>");
%>


</body>
</html>
```

**output**
```html
url : http://localhost:8081/firstweb/ImplicitExample.jsp
url : http://localhost:8081/firstweb/ImplicitExample.jsp
````
