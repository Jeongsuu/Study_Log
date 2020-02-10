### Servlet

---

서블릿은 `HttpServlet`라는 클래스를 상속받는다.

서블릿은 `java`언어를 사용하여 웹 프로그램을 제작하는 것.

`Servlet(interface) <- GenericServlet(abstract) <- HttpServlet`



### doGet() & doPost()

---

클라이언트에게 요청이 들어오면 `WAS`에서는 `request`객체와 `response`객체를 탐캣에서 생성해준다.

이를 바탕으로 우리가 사용하는 `doGet() & doPost()`메서드의 인자값으로 넣어준다.

예를들어, 우리가 로그인 기능을 이용할때 ID 와 PW값을 `request` 객체에 담아서 전달한다.

그 이후 `WAS` 에서는 이를 받아 `DataBase`에서의 일련의 절차를 통해 검증하고 이에 대한 결과값을 `response`객체에 실어서 클라이언트에게 전달해준다.

**Tomcat이라는 서버를 통해 `request`,`response` 객체를 통해 통신한다.**

`servlet`파일의 경우에는 자바파일이기 때문에 `html` 태그들을 직접 작성해준다.

![image](https://user-images.githubusercontent.com/33051018/74102419-a7bb6b00-4b86-11ea-81c2-ff35003e3b26.png)

`JSP`와 비교해보면, JSP는 기본적으로 html 태그를 지원하기 때문에 따로 이러한 작업들을 안해도 된다.

그러나 `servlet`은 자바파일 이므로 응답을 할 때 반드시 `html`로 응답을 하겠다는 `ContetType`을 지정해줘야 하며 스트림을 이용해서 태그를 보내줘야한다.

우리가 클라이언트에서 웹 어플리케이션쪽으로 `request`할 때 `GET & POST`방식을 이용한다.

이는 `html` 에서 호출 하는 메소드가 `get` 이면`servlet`에서  `doGet`호출 , `post`이면 `doPost`호출

**doGet() & doPost() 차이점**

>`GET` : URL값으로 정보가 전송되어 보안에 취약.
>
>`POST` : `header`를 이용해 정보가 전송되어 상대적으로 보안에 강함.



### doGet()

---

- `html`내 `form` 태그의 `method`속성이 `get`일 경우 호출된다.
- 웹 브라우저의 주소창 `URL`을 이용하여 `servlet`을 요청한 경우에도 호출된다.
- `doGet`메소드는 매개변수로 `HttpServletRequest`와 `HttpServletResponse`를 받는다.

웹 브라우저에서 요청하면 doGet()메소드가 호출되고 `Request` 객체와 `Response` 객체를 호출해서 인자로 전달한다.

**`doGet`메소드 호출시 `response.setContentType`을 통해 응답 방식을 결정한다.**

```java
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Hello World~~");
		
		response.setContentType("text/html"); //content 타입을 처리하는것
		PrintWriter writer = response.getWriter();
```

출력 스트림의 `println()`메소드를 이용하여 출력하면 웹 브라우저에 출력된다.

```java
		writer.print("<html>");
		writer.print("<head>");
		writer.print("</head>");
		writer.print("<body>");
		writer.print("<h1>Hello World~~</h1>");
		writer.print("</body>");
		writer.print("</html>");
```

![image](https://user-images.githubusercontent.com/33051018/74102722-93c53880-4b89-11ea-9548-f4878c586c61.png)



### Context Path

---

- **WAS에서 웹 어플리케이션을 구분하기 위한 `path`다.**
- IDE에서 프로젝트 생성시 자동으로 `server.xml`에 추가된다.



### MVC 패턴이란?

---

Model, View, Controller의 합성어로 소프트웨어 공학에서 사용되는 소프트웨어 디자인 패턴이다.

`Model` : 백그라운드에서 동작하는 로직을 처리한다.

`View` : 클라이언트가 보게 될 결과 화면을 출력한다.

`Controller` : 사용자의 입력처리와 흐름 제어를 담당한다.

`JSP`웹사이트의 구조는 크게 모델 1 방식과 모델 2 방식으로 나뉘어진다.

간단히 분류하자면 `JSP`에서 출력과 로직을 전부 처리하면 모델 1, JSP에서 출력만 처리한다면 모델2로 분류한다.

모델2 구조는 웹 브라우저의 사용자의 요청을 `Servlet`이 받는다.

`Servlet`은 웹 브라우저의 요청을 받아 `View`로 보여줄 것 인지 `Model`로 보내줄 것 인지 정하여 전송한다.

여기서 `View` 페이지는 사용자에게 보여주는 역할만 담당하고 실질적 기능의 부분은 `Model`에서 담당한다.

모델2 방식은 실질적으로 보여지는 `HTML`과 `Java`소스를 분리해놓았기 때문에 모델1 방식에 비하여 개발을 확징시키기도 쉽고 유지보수에도 용이하다.

