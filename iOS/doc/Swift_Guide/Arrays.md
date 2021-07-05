# Arrays

<br>

## 배열과 변이성
---

배열은 Swift에서 가장 빈번히 사용되는 collection 타입입니다.

여느 프로그래밍 언어에서 제공하듯 배열은 동일한 타입의 원소들에 대한 컨테이너이며 순서를 갖는다는 특징이 있습니다.

일반적으로 index를 통해 배열 내 각각의 원소들에 접근이 가능하죠.

```swift
// Fibonacci numbers
let fibs =  [0, 1, 1, 2 ,3, 5]
```

위와 같은 배열에서 `append(_:)` 를 이용하여 원소 추가를 시도하고자 한다면 컴파일 에러가 발생합니다.

위 배열을 `let` 예약어를 통해 상수값으로 정의되었기에 불변성을 지니기 때문입니다.

만일 우리가 변이성을 갖는 배열을 생성 하고 싶다면 아래와 같이 `var` 예약어를 통해 변수를 정의하여 사용하면 됩니다.

```swift
var mutableFibs = [0, 1, 1, 2, 3, 5]
mutableFibs.append(8)
print(mutableFibs)
// [0, 1, 1, 2, 3, 5, 8]
```


<br>

## 배열 변환
---

### Map

배열 내 모든 원소에 순차적으로 접근하여 특정 변환 작업을 진행하는 함수입니다.

```swift
var squared: [Int] = []
for fib in fibs {
    squared.append(fib * fib)
}
// squared: [0, 1, 1, 4, 9, 25]
```

위와 같이 배열 원소들이 각각 제곱값을 갖는 배열을 생성해내고자 할때는 반복문 대신 map을 통해 아래와 같이 한 줄로 처리가 가능합니다.

```swift
let squares = fibs.map { $0 * $0 }
```

훨씬 간결하고, 실수할 여지가 적어지고, 무엇보다 어수선한 코드가 사라져 더욱 깔끔해졌습니다.

이처럼 `map` 을 이용하면 배열 내 각각의 원소에 순차적으로 접근하여 특정 변환 작업을 거친 배열을 반환합니다.

위와 같이 작동하는 map을 Array 타입에 대한 extension으로 생성해보겠습니다.

```swift
extension Array {
    func jungsu_map<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        result.reserveCapacity(count)           // result 배열이 사용할 공간을 미리 예약합니다.
        for element in self {                   // self = Array<Element>
            result.append(transform(element))
        }
        return result
    }
}

let tmpArr = [0, 1, 2, 3, 4, 5]
let squaredArr = tmpArr.jungsu_map { $0 * $0 }
print(sqauredArr)
```

(참고로 실제 map은 위 로직과 유사하게 작성되었으나 완전히 동일하지는 않습니다.)

extension으로 만든 `jugnsu_map` 이라는 함수는 파라미터로 `transofrm` 이라는 클로저를 받습니다.

`transform` 클로저는 `(Element) -> T` 타입이며 각각의 원소에 클로저 연산을 진행한 결과 T 배열 타입 `[T]` 을 반환합니다.

여기서 `Element`는 제네릭 플레이스홀더로 배열 내 원소의 타입을 의미합니다.

`T` 는 새로운 플레이스홀더로 element 의 변환 결과값의 타입을 의미합니다.

`map` 함수는 `Element` 타입 혹은 `T` 타입이 무엇인지는 신경쓰지 않습니다.


<br>

### Filter

그 외 빈번히 사용되는 함수 중 하나가 `filter` 입니다.

`filter`는 이름 그대로 배열 내 원소들을 순차적으로 접근하여 특정 컨디션에 부합하는 원소만 남긴 배열을 반환합니다.

```swift
print((1...10).filter { $0 % 2 == 0} )
// [2, 4, 6, 8, 10]
```

이를 `map` 과 함께 조합하여 쓴다면 우리는 더욱 간결하고 가독성있는 코드로 원하는 결과를 쉽게 얻어낼수 있습니다.

예를 들어, 100보다 작은 제곱수 중 짝수를 찾아내보고자 한다면 아래와 같이 작성할 수 있겠죠?
```swift
(1..<10).map { $0 * $0 }.filter{ $0 % 2 == 0 }
// [4, 16, 36, 64]
```

범위 연산자를 통해 1~9까지의 숫자를 가지고, 이에 `map`을 통해 순차적으로 접근하여 제곱수를 구합니다. 이후 `filter`를 통해 짝수 값을 판별해냅니다.

이러한 기능을 하는 `filter` 는 아래와 같이 직접 구현해볼수 있습니다.

```swift
func jungsu_filter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for element in self where isIncluded(element) {     // where 절을 통해 반복문에 조건을 추가합니다.
            result.append(element)                          // isIncluded 클로저 조건을 통과한 원소만이 결과값에 추가됩니다.
        }

        return result
    }
```

<br>

### Reduce

`map` 과 `filter`와 같이 배열을 기반으로 새로운 혹은 변경된 배열을 얻어내는 함수들도 있지만, 배열 내 모든 원소들을 기반으로 새로운 값을 생성해내는 함수도 있습니다.

예를 들어, 배열 내 모든 원소값을 더한 값을 구해본다고 해보겠습니다.

```swift
let fibs = [0, 1, 1, 2 ,3, 5]
var total = 0
for num in fibs {
    total = total + num
}
// total: 12
```

단순히 반복문을 이용한다면 위와 같이 작성하여 원하는 결과를 얻어낼 수 있습니다.

`reduce` 는 위 로직과 유사한 패턴을 가지지만 두 가지를 추상화하였습니다.

- 초기값 (위 예시에서는 0입니다.)
- 결과를 축적할 값 (위 예시에서는 total 입니다.)

위 로직을 `reduce`를 이용하여 풀어보면 아래와 같이 간결해집니다.

```swift
let total = fibs.reduce(0) { total, num in total + num }
```

<br>

### Flattening Map

코드를 작성하다보면 변환 클로저가 단일 원소를 반환하는 `map`이 아닌 배열을 반환하는 `map` 함수의 필요성을 느낄때가 있습니다.

예를 들어, MarkDown 파일을 읽어들여서 내부에 기재되어 있는 URL link들을 배열로 반환하는 함수가 있다고 생각해보겠습니다.

그러면 함수는 아마 아래와 같은 형태를 띄겠죠?

```swift
func extractLinks(markdownFile: String) -> [URL]
```

만일 MarkDown 파일이 여러개고 모든 파일을 순차적으로 접근하여 내부에 기재된 link를 모두 추출하여 하나의 배열로 반환하고 싶을때는 어떻게 해야할까요?

이러한 경우 `map` 을 수행한 결과 배열을 가져오고 이들을 결합하여 최종적으로 단일 배열로 반환해야합니다.

`flatmap`은 변환 클로저가 배열을 반환한다는 것을 제외하고는 `map` 과 매우 유사합니다.

```swift
extension Array {
    func jungsu_map<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        for element in self {
          result.append(transform(element))       // transform 클로저 타입: (Element) -> T
        }

      return result
    }

    func jungsu_flatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var result: [T] = []
        for element in self {
            result.append(contnetsOf: transform(element))   // transform 클로저 타입: (Element) -> [T]
        }

        return result
    }
}
```

차이가 보이시나요??

함수의 파라미터인 변환 클로저 `transform`의 반환값에 가장 큰 차이가 존재합니다.

`map`의 변환 클로저는 단일 원소를 반환하지만 `flatMap`의 변환 클로저의 경우 배열을 반환합니다.

실제 예시를 살펴보시면 좀 더 이해가 수월할거에요!

```swift
let numbers = [0, 1, 2, 3, 4, 5]
let characters = ["a", "b", "c", "d", "e", "f"]

let result = numbers.jungsu_flatMap { number in
    characters.map { character in
        (number, character)
    }
}

/*
  [(0, "a"), (0, "b"), (0, "c"), (0, "d"), (0, "e"), (0, "f"), (1, "a"), (1, "b"), (1, "c"), (1, "d"), (1, "e"), (1, "f"), (2, "a"), (2, "b"), (2, "c"), (2, "d"), (2, "e"), (2, "f"), (3, "a"), (3, "b"), (3, "c"), (3, "d"), (3, "e"), (3, "f"), (4, "a"), (4, "b"), (4, "c"), (4, "d"), (4, "e"), (4, "f"), (5, "a"), (5, "b"), (5, "c"), (5, "d"), (5, "e"), (5, "f")]
*/
```



