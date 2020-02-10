## Servlet

---

**Servlet** : 웹 프로그래밍에서 클라이언트의 요청을 처리하고 그 결과를 다시 클라이언트에게 전송하는 Servlet 클래스의 구현 규칙을 지킨 자바 프로그래밍 기술

간단히 말하여 `Servlet`이란 자바를 사용하여 웹을 만들기 위해 필요한 기술이다. 

클라이언트가 어떠한 요청을 하면 그에 대한 결과를 다시 전송해주어야 하는데, 이러한 역할을 하는 자바 프로그램이 `servlet`이다.

일반적인 웹 서버는 정적인 페이지만 제공한다. 그렇기에 동적 페이지를 제공하기 위해서 웹 서버는 다른 곳에 도움을 요청하여 동적인 페이지를 작성해야 한다. 여기서 웹 서버가 동적 페이지를 제공할 수 있도록 도와주는 어플리케이션이 `servlet`이다.

![image](https://user-images.githubusercontent.com/33051018/74113169-e2a0bb80-4be5-11ea-8307-40c644c9bee0.png)

클라이언트에서 `servlet` 요청이 들어오면 서버에서는 `servlet`컨테이너를 만들고, 요청이 있을 때마다 스레드가 생성된다.

![image](https://user-images.githubusercontent.com/33051018/74116352-8abe8080-4bf6-11ea-8092-5eff968987a4.png)

다른 서버 언어에 비해서 서버 부하가 적게 걸려서 효율적으로 서버를 운영할 수 있다.



### Servlet 라이프사이클

---

Servlet의 사용도가 높은 이유는 빠른 응답 속도 때문이다.

**Servlet은 최초 요청시 객체가 만들어져서 메모리에 로딩되고, 이후 요청시에는 기존의 객체를 재활용하게된다 -> 빠른 동작 속도**

**`Servlet 객체 생성`최초 한번 -> `Init() 호출`최초 한번 -> `service()), doGet(), doPost() 호출`요청시 매번 -> `destroy() 호출`마지막 한번** 

![image](https://user-images.githubusercontent.com/33051018/74116719-2b617000-4bf8-11ea-88ca-fcc43ed75c8e.png)



### Servlet 선처리, 후처리

---

`Servlet`의 라이프 사이클 중 `init()`과 `destory()`메소드와 관련하여 선처리(init) 후 후처리(destory) 작업이 가능하다.

`@Annotation`을 통해 선언 가능.

![image-20200210130703466](/Users/mac/Library/Application Support/typora-user-images/image-20200210130703466.png)

 ![image](https://user-images.githubusercontent.com/33051018/74120570-2a840a80-4c07-11ea-9628-64d1174e4156.png)

**선처리**는 이름 그대로 init이전에 실행됨

**후처리**는 이름 그대로 destory 이후에 실행됨.

이러한 콜백 함수를 정확히 알고 있어야 한다.





### HTML Form 태그

---

- HTML Form 태그는 서버쪽으로 정보를 전달할 때 사용하는 태그이다.



**input** : 태그의 종류를 지정한다.

- **속성(type, name, value)**
  - **type** : 태그 종류 지정 (ex, text, password, submit, checkbox, radio, reset)
  - **name** : input태그 이름
  - **value** : name에 해당하는 값 (ex, name = value) 
- type = text
  - ​	일반적인 데이터를 입력하기 위해 사용.
  - <input type="text" name="name" size="10">
- type = password
- 로그인 회원가입 페이지 등 비밀번호를 입력하기 위한 폼
  - <input type="password" name="name" size="10">

![image](https://user-images.githubusercontent.com/33051018/74121188-ddedfe80-4c09-11ea-8da5-b18f95c40acf.png)

![image](https://user-images.githubusercontent.com/33051018/74121299-653b7200-4c0a-11ea-8c31-693f23acd19c.png)



### Servlet Parameter

---

**Form 태그의 `submit` 버튼을 클릭하여 데이터를 서버로 전송하면, 해당파일(Servlet)에서는 `HttpServletRequest` 객체를 이용하여 Parameter값을 얻을 수 있다.**

String id = request.getParameter("id");

String pw = request.getParameter("pw");

![image](https://user-images.githubusercontent.com/33051018/74121771-3e7e3b00-4c0c-11ea-951b-35347b32f1e0.png)



### 한글 처리

---

`Tomcat` 서버는 기본 문자처리 방식의 따라 한글을 지원하지 않는다. 따라서 한글이 깨져보이기 때문에

별도 인코딩이 필요하며 `GET`방식과 `POST` 방식 별도로 작업을 진행하여야 한다.

**Get방식의 경우**

>`server.xml` 내 `connector` 태그에 
>
>```java
>URIencoding="EUC-KR"
>```
>
>을 추가한다.



**Post방식의 경우**

>![image](https://user-images.githubusercontent.com/33051018/74131272-53b49300-4c27-11ea-9bd9-a79704a5a977.png)
>
>`doPost()` 메소드 최상단에 위 내용 추가.



