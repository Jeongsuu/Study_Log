# Dive in Closure

본 문서에서는 알다가도 모르겠는 `Closure`에 대하여 확실히 알아보도록 한다.

<br>

## 클로저란
---
우리는 함수를 정의할떄 `func` 이라는 키워드를 이용해 정의해왔다.

클로저는 함수와 동일한 기능을 하되, `func`키워드와 함수명이 없는 함수이다.

흔히들 익명함수라고 부르기도 한다.

클로저의 기본 문법에 대해 먼저 살펴보도록 하자.

```swift
{ (parameters) -> Return Type in 
    body
}
```

`()` 사이에 인자를 받고 `->`를 통해 반환 타입을 명시한다.

이후 `in` 키워드 뒤에 나오는 부분이 실행할 코드를 기재하는 클로저의 몸체 부분이다.

<br>


### Func vs Closure
---

함수와 클로저의 차이점에 대해 간단히 살펴보도록 한다.

`Function`

- `func` 키워드를 통해 정의한다.
- 이름을 갖는다.
- `in` 키워드가 존재하지 않는다.

`Closure`

- `func` 키워드가 존재하지 않는다.
- 이름을 갖지 않는다.
- `in` 키워드를 통해 인자 & 반환타입과 몸체를 분리한다.


클로저는 `iOS` 개발시 상당히 많은 부분에서 응용되어 사용된다.

가독성이 좋기에 다양한 축약형이 존재한다.

간단히 축약형들에 대하여 살펴보도록 한다.


**1. return 키워드 생략**

```swift
var Hello = { (name: String) in return "Hello \(name)"}

var Hello = { (name: String) in "Hello \(name)"}
```

인자를 전달받으면 해당 `Hello (인자)`를 출력하는 클로저이다.

첫번째 코드에는 `return` 키워드가 사용되었으나 두번째 코드에서는 `return` 문이 생략되었다.

이렇듯, 클로저에서는 `return` 키워드를 생략할 수 있다.

<br>

**2. 매개변수 타입 생략**
```swift
var Hello: (String) -> String = {"Hello \($0)"}
```

변수의 타입을 명시해주면 매개변수의 타입 또한 생략이 가능하다.

<br>
클로저는 다양한 용도로 사용된다.

그 중 대표적인 용도가 **전달인자로서의 사용**이다.

**전달인자로서의 사용**
```swift
let add: (Int, Int) -> Int = add = {$0 + $1}
let sub: (Int, Int) -> Int = sub = {$0 - $1}
let div: (Int, Int) -> Int = div = {$0 / $1}
let mul: (Int, Int) -> Int = mul = {$0 * $1}

func calc(a:Int, b:Int method:(Int, Int) -> Int) -> Int {
    return method(a,b)
}

print(calc(a:4, b:2, method:add)) // 6
print(calc(a:4, b:2, method:sub)) // 2

```

위와 같이 클로저는 함수의 전달인자로 사용될 수 있다.

**후행 클로저**

만일, 클로저가 함수의 마지막 전달인자이거나 전달인자가 클로저 하나 뿐이면 전달인자로 넘기지 않고 이를 함수 호출후 중괄호를 통해 클로저를 구현하여 인자 전달이 가능하다. 이를 **후행 클로저**라고 부른다.

```swift
result = calculate(a:3, b:2) { (left:Int, right:Int) -> Int in
    return left + right
}

// 위 코드는 아래와 같이 축약이 가능하다.

result = calculate(a:3, b:2) {$0 + $1}

```

이렇게 간단히 클로저의 기본 문법과 축약형에 대해 알아보았다.

이제는 보다 심화된 내용에 대하여 정리해보도록 한다.

<br>

### Closure 는 Reference Type
---

기본적으로 클로저는 `Reference Type`이다. 

앞서 우리는 클래스와 구조체는 각각 `Reference Type` & `Value Type` 이라고 배웠던 기억이 있다.

맞다, 클래스를 공부할적에 배웠던 `Reference Type`과 동일한 의미다.

즉, `Call By Reference` 방식으로 객체를 가리키고 있는 메모리의 주소값을 복사해오는 방식이다.

매개변수로 클로저에서 사용되는 매개변수는 값을 복사하는게 아니라 해당 값을 참조하여 사용하게 된다.

말로 표현하니 필자 또한 잘 와닿지가 않는다..

코드로 표현해보자!

```swift
var a:Int = 1
var b:Int = 0

var closure = {print(a,b)}

closure()       // 1, 0

a = 0
b - 1

closure()       // 0, 1
```

위와 같이 클로저 내부의 `a,b`는 외부의 `a,b`값을 `CBV` 방식으로 참조하여 가져온다.

이러한 방식으로 값을 참조하게 된다면 외부에서 값이 변경되면 참조하고 있는 값 또한 즉각 변경된다.

**꼭 명심하자, 클로저는 기본적으로 `Reference Type`이다!**

<br>

### Capture List
---
이것 또한 너~~~~~~~~~~~~무나도 중요하다...!

예시 코드나 오픈소스들을 살펴보면 `CaptureList`가 상당히 많이 쓰였다!

`Capture List` 라는 합성어는 이름 그대로 정보를 캡처해버리는것을 의미한다.

아래 예시 코드를 살펴보도록 하자!

```swift
var index = 0
var closureArr: [() -> ()] = []

for _ in 1...5 {
    closureArr.append({print(index)})
    index += 1
}

for i in 0..<closureArr.count {
    closureArr[i]()
}
```

위 코드의 예상 아웃풋을 곰곰히 생각해보자!

위 코드의 아웃풋은 0, 1, 2, 3, 4 가 아닌 5, 5, 5, 5, 5 다.

왜냐하면 `closureArr.append()`에서 변수 `index`가 루프를 돌면서 최종 5가 되는데, 클로저는 변경된 `index`값 5를 참조하기 때문이다.

이러한 예상치 못한 결과를 방지하고자 사용하는 것이 `Capture List`이다.

```swift
var index = 0
var clousreArr:[() -> ()] = []

for _ in 1...5 {
    closureArr.append({[index] in print(index)})
    index += 1
}

for i in 0..<closureArr.count {
    closureArr[i]()
}
```

위 코드의 결과값은 0, 1, 2, 3, 4다.

이전 코드와 다른점은 클로저 내부에 참조 변수 `index`를 `[index]`로 표기한 것이다.

이렇게 참조하고자 할 변수에 대괄호를 붙여주는 것이 캡처 리스트를 사용하겠다는 명시를 의미한다.

**캡처 리스트를 사용시, 캡처 시점은 클로저가 생성될 때 캡처를 진행한다.**

즉, `index`가 참조하고 있는 값을 캡처하고 클로저 내부에 저장하여 값에 접근하겠다는 의미이다.

더욱 간단한 예시를 통해 확실한 이해를 돕자!

```swift
var c = 0
var d = 0

let smartClosure: () -> () = { _ in print(c,d)}

smartClosure()      // 0, 0

c = 6
d = 9

let smartClosure: () -> () = { [c,d] in print(c,d)} 

smartClosure()
```

위와 같은 코드가 있다고 가정해보자. 

위 코드에서 마지막으로 호출한 클로저의 결과값은 `0,0` 이다.

`in` 키워드 앞에 `[]`를 통해 변수를 감싸주면 클로저는 더이상 기존 변수를 참조하지 않는다!

대신 클로저는 이를 복사하여 클로저 내에 자체 복사본을 만들어 사용한다!

**결과적으로, 기존 변수의 값이 변경되더라도, 클로저는 더이상 참조하지 않기 때문에 전혀 상관하지 않는 독립군이다.**


>단, 캡처 리스트 내 명시된 요소가 참조 타입이 아닌 경우에만 클로저가 생설될 떄 캡처를 진행한다. 
>
>만일 참조 타입이라면 클로저가 호출될 때 캡처를 진행한다.


<br><br>

### 참고자료
- https://blog.bobthedeveloper.io/swift-capture-list-in-closures-e28282c71b95

## 요약

- **클로저는 `func`, 이름이 없는 익명 함수다.**
- **다양한 축약형이 존재한다.**
- **기본적으로 클로저는 `Reference Type`이다.**
- **캡처 리스트는 참조하고 있는 값을 클로저 실행시 캡처하여 사용하고자 할 때 사용하는 기능이다.**


