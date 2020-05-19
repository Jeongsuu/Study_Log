# Singleton Pattern

### Singleton Pattern

![image](https://user-images.githubusercontent.com/33051018/82333248-69ed9e80-9a21-11ea-87cc-85226f166ace.png)

iOS에서의 싱글톤이란 영어 사전 1번 뜻인 단독 개체라는 의미에 가깝다.

애플은 "싱글톤 객체는 응용 프로그램이 몇번 요청하는지에 관계없이 동일한 인스턴스를 반환한다." 라고 싱글톤을 설명하고 있다.

위 설명대로 싱글톤은 특정용도의 객체를 단 하나만 정적으로 생성하여 공용으로 사용하고자 할 때 사용한다.

이 객체는 메모리에서 해제해주지 않는 이상 프로그램이 끝날 떄 까지 메모리에 유지된다.

`Apple`의 프레임워크를 이용하다 보면 아래와 같은 코드를 살펴본 적이 있을것이다.

```swift

let sharedURLSession = URLSession.shared

let standardUserDefautls = UserDefaults.standard

```

싱글톤 패턴은 하나의 객체를 하나의 애플리케이션 내에서 공용으로 사용하기 떄문에  `Global Access`가 가능하다.

싱글톤 객체는 아래와 같이 생성한다.

```swift
class Singleton {
    static let shared = Singleton()
}
```

`shared` 프로퍼티는 static 프로퍼티다.

따라서, scope에 제약을 받지 않고 우리가 원하는 어디서든지 접근이 가능하다.

위와 같은 편리함은 있으나 편리함에 따른 대가도 있다.

싱글톤 인스턴스가 다양한 부분에서 참조되어 많은 일을 하거나 데이터를 공유할 경우, 다른 클래스의 인스턴스들 간 결합도가 높아져 설계에 위험이 존재하게 된다.

전역적으로 접근이 가능하기에, 전역적으로 변경 또한 가능한 상태를 제공한다.

싱글톤 패턴은 많은 위험이 따르기에 많은 개발자들이 사용을 지양한다.

