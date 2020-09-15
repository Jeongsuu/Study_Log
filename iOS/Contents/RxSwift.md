# RxSwift

본 문서에는 RxSwift 공부 내용을 기재한다.

<br>

## RX : ReactiveX
---

RX는 ReactiveX의 준말이다.

**[ReactiveX Official](http://reactivex.io/) 에 들어가면 `observable` 한 스트림을 가지고 비동기 프로그래밍을 구현하기 위한 API를 제공한다고 되어있다.**

<br>

## Sync & Async
---

Rx는 비동기 프로그래밍을 위한 API 라고 앞서 확인하였다.

그렇다면 과연 동기는 무엇이고 비동기는 무엇인지 각각의 방법에 어떠한 장단점이 있는지 간단히 살펴보고 넘어가도록 하자.

<br>

**동기(Synchronous)**

- **동기란 말 그대로 통신에서의 요청과 그에 대한 결과가 동시에 일어난다는 의미이다.** 즉 요청을 하면 시간이 얼마가 걸리든 요청한 자리에서 결과가 주어져야 한다.

- 요청(request) 과 결과(response)가 한 자리에서 동시에 일어난다.

- A 노드와 B 노드 사이의 작업 처리 단위(Transaction)을 동시에 맞춘다.

**비동기(Asynchronous)**

- **비동기는 동기의 반댓말로 요청과 결과가 동시에 일어나지 않는다는 것을 의미한다.** 즉 요청의 결과값이 언제오던지 상관않고 내 갈 길 가겠다는 말이다.

- 요청한 그 자리에서 결과가 주어지지 않는다.

- 노드 사이의 작업 처리 단위를 동시에 맞추지 않아도 된다.

<br>

**각각의 장단점**

> 동기 방식은 설계가 매우 간단하고 직관적이라는 장점을 갖는다. 하지만 결과가 주어질 때 까지 아무것도 못하고 대기해야 하기때문에 리소스 낭비를 초래하는 단점이 있고, 비동기는 동기보다 복잡하지만 결과가 주어지는데 시간이 걸리더라도 잉여시간을 다른 작업에 투자하여 자원을 효율적으로 사용할 수 있다는 장점이 있다.

<br>

### RxSwift를 왜 쓰는건가?

- 높은 가독성 -> Rx 사용시 선언형 프로그래밍이 가능하기 때문에 / 유지보수성

- 비동기 처리 일원화
    - GCD, KVO, Delegate, NotificationCenter

- 입출력만 체크하면 되기 때문에 `UnitTest` 에 매우 용이함.

<br>

### Observable

- RxSwift의 핵심적인 개념

- 이벤트를 시간 흐름에 따라 전달하는 전달자

- 비동기로 동작하는 일련의 항목들을 나타내는 시퀀스

**Observable은 세 가지 타입의 이벤트를 배출하고 Observer가 Observable을 구독하여 이 이벤트를 받을 수 있다.**

- **next** : next는 이름 그대로 다음 데이터를 가져온다. 가져온 데이터를 옵저버가 받는다. (Emission)

- **completed** : completed는 시퀀스를 성공적으로 마친다. 더이상 이벤트를 배출하지 않는다. (Notification)

- **error** : error는 오류가 발생하여 마친 경우이다. 이 또한 더이상 이벤트를 배출하지 않는다. (Notification)

completed 와 error 이벤트는 옵저버블 라이프 사이클 중 가장 마지막에 전달된다.


**작동 방식은 `Observer` 가 `Observable`을 구독하고, `Observable` 이 이벤트를 배출하면 `Observer`가 이에 반응하는 방식이다.**


옵저버블은 옵저버에게 이벤트를 전달한다.

옵저버는 옵저버블을 감시하고 있다가 전달받는 이벤트를 처리한다.

옵저버블을 감시하는 것을 `subscribe` 로 표현한다.

간단한 예시로 observable 을 생성하고 구독하는 코드는 아래와 같다.



```swift
import RxSwift

// 옵저버블 생성
let observable = Observable.of(1, 2, 3)

// 구독
observable.subscribe(
    // Next 이벤트 발생 시
    onNext: { element in
        print(element)
    }, 
    // Completed 이벤트 발생 시
    onCompleted: {
        print("completed")
    }
)

```

위 코드 실행시 1, 2, 3 과 "completed" 문자열이 순차적으로 출력된다.

`Observable.of()` 가 (1,2,3)을 가지는 `Observable` 인스턴스를 생성하는 함수이고, `subscribe()`가 `Observable` 을 구독할 때 사용하는 함수다.

`Observable`을 생성하는 함수는 .of() 외에도 .just(), .from() 등이 있다.


<br>

### Dispose

`Observer` 는 기본적으로 completed 또는 error 이벤트가 발생할 떄 까지 구독을 유지한다. 그러나 사용자가 이를 직접 제어할 수 도 있다. 

앞서 구독을 시작할 때는 `subscribe()`를 이용하였는데 해당 메소드는 구독 취소를 위해 필요한 `Disposable` 객체를 반환한다.

이 `Disposable` 객체의 `dispose()` 메소드를 사용하면 completed || error 이벤트 발생 이전에도 구독을 취소할 수 있다.


```swift
import RxSwift

// 옵저버블 생성
let observable = Observable.of(1, 2, 3)

// 구독 및 Disposable 객체 리턴
let subscription = observable.subscribe(
    // Next 이벤트 발생 시
    onNext: { element in
        print(element)
    },
    // Completed 이벤트 발생 시
    onCompleted: {
        print("completed")
    }
)

// observable 구독 취소
subscription.dispose()
```

`Observable`을 구독하며 반환받은 `Disposable` 객체를 저장하여 `dispose` 를 수행한다.

위와 같이 개별적으로 구독을 관리할 수도 있으나, observable 구독의 수가 많아지면 이를 관리하는 것 또한 쉽지 않다.

이러한 경우를 방지하여 `RxSwift` 에서는 `DisposeBag` 을 제공한다.

`DisposeBag` 을 사용하면 여러개의 `Disposable` 객체를 한 곳에 저장하여 단번에 모두 `Dispose` 할 수 있다.

```swift
import RxSwift

let disposeBag = DisposeBag()
let observable = Observable.of(1, 2, 3) 

observable.subscribe(
    onNext: { element in 
        print(element)
    },
    onCompleted: {
        print(“completed”)
    }
).disposed(by: disposeBag)
```

<br>

### 연산자

**just**

```swift

import RxSwift

let disposeBag = DisposeBag()
let element = "test"

Observable.just(element)
    .subscribe(onNext: { str in
        print(str)
    })
    .disposed(by: disposeBag)

// "test"

Observable.just(["Hello", "World"])
    .subscribe(onNext: { str in
        print(str)
    })
    .disposed(by: disposeBag)
    
// ["Hello", "World"]
// completed
```

위와 같이 element를 `just` 연산자의 파라미터로 전달하면 element를 그대로 방출하는 옵저버블이 생성된다.

`just` 연산자는 하나의 인자만 수용할 수 있다.

<br>

**of**
```swift
import RxSwift

let disposeBag = DisposeBag()
let apple = "apple"
let orange = "orange"
let kiwi = "kiwi"

Observable.of(apple, orange, kiwi)
    .subscribe { element in print(element) }
    .dispose(by: disposeBag)

// next("apple")
// next("orange")
// next("kiwi")
// completed

Observable.of([1, 2], [3, 4], [5, 6])
    .subscribe { element in print(element) }
    .dispose(by: disposeBag)

// next([1, 2])
// next([3, 4])
// next([5, 6])
// completed

```

`of` 연산자로 옵저버블 객체 생성시에는 가변 파라미터를 전달할 수 있기 때문에 여러개의 값을 동시에 전달할 수 있다.

**즉, 방출할 요소를 원하는 수 만큼 전달할 수 있다.**

<br>

**from**

```swift
import RxSwift

let disposeBag = DisposeBag()
let fruitArr = ["apple", "orange", "kiwi"]

Observable.from(fruitArr)
    .subscribe(onNext: { str in
        print(str)
    })
    .disposed(by: disposeBag)

// apple
// orange
// kiwi

```

**배열 또는 시퀀스를 전달받고 배열에 포함된 요소들을 하나씩 순차적으로 방출한다.**

- 하나의 요소를 방출하는 옵저버블 생성시에는 **just** 

- 두 개 이상의 요소를 방출하는 옵저버를 생성할때는 **of**

- **just** 와 **of** 연산자는 인자를 그대로 방출하기 때문에 배열을 전달하면 배열을 방출한다.

- 배열에 저장된 요소를 순차적으로 하나씩 방출하는 옵저버블이 필요하다면 **from** 연산자를 사용한다.

<br>

**filter**

```swift

import RxSwift

let disposeBag = DisposeBag()

Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    .filter{ $0 % 2 == 0 }
    .subscribe(onNext: { n in
        print(n)
    })
    .disposed(by: disposeBag)

// 2
// 4
// 6
// 8
// 10

```

filter 연산자는 클로저를 파라미터로 받는다.

filter 내에서 True 값을 반환하는 요소가 연산자가 리턴하는 옵저버블에 포함된다.

<br>

**combineLatest**

```swift

import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case eror
}

let greetings = PublishSubject<String>()
let languages = PublishSubject<String>()

Observable.combineLatest(gereetings, languages) { lhs, rhs -> String in
    return "\(lhs) \(rhs)"
}
    .subscribe { print($0) }
    .disposed(by: disposeBag)

greetings.onNext("Hi")
languages.onNext("RxSwift")
// next(Hi RxSwift)

greetings.onNExt("Hello")
// next(Hello RxSwift)

greetings.onCompleted()
languages.onCompleted()
// completed

```

combineLatest 연산자는 source Observable을 결합하여 result Observable을 방출한다.

위에서 사용한 combineLatest는 두 개의 옵저버블과 클로저를 파라미터로 받는다.  (다양한 오버로딩 버전을 제공한다.)

연산자가 리턴한 옵저버블이 언제 이벤트를 방출하는지 이해하는 것이 핵심이다.

<br>

**map**

```swift
Observable.just("Hello")
    .map { str in "\(str) RxSwift" }
    .subscribe(onNext: {str in
        print(str)
    })
    .disposed(by: disposeBag)
    
// Hello RxSwift
```

`just` 로 Hello를 생성하고 이후 `map`이 진행된다.

`map`을 통해 전달받은 요소에 대하여 특정 연산 작업을 한 후 이로 변환하여 계속하여 진행한다.

```swift

Observable.from(["with", "여정수"])
    .map { $0.count }      // map을 통한 mapping 연산 ( "with" -> 4, "여정수" -> 3)
    .subscribe(onNext: { str in
        print(str)
    })
    .disposed(by: disposeBag)

// 4
// 3
```

```swift

Observable.just("800x600")      // "800x600" 이라는 옵저버블 생성
    .map { $0.replacingOccurrences(of: "x", with: "/")}      // "x" -> "/" 로 치환
    .map { "https://picsum.photos/\($0)/?random" }  // 치환한 문자열을 url에 합성
    .map { URL(string: $0) }        // 문자열을 URL 타입으로 변환
    .filter { $0 != nil }           // nil이 아닌 경우를 필터링
    .map { $0! }                    // 옵셔널 언래핑
    .map { try Data(contentsOf: $0) }   // 해당 URL에 이미지 데이터 다운로드.
    .map { UIImage(data: $0) }          // 다운로드한 데이터를 이미지로 변환.
    .subscribe(onNext: { image in       
        self.imageView.image = image    // 변환한 이미지를 적용
    })
    .disposed(by: disposeBag)
```


---
---

<br>

```swift

Observable.just("Hello World")
    .subscribe { event in
        switch event {
            case .next(let str):
                break
            case .error(let err):
                break
            case .completed:
                break
        }
    }
    .disposed(by: disposeBag)
```

위와 같이 `subscribe` 시 이벤트의 유형에 따라 switch ~ case 구문으로 분기 작업을 진행해주는 것이 정석적인 흐름이다.

하지만 `next` 이벤트 처리만 진행하고자 할 때는 앞서 살펴봤던 것 과 같이 `subscribe` 시 `onNext` 로만 처리할 수 있다.

<br>

### Scheduler

`observeOn`, `subscribeOn` 메소드를 통해서 스케줄러 설정을 할 수 있다.

```swift
Observable.from([0, 1, 2, 3, 4, 5])
    .observeOn(backgroundSchedular)
    .map { n in
        print("백그라운드 스케줄러에서 실행")
    }
    .observeOn(MainSchedular.instance)
    .map { n in
        print("메인 스케줄러에서 실행")
    }
```

`observeOn` 방식은 위와 같은 방식으로 사용할 수 있다.

`observeOn`은 지정하는 위치 이후의 스트림에서 해당 스케줄러가 적용된다. 하지만  `subscribeOn` 은 `subscribe` 될 때 부터 해당 스트림에 적용하겠다는 의미이다.

### 정리
---

옵저버블은 옵저버에게 이벤트를 전달한다.

옵저버는 옵저버블을 감시하고 있다가 전달받는 이벤트를 처리한다.

옵저버블을 감시하는 것을 `subscribe` 로 표현한다.

- 하나의 요소를 방출하는 옵저버블 생성시에는 **just**

- 두 개 이상의 요소를 방출하는 옵저버를 생성할때는 **of**

- **just** 와 **of** 연산자는 인자를 그대로 방출하기 때문에 배열을 전달하면 배열을 방출한다.

- 배열에 저장된 요소를 순차적으로 하나씩 방출하는 옵저버블이 필요하다면 **from** 연산자를 사용한다.

- **filter** 연산자는 클로저를 파라미터로 받으며 클로저 내에서 True를 반환하는 값을 연산자가 리턴하는 옵저버블에 포함시킨다.

- **map** 은 고차함수 map과 동일한 기능을 한다. 해당 요소에 지정 연산을 진행하여 데이터를 가공하는 기능.


<br>

### Reference
---

- [Reactivex.io](http://reactivex.io/documentation/operators.html)