## Web_Server
---
<br>
웹 브라우저를 실행한 이후 주소 입력창에 URL 주소를 입력하면, 그 URL에 해당하는 결과물이 화면에 보인다.

우리가 현실에서 주소를 보고 집을 찾아가는 것처럼, 웹 브라우저는 URL 주소에 해당하는 웹 서버(Web Server) 에 연결되고, 해당 주소에서 볼 수 있는 내용들을 렌더링해준다.

웹 브라우저의 요청을 받아 HTML 문서나 오브젝트를 반환하는 웹 서버에 대하여 알아보자.

<br>

### 웹 서버란
---
-   웹 서버는 보통 소프트웨어를 의미하지만, 엄밀히 말하면 웹 서버 소프트웨어가 동작하는 컴퓨터를 말한다.

-   웹 서버의 가장 중요한 기능은 클라이언트가 요청하는 HTML 문서나 각종 리소스를 전달하는 것이다.

- 웹 브라우저나 웹 크롤러가 요청하는 리소스는 컴퓨터에 저장되어 있는 정적 데이터(HTML, CSS, javscript, image...etc) 이거나 동적인 결과(웹 서버에 의하여 실행되는 프로그램을 통해서 만들어진 결과물) 가 될 수 있다.

<br>

### 웹 서버 소프트웨어 종류

-   가장 많이 사용하는 웹 서버는 Apache, Nginx, Microsoft, Google 웹서버

-   Apache 웹 서버는 Apache Software Foundation에서 개발한 웹서버로 오픈소스 소프트웨어이며, 다양한 운영체제에서 설치 및 사용이 가능하다. <br>
Nginx는 보통 차세대 웹서버로 불리며 더 적은 자원으로 더 빠르게 데이터를 서비스하는 것을 목적으로 만들어진 서버이며 Apache 웹 서버와 마찬가지로 오픈소스 소프트웨어이다.

<br>

### WAS (Web-Application Server)

-   클라이언트는 서비스를 제공하는 서버에게 정보를 요청하여 응답 받은 결과를 사용한다.

-   WAS는 일종의 미들웨어로 웹 클라이언트의 요청 중 보통 웹 어플리케이션이 동작하도록 지원하는 목적을 가진다.

**WAS의 장점**
1. 프로그램 실행 환경과 DB접속 기능을 관리한다.
2. 여러개의 트랜잭션을 관리한다.
3. 업무를 처리하는 비즈니스 로직을 수행한다.

### 웹 서버 vs WAS
-   WAS도 보통 자체적으로 웹서버 기능을 내장하고 있다.
-   현재는 WAS 가 가지고 있는 웹 서버도 정적인 컨텐츠를 처리하는데 있어서 성능상 큰 차이가 없다.
-   규모가 커질수록 웹 서버와 WAS를 분리한다. 

#### servlet 

-   URL 요청을 처리하는 프로그램

`http://IP | 서버도메인 : port / [프로젝트명] / [URL mapping값]`

```java
// HelloServlet.java
package examples;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloServlet
 */
@WebServlet("/HelloServlet")
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<h1> Hello Servlet</h1>");
		
	}

}


```
