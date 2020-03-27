## JSTL (JSP Standard Tag Library)
---

프론트 개발자가 JSP를 수정하는데, JSP 파일 내 자바코드와 HTML 코드가 섞여있다면 수정시 매우 번거로움을 느끼게 될 가능성이 크다.

이러한 문제를 해결하기 위해 등장한 것이 `JSTL`이다.

`JSTL` 을 이용하면 태그형식으로 조건문, 반본묵 등을 사용할 수 있다.

`JSTL` 을 사용함으로써 `java`코드를 없애고 태그형태로 표현할 수 있다.

`JSP`는 스크립트릿의 자바 코드와 `HTML` 태그가 섞여있는 형태로 개발의 편의성은 높았으나 섞여있어서 프론트 개발자가 해당 코드를 수정하기 굉장히 힘들었으며 결국 유지보수가 어렵다는 결론에 이르렀다.

이러한 단점 보완을 위해 나온것이 `JSTL`이며 이는 태그 형식으로 로직을 수행할 수 있도록 한다.

### JSTL이 제공하는 태그의 종류

---
라이브러리  |   하위 기능    | 접두어

코어      | 변수지원, 흐름제어, URL처리 | c

xml     |   XML코어, 흐름제어, XML변환  |   c

국제화      |   지역, 메시지 형식, 숫자 및 날짜 형식 | fmt

데이터베이스 | SQL  |   sql

함수       |    콜렉션 처리, String 처리    |   fn

---
<br>


### 코어태그 : 변수 지원 태그 - set, remove
---
변수 설정 : 지정 영역에 변수를 생성한다.
```jsp
<c:set var = "varName" scope="session" value="someValue" />

<c:set var = "varName" scope="request">
some Value
</c:set>

-   var : EL에서 사용될 변수명
-   scope : 변수값이 저장될 영역
-   value : 변수값
```

변수 제거
```jsp
<c:remove var="varName" scope="requeest"/>
```

**실습**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core%>

<c:set var="value1" scope="request" value="kang"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

성 : ${value1 }	<br>

<c:remove var="value1" scope="request" />

성 : ${value1 }	<br>

</body>
</html>
```

**output**
```html
성: kang
성:
```
<br>

**코어테그 : 변수 지원 태그 - 프로퍼티, 맵의처리**

<br>**문법**
```jsp
<c:set target="${some}" property="propertyName" value="anyValue"/>
some 객체가 자바빈일 경우: some.setPropertyName(anyvalue)
some 객체가 맵(map)일 경우: some.put(propertyName, anyvalue);

target - <c:set>으로 지정한 변수 객체
property - 프로퍼티 이름
value - 새로 지정할 프로퍼티 값

```

 흐름제어 태그 - if

 ```jsp
 <c:if test="조건">
    test 조건의 true일 경우 body부분 실행
 </c:if>
 ```

이런식으로 test 의 값에 조건문을 주어 해당 조건이 만족이 될 때만 실행을 한다.

 ```jsp
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <%
	request.setAttribute("n", 10);
%>	--%>

//위와 아래의 스콮 변수 선언은 동일한 결과를 나타낸다.

<c:set var="n" scope="request" value="10"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<c:if test="${n == 0 }">
	n == 0
</c:if>

<c:if test="${n == 10 }">
	n == 10

</c:if>

</body>
</html>
```
n == 10

<br>

**흐름제어**

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="score" scope="request" value="83"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:choose>
	<c:when test="$[score >= 90}">
		A학점입니다.
	</c:when>
	
	<c:when test="${score >= 80 }">
		B학점입니다.
	</c:when>
	
	<c:when test="${score >= 70 }">
		C학점입니다.
	</c:when>
	
	<c:when test="${score < 70 }">
		D학점입니다.
	</c:when>
	
    <c:otherwise>
        F학점입니다.
    </c:otherwise>

</c:choose>


</body>
</html>
```

B학점입니다.

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setAttribute("k", 10);
    request.setAttribute("m", true);
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
k : ${k } <br>
k + 5 : ${ k + 5 } <br>
k - 5 : ${ k - 5 } <br>
k * 5 : ${ k * 5 } <br>
k / 5 : ${ k div 5 } <br>


k : ${k }<br>
m : ${m }<br>
k > 5 : ${ k > 5 } <br>
k < 5 : ${ k < 5 } <br>
k <= 10 : ${ k <= 10} <br>
k >= 10 : ${ k >= 10 } <br>
m : ${ m } <br>
!m : ${ !m } <br>

</body>
</html>
```




