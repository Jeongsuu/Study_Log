## 지시자, Request & Response 객체

---



### 지시자

---

`JSP` 페이지의 전체적인 속성을 지정할. 때 사용한다.

page, include, taglib이 존재하며, `<%@ 속성 %>` 형태로 사용한다.

>**`page` : 해당 페이지의 전체적인 속성을 지정**
>
>**`include` : 별도의 페이지를 현재 페이지에 삽입**
>
>**`taglib` : 태그 라이브러리의 태그 사용**



**page 지시자**

---

페이지의 속성을 지정할 때 사용하며 주로 <u>사용되는 언어 지정 및 import 문</u>에 많이 사용한다.

ex) `page.jsp`

```html
<%@ page import="java.util.Arrays"%>		<!-- Util 사용을 위한 import -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%										<!-- Script let -->
	int[] iArr = {10, 20, 30};				//배열 초기화
	out.println(Arrays.toString(iArr));		//Arrays객체를 이용한 배열 출력
%>										

</body>
</html>
</html>
```



**include 지시자**

---

현재 페이지 내에 다른 페이지를 삽입할 때 사용한다. `file` 속성을 사용한다.

ex) `include.jsp`

```html
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>include.jsp page test1</h1>			<!-- header 1 -->
	<%@ include file="Page.jsp" %>			<!-- 같은 경로에 존재하는 Page.jsp 파일 삽입 -->
	<h1>include.jsp page test2</h1>			<!-- header 1 -->

</body>
</html>
```



**taglib 지시자**

---

 사용자가 만든 `tag`들을 태그 라이브러리라고 부르며, 이러한 태그 라이브러리를 사용하기 위해 `taglib` 지시자를 사용한다.

`uri` 및 `prefix` 속성이 존재하며, `uri`는 태그 라이브러리의 위치 값을 갖고 `prefix`는 태그를 가리키는 이름 값을 갖는다.

`taglib` 지시자에 대해서는 추후에 JSTL을 다룰 때 보다 심도깊게 알아보도록 한다.



cf)

>HTML comments : <!-- contents -->
>
>JSP comments : <%--	contents -->



**Request 객체**

---

 웹 브라우저를 통해 서버에 어떠한 정보를 요청하는 것을 `request` 라고 한다.

그리고 이러한 요청 정보는 `request` 객체가 관리한다.



**웹 브라우저(Client)** ---------(request)------->	**서버**

**웹 브라우저(Client)** <-------(response)------- **서버**



#### Request 객체 관련 메소드

---

`getContextpath()` : 웹 어플리케이션의 context path를 얻는다.

`getmMethod()` : get 방식과 post 방식을 구분한다.

`getSession()` : 세션 객체를 얻어온다.

`getProtocol()` : 해당 프로토콜을 얻어온다.

`getRequestURL()` : 요청 URL 을 얻어온다.

`getRequestURI()` : 요청 URI를 얻어온다.

`getQueryString()` : 쿼리 스트링을 얻어온다.

위 메소드들과 함께 `parameter` 메소드들이 많이 쓰인다.

`JSP` 페이지를 제작하는 목적이 데이터 값을 전송하기 위함이므로, `parameter`관련 메소드는 매우 중요!

**`getParameter(String name)` : name에 해당하는 파라미터의 값을 구해온다.**

**`getParameterNames()` : 모든 파라미터 이름을 구해온다.**

**`getParameterValues(String name)` : name에 해당하는 파라미터의 값(복수개)을 구해온다.**



### Response 객체의 이해

---

 웹 브라우저의 요청에 응답하는것을 `response`라고 하며, 이러한 응답(response)의 정보를 가지고 있는 객체를 response객체라고 한다.



#### Request 객체 관련 메소드

---

`getCharacterEncoding()` : 응답시 문자의 인코딩 형태를 구해온다.

`addCookie(Cookie)` : 쿠키를 지정할 때 사용한다.

**`sendRedirect(URL)` : 지정한 URL로 이동한다.**	 -> `forwarding` 기능으로 굉장히 많이 쓰인다.



ex) request_send.jsp

```html
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		int age;
	%>

	<%
		String str = request.getParameter("age");	// getparam 메소드를 통해 값을 받아온다.
		age = Integer.parseInt(str);				// 받아온 값을 정수형으로 파싱
		
		if(age >= 20){		// 나이에 따른 분기 진행
			response.sendRedirect("pass.jsp?age=" + age);
		} else {
			response.sendRedirect("error.jsp?age=" + age);
		}
	%>

</body>
</html>
</html>
```



