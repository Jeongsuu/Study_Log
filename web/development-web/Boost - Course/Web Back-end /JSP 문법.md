## JSP 문법
---

JSP는 HTML 태그와 자바코드를 섞어서 개발할 수 있다.
JSP에서 자바코드는 어떻게 입력을 하는지, 결과를 출력하려면 어떻게 코드를 작성해야 하는지 알아보도록 한다.

**핵심개념**
-   선언문          `<%! %>`
-   스크립트릿       `<% %>`
-   표현식          `<%= %>`
-   주석            `<%-- --%>`

<br>

### 스크립트 요소의 이해
---

-   JSP 페이지에서는 선언문, 스크립트릿, 표현식 이라는 3가지의 스크립트 요소를 제공한다.

> 선언문 - `<%! %>` : 변수 선언 및 메소드 선언에 사용
> 스크립트릿 - `<% %>` : 프로그래밍 코드 기술에 사용, 지역변수 선언 
> 표현식 - `<%= %>` : 화면에 출력할 내용 기술에 사용, 다시 말해서 응답 결과에 포함할 부분을 넣을때 사용하는 부분


**선언문**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
id : <%= getId() %>

<%!
	String id = "u001";	//멤버변수 선언

	public String getId() {     //메소드 선언
		return id;
	}

%>

</body>
</html>
```

선언문 내에 `id` 변수와 `getId()` 라는 메소드 선언이후, 표현식을 통해 `id`값 출력

<br>

**스크립트 릿**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%      // 스크립트 릿 열기
	for(int i=1; i<=5; i++) {       //반복문 열기
		
	
%>

// 표현식 사용해서 출력
<h1> <%=i %></h1> 반복문을 이용한 스크립트릿과 표현식 사용 <br> 

<%
	}       //반복문 닫기
%>

</body>
</html>
```

output
```html
1
반복문을 이용한 스크립트릿과 표현식 사용
2
반복문을 이용한 스크립트릿과 표현식 사용
3
반복문을 이용한 스크립트릿과 표현식 사용
4
반복문을 이용한 스크립트릿과 표현식 사용
5
반복문을 이용한 스크립트릿과 표현식 사용
```

위와 같이 스크립트 릿을 쪼개서 사용할 수 있다.

JSP의 제일 중요한것은 해당 JSP가 서블릿으로 바뀔때 어떻게 바뀔것인가? -> 를 생각해야된다!

<br>

**표현식**
-   JSP 페이지에서 웹 브라우저에 출력할 부분을 표현한다!!!!!!!, 즉 화면에 출력하기 위한것.

**주석**
-   HTML 주석은 `<!--     -->`  형태로 작성한다.
-   JSP 주석은 `<%-- --%>` 형태로 작성한다.
-   자바 주석은 `// | /* */` 형태로 작성한다.

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%--jsp 주석문입니다.
여러줄을 입력할 수 있습니다. --%>
<!-- html 주석문입니다. -->
<%
/*
자바 여러줄 주석문입니다.
*/
for(int i = 1; i <= 5; i++){ // java 한줄 주석문입니다.
%>
<H<%=i %>> 아름다운 한글 </H<%=i %>>
<%
}
%>
</body>
</html>
```
