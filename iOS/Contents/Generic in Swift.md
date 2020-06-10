# Generic in Swift

<br>

## Generic?
---

많은 프로그래밍 언어에서 이용되는 개념 `Generic`은 `Swift`에서도 지원한다.

제네릭 코드는 코드를 더욱 유연하게 작성할 수 있고, 재사용이 가능한 함수와 타입을 지원하여 작업할 수 있도록 요구사항을 정의한다.

이를 통해 중복을 피하고, 의도를 명확히 하여 추상적인 방법으로 코드를 작성할 수 있다.

<br>

제네릭은 `Swift`에서 가장 강력한 기능 중 하나로 실제로  `Swift` 표준 라이브러리 대다수는 제네릭 코드로 만들어져있다.

```swift
let strArr = [String]()
let intArr = [Int]()
```

`Swift`의 배열과 딕셔너리 타입은 제네릭 타입이다, 그렇기에 우리가 배열을 생성할 때  `Int` 값을 갖는 배열이나 `String` 값을 갖는 배열 또는 다른 타입 등으로 유연하게 배열을 생성할 수 있었던 것이다.


그렇다면 제네릭이 어떠한 경우에 이용되는지 살펴보자!

<br>

## Problem solve with Genereics
---

아래 예제는 `Non-Generic`한 일반적인 함수다.

```swift
func swapInt(_ a:Int, _ b: Int) {
    let tmp = a
    a = b
    b = a
}
```

위 함수는 정수형 타입의 두 개의 인자를 전달받아 두 값을 서로 변경시킨다.

`swapInt` 함수는 `Int` 타입에 한해서만 함수를 실행할 수 있다.

`String` 타입, `Double` 타입과 같은 다른 타입은 지원하지 않는다.

그러면 아래와 같이 또 해당 타입에 맞는 함수를 정의해줘야 한다.

```swift

func swapString(_ a: String, _ b: String) {
    let tmp = a
    a = b
    b = a
}

func swapDouble(_ a: Double, _ b: Double) {
    let tmp = a
    a = b
    b = a
}
```

위 3개의 함수는 하는 일은 똑같은데 전달받는 인자의 타입만 다르다.

이러한 경우, 제네릭의 유연성을 통해 단 하나의 함수로 모든 타입을 대체할 수 있다.

```swift

func swapValue<T>(_ a: T, _ b: T) {
    let tmp = a
    a = b
    b = a
}
```

제네릭을 이용한 함수 정의시에는 함수의 이름 뒤에 `<T>` 타입을 덧붙힌다.

이후 인자 값은 `T` 를 갖도록 한다.

이를 통해 실제로는 해당 함수가 호출될 떄 마다 전달된 인자에 따라 `Type`이 결정된다.

위에서 쓰인 `T`는 타입 인자(`Type Parameters`) 라고 부른다.

타입 인자는 자리를 표시하기 위한 타입을 명명하고 함수 이름 뒤에 바로 사용한다.

타입 인자를 정하면 함수의 인자 타입을 정의하는데 사용하거나 함수의 반환 타입 또는 함수 내 타입 표시 등에 사용할 수 있다.

이때 타입 인자는 하나 이상의 타입 인자를 사용할 수 있으며, 꺽쇠 안에 타입 인자의 이름을 콤마로 분리하여 아래와 같이 작성한다.

```swift
func typeParam <T, M> 
```

<br>

## How to use Type Param
---

제네릭, 타입 인자에 대해 알아보았으니 이제는 이를 실제로 어떻게 사용하는지 알아본다.


대표적인 예시로 우리가 자주 이용하는 `Stack` 자료구조에 대해 살펴본다.

`Non-generic` 한 `Int` 타입의 스택을 생성해본다.

```swift

struct intStack {
    var stack = [Int]()

    mutating func push(item: Int) {
        stack.append(item)
    }

    mutating func pop() -> Int {
        return stack.popLast()
    }
}
```

위 스택을 단순히 `Int` 타입만 수용하는 스택이 아닌 보다 유연한 스택을 만들어보자!

```swift

struct Stack<T> {
    var stack = [T]()

    mutating func push(item: T) {
        stack.append(item)
    }

    mutating func pop() -> T {
        return stack.popLast()
    }

}
```

`Generic Type`의 스택은 기존 타입 `Int`를 대신하여 자리 표시 타입 인자로 `T`를 사용한다.

타입 인자는 꺽쇠 `<T>`를 구조체 이름 뒤에 바로 위치해야 한다.

`T`는 타입을 위한 인자이며, 장래 타입은 `T`로서 구조체 정의 내 어디에서든 접근이 가능하다.

위 예시에서는 세 곳에서 참조하였다.

- `T` 타입의 `stack` 이라는 빈 배열 생성
- `push` 시 `T` 타입의 아이템 참조
- `pop` 시 `T` 타입의 아이템 반환

<br>
<br>

```swift
struct Stack<T> {
    
    var stack = [T]()
    
    mutating func push(item: T) {
        stack.append(item)
    }
    
    mutating func pop() -> T {
        return stack.popLast()!
        
    }
}

var intStack = Stack<Int>()
intStack.push(item: 1)
intStack.push(item: 2)
print(intStack)
print("pop: \(intStack.pop())")


var strStack = Stack<String>()
strStack.push(item: "test")
strStack.push(item: "Good")
print(strStack)
print("pop: \(strStack.pop())")

/*
Stack<Int>(stack: [1, 2])
pop: 2
Stack<String>(stack: ["test", "Good"])
pop: Good
Program ended with exit code: 0
*/
```