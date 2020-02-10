### Servlet

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