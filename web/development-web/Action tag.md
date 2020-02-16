## Action Tag

---



### **Action Tag란?**

---

 `JSP` 페이지 내에서 어떠한 동작을 하도록 지시하는 태그이다. 

예를 들어 페이지 이동, 페이지 `include` 등등이 있다. 

우선은 'forward', 'include', 'param' 태그에 대해 알아보자.



### forward, include, param 태그

---



**forward**

---

  `forward`태그는 이름 그대로 현재의 페이지에서 다른 특정페이지로 전환할 때 사용한다. 

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>main.jsp 페이지 입니다.</h1>
	
	<jsp:forward page="sub.jsp" />			<!-- sub.jsp로 이동 -->
	
</body>
</html>
```



**include**

---

 현재 페이지에 다른 페이지를 삽입할 때 사용한다.

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>sub.jsp 페이지 입니다.</h1>
	<jsp:include page="main.jsp" flush="true" />		<!-- main.jsp 페이지 삽입 -->
	<h1>다시 sub.jsp 페이지 입니다.</h1>
</body>
</html>
```



**param**

---

 `forward` 및 `include` 태그에 데이터 전달을 목적으로 사용되는 태그이다.

이름과 값으로 이루어져 있다.

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:forward page="forward_param.jsp"/>
		<jsp:param value="id" name="abcde"/>
		<jsp:param value="pw" name="12345"/>
	</jsp:forward>
	
</body>
</html>
```



`foward` : 페이지를 다른 쪽으로 포워딩 하는 것. -> URL은 그대로 고정이지만 실제 페이지 내용은 포워딩 페이지가 출력된다.

`include` : 현재 페이지에 다른 페이지를 삽입해서 실행을 하고 현재 페이지 내용을 마저 출력한다.

`param` : forward를 하거나 include를 할 때 , 해당 페이지등에 데이터를 전달할 때 사용한다.

