# Delegate pattern
---

# INDEX
[Delegation In Swift Explained](https://learnappmaking.com/delegation-swift-how-to/)

- [What is Delegation?](#What-is-Delegation)

- [Delegation: A Simple Example in Swift](#Delegation:-A-Simple-Example-in-Swift)

- [Delegation In Practical iOS Development](#Delegation-In-Practical-iOS-Development)

- [Why Use Delegation?](#Why-Use-Delegation?)


<br>
<br>

### 1. Delegation In Swift Explained
---

Delegation ( Delegate Pattern) 은 실제 `iOS` 개발에서 매우 자주 사용되는 디자인 패턴이다.

이 `Delegate Pattern` 의 작동 방식에 대해 상세히 알아보도록 한다.

<br> <br>

### What is Delegation?
---

애플 공식 문서에서는 `delegation`을 아래와 같이 정의하고 있다.

> **딜리게이션 이란 일부 클래스의 책임을 다른 클래스의 인스턴스에게 위임 또는 전달할 수 있는 디자인 패턴을 의미한다.**
>

내용이 매우 복잡하다.. 이를 분석해보도록 한다.

현실에서의 `delegation`에 대해 생각해보자.

당신과 내가 초콜릿 쿠키를 만들어 전달하는 팀의 일원이라고 상상해보자.

당신이 쿠키 제빵을 담당하며 이를 위해 필요한 '쿠키 반죽 만들기' 일을 나에게 **위임**(delegate) 한다.

내가 도우를 만들고 이를 당신에게 전달해주면 당신은 그것을 이용해서 쿠키를 만들수 있다.

몇가지 핵심 사항에 대해 알아보자.

-   당신은 쿠키를 만드는 작업을 맡았기에 나에게 '쿠키 도우 만들기' 업무를 위임한다.

-   나는 위임된 작업 (쿠키 반죽 도우 만들기)을 마치면 쿠키 반죽을 당신에게 제공한다.

즉, 당신이 나에게 '쿠키 반죽 만들기' 라는 업무를 위임한다.

`swift`에서의 `delegation` 또한 이와 별 반 차이가 없다.

한 클래스가 다른 클래스에게 업무를 위임한다.

<br>
<br>


### Delegation: A Simple Example in Swift
---
스위프트 예제를 살펴보자.

우리는 `Cookie` 라는 구조체를 아래와 같이 정의한다.

```swift
struct Cookie {
    var size: Int = 5
    var hasChocolateChips: Bool = false
}
```

이후 `Bakery`라는 클래스를 아래와 같이 정의한다.

```swift
class Bakery {
    func makeCookie() {
        var cookie = Cookie()
        cookie.size = 6
        cookie.hasChocolateChips = true
    }
}
```

위 코드를 살펴보면, `Bakery` 라는 클래스는 내부에서 `Cookie`구조체를 사용하여 `cookie`를 생성하고 일부 속성을 설정하는  `makeCookie()` 라는 함수를 가지고 있다.

이 시점에서 우리는 대략 세 가지 방식으로 만들어낸 쿠키를 판매하려고 한다.

-   오프라인 베이커리 샵에서 판매
-   온라인 베이커리 웹 사이트에서 판매
-   유통 업체 도매를 통한 판매

쿠키를 판매하는것은 엄연히 우리 팀의 책임이 아니다.

하지만 쿠키를 만들어 전달하는 것 까지는 우리의 책임이다.

따라서, 우리는 쿠키를 만들고 나서 이를 전달할 수 있는 방법이 필요하다.

여기서 **딜리게이션** 개념이 이용된다.

첫번째, 우리는 **프로토콜**을 정의할 것이다.

그 프로토콜 내에는 마치 아래처럼 우리의 쿠키를 판매처에 전달하는 책임의 내용들을 캡슐화 할 것이다. 

```swift
protocol BakeryDelegate {
    func cookieWasBaked(_ cookie: Cookie)
}
```

위 프로토콜 안에는 `BakeryDelegate`는 한가지 함수 `cookieWasBaked`가 선언되어있다.

이 델리게이트 함수(=`cookieWasBaed`)는 쿠키가 구워질 떄 마다 호출된다.

두번쨰, 위 `delegate`를 아래처럼 `Bakery` 클래스 내부에 통한한다.

```swift
class Bakery {
    var delegate: BakeryDelegate?

    func makeCookie() {
        var cookie = Cookie()
        cookie.size = 6
        cookie.hasChocolateChips = true

        delegate?.cookieWasBaked(cookie)
    }
}
```

기존 `Bakery` 클래스에서 두가지가 추가되었다.

> 1. `BakeryDelegate` 타입의 `delegate` 프로퍼티가 추가되었다.
>
> 2. 함수 `cookieWasBaked()`가 `makeCookie()` 함수 내부 델리게이트에서 호출된다.

이것이 전부가 아니다.

추가된 `delegate` 프로퍼티는 우리가 앞서 정의한 프로토콜이다.

이는 `BakeryDelegate`를 의무적으로 준수해야 한다.

`delegate` 프로퍼티는 옵셔널 속성을 갖는다. 우리는 `cookieWasBaked(_:)` 함수를 호출할 때 옵셔널 체이닝을 이용한다.

이와 같이 어떠한 클래스가 해야할 일을 타 클래스에게 위임하는 것을 `Delegation`이라고 한다.

이제는 실제 `iOS`에서 이용되는 예시를 살펴보도록 하자.

<br>
<br>

### Delegation In Practical iOS Development
---

`Delegation` 은 iOS 개발에서 이용되는 대표적인 디자인 패턴 중 하나다.

이를 사용하지 않고 `iOS` 앱을 개발하는 것을 거의 불가능에 가깝다고 한다.

대표적인 예시로 `UITableView` 클래스는 `UITableViewDelegate` 프로토콜과 `UITableViewDataSource` 라는 프로토콜을 통해 테이블을 관리하고 상호작용하고 셀을 보여주고 한다.

`UITextView`는 `UITextViewDelegate` 라는 프로토콜을 사용하여 텍스트 뷰 내부의 상태변화 (ex: 문자 삽입, 편집 중지)를 보고받는다.

`TextView`는 임의의 사용자 입력에 응답하고 이에 따라 델리게이트 기능을 호출한다.

아래 예시를 살펴보도록 하자.

메모 작성을 위해 간단한 view Controller를 만들고 있다고 가정해보자.

`TextView`가 포함되며 해당 `TextView`는 `delegation`을 사용한다.

```swift
class NoteViewController: UIViewController, UITextViewDelegate {
    var textView: UITextView

    func viewDidLoad() {
        textView.delegate = self
        // 텍스트 뷰의 델리게이트는 노트뷰컨트롤러의 인스턴스
    }
}
```

우리는 `UIViewController`를 상속받는 `NoteViewController` 라는 클래스를 생성하였다.

이는 동시에 `UITextViewDelegate` 라는 프로토콜 또한 채택하고 있다.

클래스 내부에는 `UITextView` 의 인스턴스인 `textView`를 선언하였다.

`viewDidLoad()` 함수 내부를 보면, 텍스트 뷰의 델리게이트를 `self`로 지정하였다.

다르게 말하면, `NoteViewController`의 인스턴스가 텍스트 뷰의 델리게이트로 지정되었다.

상속한 [UITextViewDelegate](https://developer.apple.com/documentation/uikit/uitextviewdelegate)를 보면, 텍스트 뷰에서 발생하는 이벤트에 응답하기 위해 다양한 delegate 함수들을 구현할 수 있다.

이러한 기능 중 일부 기능들은 아래와 같다.

-   `textViewDidBeginEditing(_:)`
-   `textViewDidEndEditing(_:)`
-   `textView(_:shouldChangeTextIn:replacementText:)`
-   `textViewDidChange(_:)`

예를 들어, 텍스트 뷰의 수정이 시작되거나 끝나면 텍스트 뷰를 강조하여 편집중인 부분을 사용자에게 강조하여 보여줄 수 있다.

혹은, `textViewDidChange(_:)` 기능을 통해 텍스트 뷰에 기재된 문자의 수를 표시하는 `count` 를 업데이트 할 수도 있다.

`Delegate`를 통해 업무를 위임한다기 보다는 할 수 있는 기능을 확장하기 위해 사용하는 것이 `Delegate Pattern` 이라고 느껴진다.

그러면 이제 마지막으로 `Delegation`이 왜 사용되는지 알아본다.

<br>
<br>

### Why Use Delegation?
---

"델리게이트 패턴을 이용하는 이유"에 대하여 알아본다.

-   델리게이션, 델리게이트 패턴은 한 클래스와 다른 클래스의 상호작용을 간단히 할 수 있도록 돕는다.

-   클래스 간 요구 사항을 전달해주는 프로토콜만 있으면 연결이 수월해진다.

-   완전한 클래스 또는 구조체를 상속할 필요가 없기 떄문에 델리게이션은 더욱 가볍게 사용할 수 있다.

-   델리게이트 패턴은 1:1 관계에서 매우 유용하며 옵저버 패턴은 1:N 또는 N:N 관계에 더욱 적합하다.

-   델리게이트는 프로토콜을 준수 하는것 만으로 구현이 가능하므로 매우 유연하다.

**즉, 제어하지 않는 코드 내에서 발생하는 이벤트를 "연결" 할 수 있는 좋은 방법이다.**


<br>

이상으로 델리게이트 패턴에 대한 내용 정리를 마치도록 한다.