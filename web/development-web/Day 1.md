### 웹 프로그래밍이란?

---

1. 웹 프로그래밍이란, 웹 어플리케이션을 구현하는 행위를 의미한다
2. 웹 어플리케이션이란, 웹을 기반으로 작동하는 프로그램이다.
3. 웹이란, 1개 이상의 사이트가 연결되어있는 인터넷 서비스의 한가지 형태를 의미한다.
4. 인터넷이란, 1개 이상의 네트워크가 연결되어 있는 형태를 의미한다.

- **프로토콜** : 네트워크 상에서 약속한 통신규약 (e.g, http, ftp, smtp, dhcp)
- **IP** : 네트워크 상에서 컴퓨터를 식별할 수 있는 주소
- **DNS** : IP주소를 인간이 쉽게 외우도록 맵핑한 문자열
- **Port** : IP 주소가 컴퓨터를 식별할 수 있게 해준다면, Port 번호는 해당 컴퓨터의 구동되고 있는 프로그램을 구분할 수 있는 번호



### Java Web

---

Java 플랫폼 (J2SE, J2EE) 중 J2EE를 이용한 웹 프로그래밍이다.

![image](https://user-images.githubusercontent.com/33051018/74084821-38764600-4ab6-11ea-8742-54f66e3bfd94.png)

- **컴포넌트** : JSP, Servlet, HTML 등의 웹 어플리케이션을 구현하기 위한 구성요소
- **JSP : HTML파일 내에 Java언어를 삽입한 문서**
- **Servlet(Server Applet) : Java언어로 이루어진 웹 프로그래밍 문서**



### 웹 프로그램의 동작 (매우 중요)

---

1. 웹 서버 - 클라이언트의 요청에 의해 정보를 제공해주는 서버(Apache, IIS...etc) 별도의 구현이 필요한 로직이 있을 경우 웹 어플리케이션 서버에 요청.
2. 웹 브라우저 : 웹 서버에 정보를 요청하고, 웹 서버로부터 정보를 받은 매개체, 이때 HTTP 프로토콜 사용.

![image](https://user-images.githubusercontent.com/33051018/74084919-4d9fa480-4ab7-11ea-8c5e-3ddbc57656d2.png)

**클라이언트 쪽에서는 Javascript가 돌고, 백단에서 JSP, Servlet이 도는것.**

요청 내용에 따라 바로 `response`를 보낼 수 도 있으나 DB를 거쳐야 하는 경우

웹 서버로 요청 -> 해당 요청을 WAS로 요청 -> DB로 요청 이후 `response`

- Jquery : JavaScript의 대표적인 라이브러리로써, 클라이언트 사이드 스크립트 언어로 단순화 할 수 있다.





### JSP 작성 & 아키텍처

---

**JSP 특징**

- **동적 웹 어플리케이션 컴포넌트**

- .jsp 확장자

- 클라이언트의 요청에 동적으로 작동하며, 응답은 `html` 형식을 이용

- **jsp는 서블릿으로 변환되어 실행된다.**

- **MVC패턴에서 View로 이용된다.**

  MVC : Model & View(JSP) & Controller(servlet)

- **클라이언트가 데이터 리퀘스트시 컨트롤러가 모델한테 요청을 전송하고 데이터를 가공하여 반환하면 이를 컨트롤러가 View로 반환하여 View가 클라이언트에게 response**

- JSP는 주로 View 단 에서 사용된다.

![image](https://user-images.githubusercontent.com/33051018/74085670-e128a380-4abe-11ea-95e5-17ebfb50f5a0.png)



### Servlet 작성 & 아키텍처

---

**Servlet 특징**

- 동적 웹 어플리케이션 컴포넌트
- .java 확장자
- 클라이언트 요청에 동적으로 작동하며, 응답은 `html` 형식을 이용
- **Java thread를 이용하여 동작**
- **MVC 패턴에서 `Controller`로 사용된다.**