## JSP
---

 ### 실습을 통한 JSP 알아보기
 ---

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

<%
	int total = 0;
	for(int i=1; i<=10; i++){
		total += 1;
	}
%>

1부터 10까지의 합 : <%=total %>
</body>
</html>
```
**output**
```html
1부터 10까지의 합 : 55
```
<br>
<br>

`JSP`는 `html`과 매우 유사한 포맷을 가지고 있다.

제일 윗부분에 위치하는 `page`지시자와 scriptlet`<% %>`, 표현식 `<%= %>` 부분을 제외하고는 매우 유사하다.

html 쓰면 그만인데 왜 JSP를 쓰냐? -> html 내에서 프로그램을 동작시키기 위해 `JSP`를 사용한다.

<br>

`JSP`는 몇개의 약속된 기호들을 가지고 있다.

해당 기호들을 통해 JSP가 서블릿으로 바뀔떄 어떻게 바뀔지 결정해준다.

`JSP`는 `JSP` 자체가 동작하는게 아니라 서블릿으로 바뀌어서 동작된다.

따라서, 기호를 통해 서블릿으로 변경될 떄 어떻게 바뀔지 알려주어 적절히 작동하도록 한다.

>
>`<%@ page` : page 지시자
> 
> 지시문 다음에는 `html` 코드가 나온다.
>
> `html` 안에서 프로그램을 실행시키기 위해 `JSP`를 사용한다.
>
> `<% %>` : 안에는 자바가 들어간다. -> Scriptlet
>
> `<%= %>` : 표현식, 응답 결과로 넣고 싶은 자바 코드를 넣는곳.
즉, `out.println()` -> `<%= %>` 이랑 같음.

이 JSP가 서블릿으로 바뀔때 어떻게 바뀔까? 이런걸 생각하면서 작성해야한다.

<br>


## JSP는 서블릿으로 바뀐다

서블릿으로 바뀐 이후에는 서블릿 라이프사이클과 동일하게 실행된다.
