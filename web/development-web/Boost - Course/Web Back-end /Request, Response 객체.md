## Request, Response 객체 이해하기
---

이번엔 클라이언트가 서버에게 보낸 요청에 대한 정보를 추상화한 객체 `HttpServletRequest` 와 서버가 클라이언트에게 응답하기 위한 정보를 추상화한 객체 `HttpServletResponse`에 대해 알아본다.

웹 브라우저에 URL을 입력하면 웹 브라우저는 도메인과 포트번호를 이용해서 서버에 접속한다.

이후 path정보, 클라이언트의 IP등을 포함한 다양한 정보를 서버에게 전송하게 된다.

클라이언트로 부터 요청이 들어오면 `WAS`는 `HttpServletRequest` 와 `HttpServletResponse` 객체를 생성한다.

`HttpServletRequest` 객체에는 요청할 때 가지고 들어온 다양한 정보들을 해당 객체에 담는다.

이후 `HttpServletResponse` 라는 객체에는 클라이언트에게 전송하기 위해 담을 수 있는 정보를 해당 객체에 담는다.

이를 서블릿에게 전달해서 `doGet(), doPost(), doService()`와 같은 메서드에 파라미터로 전달해서 사용하게 된다.

<br>

![image](https://user-images.githubusercontent.com/33051018/77280195-0556e180-6d07-11ea-9cc2-c067665db753.png)

### `HttpServletRequest`

-   `http` 프로토콜의 request정보를 서블릿에게 전달하기 위한 목적으로 사용.
-   헤더정보, 파라미터, 쿠키, URI, URL 등의 정보를 읽어 들이는 메소드를 가지고 있다.
-   Body의 Stream을 읽어들이는 메소드를 가지고 있다. 

### `HttpServletResponse`

-   WAS는 어떤 클라이언트가 요청을 보냈는지 알고 있고, 해당 클라이언트에게 응답을 보내기 위한 `HttpServletResponse` 객체를 생성하여 서블릿에게 전달한다.

-   서블릿은 해당 객체를 이용하여 `content type`, 응답코드, 응답 메시지 등을 전송한다.

**Header 내 들어있는 정보 알아보기**

```java
//HeaderServlet.java

package examples;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HeaderServlet
 */
@WebServlet("/Header")
public class HeaderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HeaderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();		//응답할 통로를 하나 만든다 -> 클라이트와의 연결통로
		out.println("<html>");							//응답으로 보내줄 html 태그들. 
		out.println("<head><title>form</title></head>"); 
		out.println("<body>");
		
		Enumeration<String> headerNames = request.getHeaderNames();
		
        while(headerNames.hasMoreElements()) {
			String headerName = headerNames.nextElement();
			String headerValue = request.getHeader(headerName);
			out.println(headerName + " : " + headerValue + "<br> ");
			
		}
		out.println("</body>");
		out.println("</html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

```

**output**
```html
host : localhost:8081
connection : keep-alive
upgrade-insecure-requests : 1
user-agent : Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36
sec-fetch-dest : document
accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
sec-fetch-site : none
sec-fetch-mode : navigate
sec-fetch-user : ?1
accept-encoding : gzip, deflate, br
accept-language : ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7
```
<br>

### 파라미터 읽어들이기
---
```java
package examples;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class parameterServlet
 */
@WebServlet("/param")
public class parameterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public parameterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			// 응답으로 보내기 위한 부분은 response 객체에 담는다.
			// 요청에 들어온 것들은 모두 request 객체가 가지고 있으니 거기서 꺼내면 된다.
		
		response.setContentType("text/html");				// 응답값 콘텐츠 타입 설정
		PrintWriter out = response.getWriter();				// 응답값에 담을 내용을 적기 위한 통로 -> 클라이언트와의 연결통 
		out.println("<html>");
		out.println("<head><title></title></head>");
		out.println("<body>");
		
		String name = request.getParameter("name");
		String age = request.getParameter("age");
		
		out.println("name : " + name + "<br>");
		out.println("age : " + age + "<br>");
		
		out.println("</body>");
		out.println("</html>");

	}

}

```

```java
// 응답으로 보내기 위한 부분은 모두 respopse 객체에 담는다.
// 요청으로 들어온 것은 모두 request 객체에 담겨있으니 꺼내서 사용하면 된다.

response.setContentType("text/html");      
//우리는 응답값을 text/html 형식으로 보낼꺼야
PrintWriter out = response.getWrite();
//응답값에 write할 값을 out 객체에 담아서 보낼꺼야

String name = request.getParameter("name");
// name이라는 변수에 request객체에 담겨있는 파라미터 name의 값을 넣을꺼야

String age = request.getParameter("age");
// age라는 변수에 request객체에 담겨있는 파라미터  age의 값을 넣을꺼야

```
<br>

### 그 외 요청정보 출력하기
---
```java

//InfoServlet.java

public class InfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title></title></head>");
		out.println("<body>");
		
		String uri = request.getRequestURI();
		StringBuffer url = request.getRequestURL();
		String contentPath = request.getContextPath();
		String remoteAddr = request.getRemoteAddr();
		
		
		out.println("uri : " + uri + "<br>");
		out.println("url : " + url + "<br>");
		out.println("contentPath : " + contentPath + "<br>");
		out.println("remoteAddr : " + remoteAddr + "<br>");
		
		out.println("</body>");
		out.println("</html>");
	}


}
```

**output**
```html
uri : /firstweb/Info        
url : http://localhost:8081/firstweb/Info
contentPath : /firstweb
remoteAddr : 0:0:0:0:0:0:0:1
```

uri : URL 내용중 프로토콜과 도메인값을 제외한 뒷부분
