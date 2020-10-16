# POP (Protocol - Oriented - Programming)

<br>

안녕하세요 오늘은 `Swift` 언어의 큰 특징 중 하나인 `POP` 에 대하여 알아보겠습니다.

<br>

## 프로토콜 지향 프로그래밍 (Protocol - Oriented - Programming)
---

<br>

Swift 언어를 공부하다보면 관련 문서 혹은 서적에서 한번쯤은 접했던 POP가 과연 무엇일까요?

**객체 지향 프로그래밍** 패러다임에 기반을 둔 언어들은 **클래스의 상속** 을 사용하여 해당 타입이 가질 공통적인 기능들을 모듈화하여 구현합니다.

Swift에서는 대표적으로 `UIViewController`가 클래스 타입으로 정의되어 있죠.

![image](https://user-images.githubusercontent.com/33051018/96221251-2e9dce80-0fc5-11eb-85f9-b9657fe05729.png)

`UIViewController` 가 클래스로 정의되어 있기에 모든 `ViewController`에서 행할 수 있는 행동들을 공통적으로 갖게되죠!

하지만 이런 **참조 타입**의 경우에는 다중 스레드 환경에서 사용에 유의해야 합니다, 그렇지 않으면 원본을 참조하는 여러 인스턴스를 사용하다가 원하지 않는 곳에서 잘못된 참조로 인하여 원본 데이터가 변경되는 리스크가 존재하기 때문이죠.

(그래서 우리의 애플은 특정 상황을 제외하고는 다양한 이유로 **구조체** 사용을 권장합니다.)

그렇지만, **구조체** 혹은 **열거형** 의 경우에는 **클래스** 와는 달리 **상속**이 불가합니다.

하지만, Swift의 표준 라이브러리 내부를 살펴보면 대부분이 클래스가 아닌 **구조체**로 구현되어 있습니다.

여기까지만 살펴본다면 클래스의 상속 개념을 통해 공통 기능들을 모듈화하여 사용할 수 있었으나, 구조체 혹은 열거형의 경우에는 상속이 불가하기에 같은 타입에 대해서 공통적인 기능 구현을 위해서는 다른 방법을 이용해야 합니다.

이에 대한 해답은 **프로토콜** 과 **익스텐션**에 있습니다.

본격적으로 POP에 대하여 알아보기 이전에 프로토콜은 무엇이며, 익스텐션은 무엇인지 간단히 정리하겠습니다.

- **프로토콜** : 특정 역할을 수행하기 위한 메서드, 프로퍼티 등 사항들을 한 데 모아놓은 청사진.
- **익스텐션** : 기존 타입의 기능을 확장하도록 도와주는 기능.

프로토콜에는 채택 시 반드시 구현해야 하는 내용들이 담겨있으며 익스텐션에는 기존 타입의 기능들을 확장시켜 준다는 것을 우리는 이미 알고있습니다.

만일 특정 프로토콜을 정의하고 여러 타입에서 해당 프로토콜을 채택하여 각 타입마다 똑같은 내용들을 구현해야 한다면 얼마나 많은 코드들이 중복되어질까요?

**해당 프로토콜을 채택하는 데이터 타입을 만들 때 마다 코드는 중복될 것 입니다. 뿐만 아니라 추후 이를 유지보수한다면 정의한 모든 데이터 타입의 코드를 일일이 변경시켜줘야 하겠죠?**

이러한 단점들을 극복하고자 애플에서 제공하는 기능이 프로토콜과 익스텐션을 결합한 **프로토콜 초기구현** 입니다.

<br>

## 프로토콜 초기구현 (Protocol Default Implementation)
---

<br>

프로토콜 초기구현이란, 구현해야 할 내용들이 담겨있는 **프로토콜**과 타입의 기능을 확장시켜주는 **익스텐션**의 결합으로 만들어집니다.

정의되어진 프로토콜을 채택한 타입의 정의부에서 일일이 모든 프로토콜 내 요구사항을 구현할 필요 없이 익스텐션을 통해 미리 프로토콜의 요구사항을 구현해 놓을 수 있죠!

코드를 살펴보며 이해를 돕도록 하겠습니다!

```swift
// 프로토콜 정의
protocol Person {
    
    var name: String { get }
    var age: Int { get }
    
    func getName() -> String
    func getAge() -> Int
}

// 프로토콜 초기구현
extension Person {
    
    func getName() -> String {
        return self.name
    }
    
    func getAge() -> Int {
        return self.age
    }
}

struct student: Person {
    var name: String
    
    var age: Int
}

let student1 = student(name: "Jungsu", age: 27)
print("My name: \(student1.getName()), My Age: \(student1.getAge())")
// My name: Jungsu, My Age: 27
```

`Person` 이라는 프로토콜을 정의한 이후, 해당 프로토콜의 메서드를 초기구현 합니다.

그러면 `Person` 이라는 프로토콜을 준수하는 구조체는 해당 메서드를 따로 구현할 필요 없이 사용할 수 있게 됩니다.

물론, 변형을 하고 싶다면 재정의하여 사용할 수 있습니다.

이렇게 하나의 프로토콜을 정의하고, 초기 구현을 해놓는다면 여러 타입에서 해당 기능을 사용하고 싶을 때 해당 프로토콜을 채택하기만 하면 사용이 가능합니다.

여기에 제네릭을 이용한다면 더욱 유연한 프로토콜 사용이 가능해집니다.

<br>

## 제네릭과 연관값
---

<br>

```swift
// 프로토콜 정의
protocol Stackable {
    associatedtype item
    
    var items: [item] { get set }
    
    mutating func push(with item: item)
    
    mutating func pop() -> item?
}

// 프로토콜 초기 구현
extension Stackable {
    mutating func push(with item: item) {
        items.append(item)
    }
    
    mutating func pop() -> item? {
        if !items.isEmpty {
            return items.popLast()
        } else {
            return nil
        }
    }
}

// Stackable 프로토콜을 준수하는 제네릭 타입 구조체 정의
struct Stack<T>: Stackable {
    var items: [T]
    
    typealias item = T
}

var intStack: Stack<Int> = Stack<Int>(items: [1, 2, 3])
var stringStack: Stack<String> = Stack<String>(items: ["1", "2", "3"])

intStack.push(with: 4)
print(intStack.pop())
// 4

stringStack.push(with: "4")
print(stringStack.pop())
// 4
```

기존과 같이 프로토콜을 정의하고 익스텐션을 통하여 초기구현을 진행합니다.

이 때, 프로토콜 정의부를 살펴보면 `associated type` 이라는 키워드를 볼 수 있는데, 이는 해당 프로토콜을 채택하는 데이터 타입이 제네릭 타입을 이용할 경우 사용합니다.

<br>

## POP의 장점
---
<br>

- **가볍고 안전하다.**

    상속의 경우, 참조 타입이므로 참조 추적을 위한 비용이 많이 발생하기 때문에 속도측면에서 다소 느립니다.
하지만 POP를 통해 값 타입에서도 같은 기능을 제공할 수 있습니다.

- **값 타입의 상속 효과**

    Value 타입임에도 불구하고 마치 클래스 처럼 공통된 기능들을 쉽게 구현할 수 있습니다.

- **수직 구조 확장이 아닌 수평 구조의 기능 확장**
  
    Class의 경우 자식 클래스는 하나의 부모클래스만 상속할 수 있으며 수직적인 구조를 갖게됩니다.
    하지만, Protocol을 이용하면 수직 구조가 아닌 수평 구조로 기능을 확장시킬 수 있습니다.

- **제네릭과 연관값**

    보다 유연한 대처를 위하여 제네릭과 연관값 기능을 제공하며 이를 통해 POP의 힘은 더욱 강력해졌습니다.

    예를 들어, Swift의 Array의 경우 데이터 타입의 관계 없이 만들 수 있고 이들 모두가 그에 따른 메서드를 사용할 수 있습니다.