# get, set, didSet, willSet with Swift

<br>

프로퍼티 값을 연산하여 저장하는 `Computed Property`에 대하여 미리 알고 있어야 한다.

이번 시간에는 `Swift`에서 프로퍼티 초기화에 있어 이용되는 `get`, `set`, `didSet`, `willSet` 에 대하여 알아보자!

각각의 키워드를 보면 대략적인 느낌이 오듯 이는 일반적으로 OOP 패러다임에서 사용하는 `getter, setter` 메서드다.

즉, 프로퍼티 값을 초기화하고 이를 가져오는 기능을 제공한다.

<br>


## get, set in Swift
---

`Swift` 내에서 `get,set` 은 일반적으로 우리가 쓰는 `getter, setter` 와 매우 유사하다.

해당 프로퍼티에 직접 접목하는 방식으로 아래와 같이 사용한다.

<br>

```swift
var testProperty: Int {
    get {
        return testProperty
    }
    set(value) {
        testProperty = value
    }
}

print(testProperty)     // testProperty의 value 출력
testProperty = 123      // value = 123

```

위와 같이 코드를 작성하면 `Xcode` IDE에서 경고 혹은 에러를 띄운다.

`get` 과 `set`이 해당 프로퍼티에 직접적으로 연결되어 있기 때문에 `get{}`, `set{}` 에서 `testProperty`에 접근하면 `recursive`하게 자기 자신의 `get,set`이 호출되므로 위와 같이 사용하지 않는다.

따라서 이러한 점을 보완하기 위해 `저장소` 라는 개념을 이용한다.

여기서 말하는 저장소란, `get`, `set`을 사용할 때 연산된 값을 저장할 변수를 의미한다.

```swift
var _testProperty: Int  // 실제 값이 저장될 변수

var testProperty: Int {
    get { 
        return _testProperty
    }
    set(value) {
        _testProperty = value
    }
}
```

위 코드에서는 `_testProperty` 가 실제 값이 저장되는 변수다.

외부에서 `testProperty`의 값에 접근하거나 새로운 값이 할당될 경우 실제로 값이 저장되는 곳은 `testProperty` 가 아닌 `_testProperty`이다.

즉, `testProperty` 는 `_testProperty` 에 값을 저장하기 위해 일차적으로 연산의 결과를 저장하는 '저장소'가 된다.

이쯤되면 대략적인 `get,set` 의 사용목적이 궁금해진다.

두 개념은 아래와 같은 목적으로 사용된다.

> 1. property 초기화시 값 검증
> 
> 2. 타 property에 의존하는 property 값을 관리 할 때
>
> 3. `private`한 property 사용을 위해

<br>

`computed Property`를 읽기 전용 권한으로 구현할때는 `get` 블럭을, 쓰기 전용 권한으로 구현할때는 `set` 블럭을, 읽기&쓰기 모두 가능하게 하려면 `get,set` 블럭을 모두 구현해주면 된다.

<br>

```swift
struct Point {
    
    var x: Int = 0
    var y: Int = 0
    
    var oppositePoint: Point {
        get {
            return Point(x: -x, y: -y)
        }
        set(value) {
            x = -value.x
            y = -value.y
        }
    }
}

var test: Point = Point(x: 1, y: 2)     // Setter

print(test)                             // Getter : Point(x: 1, y: 2)

test.oppositePoint = Point(x:-3, y:-4)  // Setter 

print(test)                             // Getter : Point(x: 3, y: 4)
```

<br>

## didSet, willSet in Swift
---

`Swift`에서는 `Property Observer`로 `didSet, willSet` 을 제공한다.

이름대로 프로퍼티 값의 변경 직전, 직후에 대한 이벤트를 감지하며 해당 시점에 작업을 수행할 수 있도록 하는 기능을 지원한다.

기본적으로 아래와 같이 사용한다.

```swift
var testProperty: Int = 10 {
    didSet(oldValue) {
        //body , testProperty의 값이 변경된 직후 호출, oldValue에는 이전 testProperty 값이 들어간다.
    }

    willSet(newValue) {
        //body , testProperty의 값이 변경되기 직전에 호출, newValue에는 새로 초기화하고자 하는 값이 들어간다.
    }
}
```

참고로 `Property Observer`인 `didSet, willSet`을 사용하기 위해서는 `property` 값이 **반드시 초기화** 되어 있어야 한다.

두 개념은 `Model`에서의 변경사항을 `View`에 반영하고자 할 떄 빈번히 사용된다.

<br>

```swift
class Account {
    
    var balance: Int = 0 {
        willSet(newValue) {
            print("잔액: \(balance) -> \(newValue) 변경 예정")
        }
        
        didSet(oldValue) {
            print("잔액: \(oldValue) -> \(balance) 변경 완료")
        }
    }
}

let test = Account()

test.balance = 500

test.balance = 300

/*
output

잔액: 0 -> 500 변경 예정
잔액: 0 -> 500 변경 완료
잔액: 500 -> 300 변경 예정
잔액: 500 -> 300 변경 완료

*/

```

<br>

`Swift`에서 제공하는 `get`, `set`, `didSet`, `willSet`에 대하여 간단히 알아보았다.

이를 활용하면 더욱 편하며 직관적으로 코드를 작성할 수 있다.

이상으로 오늘 포스팅을 마치도록 한다.

