# Higher-order Function in Swift

이번 시간에는 iOS 앱 개발을 위해 `Swift` 를 공부하면서, PS 언어로 `Swift` 를 사용하면서 익히 보고 들었던 고차함수에 대해 알아보려고 한다.

<br>

## What is Higher-order Function
---

자, 그러면 고차함수에 대하여 살펴보기 이전에 **고차함수**가 무엇인지 먼저 개념을 살펴보도록 하자!

<br>

**고차함수(Higher-order Function)**

> - 함수의 인자로 함수를 취하거나 결과를 함수로 반환하는 함수
> 
> - 스위프트에서 유용한 고차함수는 대표적으로 `map`, `filter`, `reduce` 가 있다.

<br>

함수의 인자로 함수를 가지는 형태 또는 함수의 반환값이 함수 형태인 함수를 **고차함수**라고 칭한다!

이를 통해 함수의 내부 코드를 건드리지 않고도 외부에서 실행 흐름을 추가할 수 있기에 **함수의 재활용성, 재사용성**의 이점을 얻을 수 있다.

오케이, 이제 고차함수가 뭔지 대충 느낌이 온다.

이제는 실전에서 자주 사용되는 고차함수들을 살펴보도록 한다.

<br>

## map
---

> map : 컬렉션 내부의 기존 데이터를 변형하여 새로운 컬렉션을 생성하는 함수

`map`은 배열 내부의 원소를 하나씩 `mapping` 해준다고 생각하면 된다.

각 요소에 대한 값을 변경하고자 할 때도 사용하고, 해당 결과들을 배열 상태로 반환할때도 사용한다.

#### Declaration

```swift
func map<T>(_ transform: (String) throws -> T) rethrows -> [T]
```

#### Example
```swift

let names = ["chris", "Ewa", "Alex", "Barry", "Daniella"]

let nameArr = names.map { $0 + "'s name"}

print(names)

// output : ["chris\'s name\'", "Ewa\'s name\'", "Alex\'s name\'", "Barry\'s name\'", "Daniella\'s name\'"]
```

`map` 의 `trailing closer` 를 매개변수, 반환 타입, 반환 키워드 등을 생략하여 간략화하였다.

이를 통해 `names` 라는 배열 내 각각의 원소에 순차적으로 접근하여 이를 `$0` 이 받고 해당 `String`에 `'s name'` 이라는 문자열을 더한 원소들을 갖는 컬렉션 `nameArr`을 정의했다.

이렇게 `map`을 이용하여 단 한줄의 코드로 배열 내 모든 원소에 접근이 가능하며 연산 또한 가능하다.


<br>

## filter
---

`filter` 는 이름 그대로 컨테이너 내부의 값을 필터링하여 추출하는 함수다.

<br>

#### Declaration
```swift
func filter(_ isIncluded: (String) throws -> Bool) rethrows -> [String]
```

`isIncluded` 는 필터링 하고자 하는 항목이 포함되는지 또는 제외되는지를 나타내기 위해 `Bool`값을 반환해야 한다.



#### Example
```swift
let numArr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let oddNum = numArr.filter { $0 % 2 != 0 }

print(oddNum)

//output : [1, 3, 5, 7, 9]

```

위 예제는 1 ~ 10 까지의 정수 중 홀수를 찾아내는 예제다.

1 ~ 10 까지의 정수 배열 `numArr`로 부터 `filter`를 이용해 홀수를 찾아냈다.

<br>

## reduce
---

`reduce`는 함수명 그대로 축약시키는 역할을 한다.

클로저를 통해 각 항목들을 비교하여 일치하는 결과물을 가진 아웃풋을 반환한다.

<br>

#### Declaration
```swift
func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Int) throws -> Result) rethrows -> Result
```

`initialiResult` 는 초기값을 의미한다.


#### Example
```swift
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// let sum = numbers.reduce(0, {$0 + $1})

let sum = numbers.reduce(0) {$0 + $1}

print(sum)

// output : 55
```

후행 클로저의 경우에는 인자값과 분리하여 클로저를 작성할 수 있기에 해당 예시도 작성하였다.

`reduce`의 초기값을 0으로 설정하며 `nextPartialResult`의 값으로 현재 인자와 다음 인자값을 더한다. 

이를 배열 내 원소들을 순회하며 반복하면 배열 내 원소들의 합이 최종적으로 저장된다.




