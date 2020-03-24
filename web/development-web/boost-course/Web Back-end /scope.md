## scope란?
---

`Servlet`과 `JSP`를 개발하다보면 다양한 변수를 다루게 된다.

어떠한 변수는 웹 어플리케이션에서 공유하고 싶은 변수가 있을수도 있고, 어떤 변수는 사용자 별로 유지하고 싶은 변수가 있을 수 있다.

이러한 변수를 어떤 범위 내에서 사용하기 위해서는 스코프라는 것에 알아야한다.

**핵심개념**
-   `application scope`
-   `session scope`
-   `request scope`
-   `page scope`

<br>

![image](https://user-images.githubusercontent.com/33051018/77398438-dc0f8180-6dea-11ea-9c8f-8909bc850c1b.png)

`page scope` : 선언된 한 페이지 그 내에서만 사용할 수 있는 것.

`Request scope` : 클라이언트가 요청하고 서버는 해당 요청을 받아서 응답을 보낸다. 이떄 Request scope은 클라이언트로부터 요청이 들어와서 서버가 어떤 일들을 수행한 다음 응답을 보낼 떄까지 계속 사용할 수 있는 `scope`가 `Request scope`다. -> 하나의 요청이 들어와서 응답이 나갈떄 까지 사용할 수 있는 것.

`session scope` : 세션 객체가 생성되서 이 세션 객체가 소멸될 떄 까지 사용할 수 있는 것. -> 요청이 하나가 아니라 여러개 요청이 들어와도 계속 남아있는 Session Scope이다. -> 상태유지를 할 때 사용하는 `Scope`

`Application Scope` : 하나의 어플리케이션이 생성되서 이 어플리케이션이 소멸될 떄 까지 계속 유지하고 있는 것이 `application scope`이다.

```
4가지 Scope

Application : 웹 어플리케이션이 시작되고 종료될 때까지 변수가 유지되는 경우 사용
Session : 웹 브라우저 별로 변수가 관리되는 경우 사용
Request : http요청을 WAS가 받아서 웹 브라우저에게 응답할 때까지 변수가 유지되는 경우 사용
Page : 페이지 내에서 지역변수처럼 사용
````

각각에 대해 상세하게 알아본다.

<br>

## page scope
---

특정 서블릿 또는 JSP가 실행되는 동안에만 정보를 유지하고 싶은 경우가 있다.

이럴때 사용되는 것이 `page scope`이다.

**핵심개념**
-   PageContext
---


### Page Scope
-   PageContext 라는 추상 클래스를 사용한다.
-   JSP 페이지에서 pageContext 라는 내장객체로 사용이 가능하다.
-   forward 될 경우, 해당 page scope에 지정된 변수는 사용할 수 없다.
-   사용방법은 타 scope들과 같다.
-   마치 지역변수처럼 사용되는 것이 타 scope들과 다르다.

### Request Scope
-   http 요청을 WAS가 받아서 웹 브라우저에게 응답할 때 까지 변수값을 유지하고자 할 경우 사용한다.
-   `HttpServletRequest` 객체를 사용한다.
-   `JSP`에서는 `request` 내장 변수를 사용한다.
-   서블릿에서는 `HttpServletRequest` 객체를 사용한다.
-   값을 저장할때는 request 객체의 `setAttribute()`메소드를 사용한다.
-   값을 읽어들일 때는 request 객체의 `getAttribute()`메소드를 사용한다.
-   **Request Scope는 forward시 값을 유지하고자 사용한다.**

<br>

### Session Scope
-   웹 브라우저 별로 변수를 관리하고자 할 때 사용한다.
-   웹 브라우저간 탭 간에는 세션정보가 공유되기 때문에, 각각의 탭에서는 같은 세션 정보를 사용할 수 있다.
-   `HttpSession` 인터페이스를 구현한 객체이다.
-  `JSP` 에서는 `session` 내장 변수를 사용한다.
-   서블릿에서는 `HttpServletRequest`의 `getSession()`을 이용한다.
-   값 저장은 `setSession()` , 값 읽어들일때는 `getSession()`을 사용한다.
-   장바구니처럼 사용자별 정보가 유지되어야 할 정보가 있을때 사용한다.

어떤 클라가 요청을 하고 응답을 하고 이러한 일들을 하는 동안 정보를 계속 유지해주는것이 session scope.
이 세션은 각 클라마다 가지고 있다.

### Application Scope
---

-   웹 어플리케이션이 시작되고 종료될 때 까지 변수를 사용할 수 있다.
-   `ServletContext` 인터페이스를 구현한 객체이다.
-   웹 어플리케이션 하나당 하나의 application 객체가 사용된다.
-   `jsp`에서는 application 내장 객체를 이용한다.
-   서블릿의 경우는 `getServletContext()` 메소드를 이용하여 application 객체를 이용한다.
-   값을 저장할때는 setAttribute(), 읽어들일 때는 getAttribute() 메소드를 사용한다.
-   모든 클라이언트가 공통적으로 사용해야 할 값들이 있을때 사용한다.

<br>

### Application Scope 예제
---
```java
//ApplicationScope01.java
package examples;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ApplicationScope01
 */
@WebServlet("/ApplicationScope01")
public class ApplicationScope01 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApplicationScope01() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		ServletContext application =  getServletContext();		// Application Scope에 해당하는 ServletContext 객체 얻어오기.
		
		int value = 1;
		application.setAttribute("value", value);

		out.println("<h1>value : " + value + "</h1>");
	}

}
```

```java
//ApplicationScope02.java
package examples;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ApplicationScope2
 */
@WebServlet("/ApplicationScope2")
public class ApplicationScope2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApplicationScope2() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		
		PrintWriter out = response.getWriter();
		
		ServletContext application = getServletContext();		// application Scope 객체 생성
		
		try {
			
			int value = (int)application.getAttribute("value");
			value++;
			application.setAttribute("value", value);
			
			out.println("<h1> value : " + value + "</h1>");
			
		}catch (NullPointerException e) {
			out.print("value값이 설정되지 않았습니다.");
		}
		
		
	}

	

}
```

```jsp
<%-- ApplicationScope01.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	try {
		int value = (int)application.getAttribute("value");
		value = value + 2;
		application.setAttribute("value", value);
	
%>

	<h1> <%=value %></h1>

<%
	}catch(NullPointerException e) {
%>
	<h1>설정된 값이 없습니다.</h1>
<%
	} 
%>

</body>
</html>
```
