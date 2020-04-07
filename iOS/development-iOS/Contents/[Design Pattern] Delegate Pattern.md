## [Design Pattern] Delegate Pattern
---

토이프로젝트 진행중 `Delegate Pattern`에 대한 이해가 부족하다고 생각되어 다시 정리한다. 



### Delegate Pattern
---

`Delegate Pattern` 을 이해하기 이전에 `Protocol`에 대해서 먼저 익히도록 한다.
<br>
<br>

### Protocol Basic
---
`Swift`의 강력한 기능중 하나인 `Protocol`.

이 프로토콜이란게 무엇인지 알아보도록 한다.

애플 공식문서에 정의된 프로토콜은 아래와 같다.
>
> `A Protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality`

"프로토콜은 특정 작업 또는 기능을 구현하기 위한 메소드, 프로퍼티, 그 외 요구사항들의 청사진이다."

정말 설명 그대로다.

프로토콜은 의미 그대로 **규약**이다.

프로토콜을 채택시에는 그 프로토콜 내 약속된 메소드를 구현해야 한다.

아래 예시를 살펴보자.

```swift
protocol Bird {
    var name: String { get }
    var canFly: Bool { get }

}

protocol Flyable {
    var speedVelocity: Double { get }
}
```

프로토콜은 클래스의 다중 상속과 유사한 기능을 스위프트에서는 프로토콜의 다중 채택으로 기능을 제공한다.

**즉, 이러한 기능을 통해 재사용성을 높혀 시스템 전체의 유연성을 가져온다.**

```swift
struct ExBird: Bird, Flyable {      // ExBird는 Bird와 Flyable 프로토콜을 "다중" 채택한다.
    let name :String
    let Amplitude: Double
    let Frequency: Double
    let canFly = true

    var speedVelocity: Double {
        return 3 * Amplitude * Frequency
    }
}
```

위 `ExBird` 구조체는 프로토콜 `Bird` 와 `Flyable`을 준수한다.

이번엔 두개의 구조체를 더 만들어본다.

```swift
struct Penguin: Bird {
    let name: String
    let canFly = false
}

struct Swifter: Bird, Flyable {
    var name: String { return "swift \(version)" }
    var version: Double
    let canFly = true

    var speedVelocity: Double { return version*100 }
}
```
펭귄은 `Bird`이지만 `Flyable`하지 못한다. 
만일 `Flyable` 프로토콜을 `base`로 해서 `Bird` 프로토콜을 만들었다면 매우 난처한 상황이 발생했을 것이다.

하지만 프로토콜을 사용한다면 기능적 요소들을 정의하여 이와 연관된 객체들이 프로토콜을 준수하도록 한다.

위 코드에서는 아쉬운 점들이 있다.

반복하지 않아도 될 코드들이 있다. 모든 `Bird` 타입의 자료형은 `Flyable` 이라는 개념이 존재함에도 불구하고 프로퍼티로 `canFly`를 명시해주고 있다.

이것은 스위프트의 `Extension` 기능을 통해 해결할 수 있다.
<br>

### Protocol Extension
---

```swift
extension Bird {
    var canFly: Bool { return self as Flyable }
}
```

위와 같이 `Bird` 프로토콜을 `extension`을 통해 확장시킬 수 있다.

이러한 `Implementation`을 통해 디폴트 행위에 대한 것을 미리 정의하여 불필요한 코드가 반복되는 것을 막을 수 있다.

---
---

이제 `Delegate Pattern` 에 대해 알아보자.

스위프트 관련 인강이나 도서의 예제코드를 공부하다 보면
```swfit
someObjectProperty.delegate = self
```
위와 같은 코드를 많이 볼 수 있다.

한번 그냥 읽히는대로 해석해보자.

"어떤 객체의 프로퍼티의 딜리게이트 는 자기자신?" 정도로 해석된다.

과연 이것이 무슨 의미인지 확실히 알아보자.

`Delegate` 는 '위임하다', '대리로 임명하다' 등의 의미를 갖고있다.

즉, 어떠한 객체에서 일어나는 이벤트 또는 어떠한 객체에 뿌려줄 데이터에 관한 코드를 다른 객체에서 제어하는 것이다.

A객체의 일을 B객체에서 대신 하는 행위를 의미한다.

그렇다면 일을 시키는 객체가 있을것이고, 일을 하는 객체가 따로 있을 것이다.

- protocol : 앞으로 해내야 하는 일의 목록
- sender : 일을 시키는(위임하는) 객체
- receiver : 일을 하는(위임받는) 객체

대충 `Delegate`가 무엇을 의미하는지는 알겠는데 어떻게 적용하고 이것을 왜 적용하는건지를 모르겠다.

이에 대해서 알아보자.

<br>

#### 어떻게 Delegate를 적용하는가?
---

1. 요구사항을 파악한다.
    - 각각의 `delegate`들은 `protocol`에 의해 나열된 그들의 규칙이 있다.

2. `Delegation` 을 채택한다.
    - 클래스명: SomeDelegate 를 작서ㅓㅇ하여 해당 클래스가 `SomeDelegate Protocol`을 채택한다는 것을 표현한다.

3. `Delegate` 객체 (일을 시키는 객체)와 연결한다.
    - `protocol`을 따르는 객체는 일의 목록을 수행해야하는데, 그 전에 이 일이 어떤 객체로부터 위임된건지 명시해주어야 한다.

4. 요구사항 구현
    - 위임받은 일(요구사항)을 구현한다.
    즉 protocol의 함수들을 구현하는 단계다.

#### 예시

예시로 `UITextFieldDelegate`에 대해 살펴본다.

- UITextFieldDelegate는 UITextField의 객체의 문구를 편집하거나 관리하기 위해 아래와 같은 메소드를 정의해 두었다.

```swift
// 대리자에게 특정 텍스트 필드의 문구를 편집해도 되는지 묻는 메서드
func textFieldShouldBeginEditing(UITextField)

// 대리자에게 특정 텍스트 필드의 문구가 편집되고 있음을 알리는 메서드
func textFieldDidBeginEditing(UITextField)

// 특정 텍스트 필드의 문구를 삭제하려고 할 때 대리자가 호출하는 메서드
func textFieldShouldClear(UITextField)

// 특정 텍스트 필드의 `return` 키가 눌렸을 때 대리자가 호출하는 메서드
func textFieldShouldReturn(UITextField)
```

**위 메서드를 살펴보면 알 수 있듯, 델리게이트는 특정 상황에 대리자에게 메시지를 전달하고 이에 대한 적절한 응답값을 받기 위한 목적으로 사용된다.**

![image](https://user-images.githubusercontent.com/33051018/78620456-08cb9a80-78bb-11ea-930c-9a481bdd8139.png)

그래서 `delegate protoocl`에 약속된 메소드들을 알 필요가 있다.

`self.textfieldDelegate.delegate = self`

이런식으로 뷰 컨트롤러가 `UITextField`의 Delegate(대리자)로 지정되었다고 하면,

구현해놓은 위 함수들 중 조건이 충족되는 함수는 해당 함수가 실행되어 뷰 컨트롤러가 `UITextField`에게 알려준다.

