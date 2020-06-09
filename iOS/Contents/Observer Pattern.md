# Observer Pattern in Swift

<br>

오늘은 `Swift Design Pattern` 중 `Observer Pattern`에 관하여 알아보도록 한다!

<br>

## What is Observer Pattern?
---

`Observer`, ~~내가 아는 옵저버는 스타크래프트에서 나오는 옵저버 뿐..~~ 이지만, 어떻게 보면 그 옵저버와 동일하다!

`Observer`는 단어의 뜻 그대로 관찰자 역할을 한다. 

>`Observer Pattern`은 프로퍼티가 변경 여부를 관찰하고 있다가 변경 되는 시점에서 `update`가 수행되는 방식의 디자인 패턴을 의미한다!
>
> 즉, 객체의 상태 변화에 따라 다른 객체의 상태 또한 연동되도록 객체간의 `1:N` 의존 관계를 구성하는 패턴이다.

우리가 코드를 작성하다 보면 특정 값에 대한 변경이 발생할 때 연쇄적으로 해당 값을 참조하고 있는 값들을 자동적으로 변경이 이루어져야 할 때 유용하게 사용이 된다!

<br>

## Observer pattern with protocols
---

`Observerable`한 패턴을 위해 프로토콜을 통해 접근 방식을 정의한다!

프로토콜 내부에는 `id` 프로퍼티를 갖게한다.

```swift

protocol Observer{
    var id: Int { get }
    func update()

}
```

다음으로 `Subject` 라는 클래스를 작성한다. 해당 클래스는 객체에게 업데이트를 알리는 역할을 하게 될 것이다.

우리가 옵저버를 `attach`하면, 이를 `observerArray`에 넣을것이다. 또한, 다른 객체에게 `notify`하면 우리는 `observerArray`를 순회하며 `Observer` 프로토콜 내 `update()` 함수를 호출할 것이다.

```swift

class Subject {

    private var ObserverArray = [Observer]()
    private var _number = Int()

    var number: Int {               
        set {
            _number = newValue
            notify()
        }

        get {
            return _number
        }
    }

    func attachObserver(observer: Observer) {
        observerArray.append(observer)
    }

    private func notify() {
        for observer in observerArray {
            observer.update()
        }
    }
}
```

`Observer` 프로토콜을 채택하는 클래스의 작업은 `Subject`에서 `ID`를 할당하고 `Subject` 내에서 호출될 떄 `update()` 를 실행한다.

```swift

class BinaryObserver: Observer {

    private var subject = Subject()
    var id = Int()

    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self)
        self.id = id
    }

    func update() {
        print("Binary: \(String(subject.number, radix: 2))")
    }

}

class HexObserver: Observer {

    private var subject = Subject()
    var id = Int()

    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self)
        self.id = id
    }

    func update() {
        print("Hex: \(String(subject.number, radix: 16))")
    }

}

class OctaObserver: Observer {

    private var subject = Subject()
    var id: Int()

    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self)
        self.id = id
    }

    func update() {
        print("Octa: \(String(subject.number, radix: 8))")
    }
}
```

자 이제 모든 준비가 끝났다.

`Subject` 객체를 생성하고 모든 옵저버를 생성해보자.

```swift

let subject = Subject()

let binary = BinaryObserver(subject: subject, id: 1)
let octa = OctaObserver(subject: subject, id:2)
let hex = HexObserver(subject: subejct, id: 3)

subject.number = 15         // 값 변경
subject.number = 2          // 갑 변경

//output
/*
Binary: 1111
Octal: 17
Hex: f
Binary: 10
Octal: 2
Hex: 2
*/
```

보다시피 우리가 `subject`의 값을 업데이트 할 때 마다 `update()` 메서드를 호출하기 위해 관련된 모든 `observer`들에게 이를 알린다.

이렇게 한 객체의 변화에 따라서 해당 객체에 관련된 무엇을 변경하거나 수정해야 할 경우, `Observer` 패턴을 많이 이용한다.


이번에는 간단히 개념과 예시를 통해 소개했지만 다음에는 실제 프로젝트에 해당 념을 적용해보며 더욱 디테일하게 알아보도록 하자.
