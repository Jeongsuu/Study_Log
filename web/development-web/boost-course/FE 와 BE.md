## Web Front-end & Web Back-end

### 웹 프론트앤드
---

사용자에게 웹을 통해 다양한 콘텐츠(웹 리소스)를 제공한다. 또한 사용자의 요청에 반응하여 동작한다.

<br>

### 웹 프론트앤드의 역할
---
웹 콘텐츠를 잘 보여주기 위해 구조를 만들어야 한다.

적절한 배치와 일관된 디자인등을 제공해야 한다.

사용자 요청을 소통하듯 잘 반영해야 한다.

이런것들을 기술적으로 가능하게 하려면

`HTML , CSS , Javascript` 를 이용해야한다.

이 세가지가 웹 프론트 역할을 달성시켜준다.

<br>

#### HTML 코드 예시
---
원하는 문서의 구조를 프로그래밍 언어로 표현해야 한다.

HTML은 그 구조를 잘 표현해준다.

```html
<h1>우리집에 오신걸 환영합니다.</h1>
<section>
    <h2> 위치</h2>
    <p> 서울특별시 어딘가</p>
</section>
<footer> email : duwjdtn1@gmail.com</footer>

#### JavaScript 코드예시
---
HTML, CSS를 이리저리 움직이고 변경할 필요가 있다.
JavaScript가 그 역할을 해준다.

```javascript
let aCardList = [];
for(var i=0; i<cardList.length; i++) {
    let str = `$(cardList[i])`;
    let id = `list - $(cardList[i])`;
    aCardList.push(<li id={id} key={i} draggable='true' onDragStart={dragStart}> {str} </li>)
}
```
<br>

#### 백 엔드 개발자가 알아야 할 것들
프로그래밍 언어(JAVA,  Python, PHP, Javascript 등)
웹의 동작 원리

알고리즘(algorithm), 자료구조 등 프로그래밍 기반 지식

운영체제, 네트워크 등에 대한 이해

프레임워크에 대한 이해(예: Spring)

DBMS에 대한 이해와 사용방법(예: MySQL, Oracle 등)

<br>

## browser의 동작
---
웹을 통해서 전달되는 데이터는 어딘가에서 해석되어야 한다.
서버에서 전송한 데이터가 클라이언트에 도착해야 할 곳은 `Browser`이다.
`Browser`에는 데이터를 해석해주는 파서와 데이터를 화면에 표현해주는 렌더링 엔진이 포함되어 있다.

이번엔 웹 브라우저 렌더링에 대하여 알아본다.

`Firefox - Gecko`, `Safari - Webkit` , `Chrome & Opera - Blink`
등이 있다.

렌더링 엔진은 각각의 브라우져 별로 가지고있다.

