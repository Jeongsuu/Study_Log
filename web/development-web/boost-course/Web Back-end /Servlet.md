## Servlet

### 자바 웹 어플리케이션 (Java Web Application)
---
-   `WAS`에 설치되어 동작하는 어플리케이션.
-   자바 웹 어플리케이션에는 HTML, CSS, 이미지, 자바로 작성된 클래스
(Servlet포함, package, 인터페이스 등), 각종 설정 파일등이 포함된다.

이클립스 내부에서 설치한 런타임 톰캣에 의해서 동작.

그 이후, 웹 브라우저를 통해서 톰캣 서버에 요청을 보내고 응답값을 웹 브라우저로 확인한다.

웹 어플리케이션은 WAS에 의해서 동작한다.

<br>

### Servlet이란
---
-   자바 웹 어플리케이션의 구성요소 중 동적인 처리를 하는 프로그램의 역할
-   서블릿은 WAS에서 동작하는 java 클래스다.
-   서블릿은 `HttpServlet` 클래스를 상속받아야 한다.
-   서블릿과 `JSP`로부터 최상의 결과를 얻으려면, 웹 페이지를 개발할 때 이 두가지를 조화롭게 사용해야 한다.

### Servlet 작성방법

1. Servlet 3.0 spec 이상의 경우
-   web.xml 파일을 사용하지 않음.
-   java annotation을 사용.

2. Servlet 3.0 spec 미만의 경우
-   Servlet을 등록할 때 web.xml 파일에 등록.

서블릿은 동적으로 결과를 만들어낸다.

즉, 요청이 들어오면 해당 서블릿이 실행이 되면서 응답할 코드를 만들어내고 그때 그 코드로 응답을 하게 만든다.

 ```java
 //1~10까지 출력하는 예제
 package exam;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TenServlet
 */
@WebServlet("/ten")

// 위 부분이 Servlet 3.0 이상에서의 작성방법

public class TenServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TenServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");    // 브라우저가 응답을 받았을 때 어떤 콘텐트입인지 알아야한다.
		PrintWriter out = response.getWriter();				   // 값을 받아올 통로 즉, 객 생성
		out.print("<h1> 1 - 10까지 출력 </h1>");
		
		for(int i=1; i<=10; i++) {
			out.print(i+"<br>");
		}
		
		out.close();					//out 객체 close
	}

}

```

**servlet 3.0 미만에서의 url-pattern 설정은 `WEB-INF/web.xml`에서 설정
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" id="WebApp_ID" version="2.5">
  <display-name>exam25</display-name>
  <welcome-file-list>
    <welcome-file>index.html</welcome-file>
    <welcome-file>index.htm</welcome-file>
    <welcome-file>index.jsp</welcome-file>
    <welcome-file>default.html</welcome-file>
    <welcome-file>default.htm</welcome-file>
    <welcome-file>default.jsp</welcome-file>
  </welcome-file-list>
  <servlet>
    <description></description>
    <display-name>TenServlet</display-name>
    <servlet-name>TenServlet</servlet-name>
    <servlet-class>exam.TenServlet</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>TenServlet</servlet-name>
    <url-pattern>/ten</url-pattern>
  </servlet-mapping>
</web-app>
```

Servlet 3.0 미만에서는 `web.xml`에 servlet을 등록해줘야 사용이 가능했다.

없으면 404 Not found Error를 띄운다.

`system.out.println` 은 콘솔에 프린트 해주는것.
`Printwriter.out.print` 는 응답 결과로 프린트 해주는것.
<br>

## Servlet Life-Cycle
---

### Servlet 생명주기
 
서블릿 생명주기 파악을 위해 아래와 같은 서블릿 코드를 작성한다.

 ```java
 package examples;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LifecycleServlet")
public class LifecycleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LifecycleServlet() {
        System.out.println("LifecycleServlet 생성");
     
    }

	public void init(ServletConfig config) throws ServletException {
        System.out.println("init 호출!!");

	}

	public void destroy() {
        System.out.println("destroy 호출!!");

	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("service 호출!!");

	}

}

LifecycleServlet 생성
init 호출!!
service 호출!!

```
실행시 위처럼 콘솔창에 값으르 확인할 수 있다.

해당 URL로 클라이언트가 서버에게 요청한다.

서버는 이 URL을 받아서 이 Lifecycle 이라는 URL 매핑은
LifecycleServlet이라는 정보를 알아내고 해당 클래스가 메모리에 존재하는지의 여부를 체크한다.

메모리에 존재하지 않으면 객체를 생성한다.

최초 호출시 서버는 메모리에 없다는것을 확인하고 생성자가 실행된다.

이후 `init() , service()` 라는 메소드가 순차적으로 호출된다.

새로고침을 진행해보면
```
LifecycleServlet 생성
init 호출!!
service 호출!!
service 호출!!
service 호출!!
```

위와 같이 `service()` 메소드만 계속 호출되는 것을 볼 수 있다.

**실제 요청이 들어왔을떄 응답해야 되는 모든 내용은 `service()`라는 메서드에 구현해야한다.**

서블릿은 서버에 서블릿 객체를 여러개 만들지 않는다.

요청이 여러번 들어오면 매번 생성하는것이 아니라 실제 요청된 객체가 메모리에 있는지에 대한 여부를 확인하고 있으면 `service()` 메소드만 호출된다.

`destroy()` 메소드는 언제 호출될까?
실행 도중 코드를 수정하면 서블릿은 기존 객체를 삭제하고 새로운 객체를 생성하기 위해 `destroy()` 메소드를 호출한 뒤 다시 `LifecycleServlet`을 생성한다.

즉 WAS가 종료되거나, 웹 어플리케이션이 새롭게 갱신될 경우 `destroy()`메소드가 실행된다.

<br>

## LifecycleServlet

-   HttpServlet의 3가지 메소드를 오버라이딩
    -   init()
    -   service(request, response)
    -   destroy()

![image](https://user-images.githubusercontent.com/33051018/77250186-81124900-6c89-11ea-98f5-bc09524b3cf9.png)

이 내용이 핵심.
#### service(request, response) 메소드
---
-   HttpServlet의 service메소드는 템플릿 메소드 패턴으로 구현
    -   클라이언트의 요청이 GET일 경우에는 자신이 가지고 있는 doGET(request, response) 메소드를 호출
    <br>
    -   클라이언트의 요청이 Post일 경우에는 자신이 가지고 있는 doPost(request, response) 메소드를 호출

